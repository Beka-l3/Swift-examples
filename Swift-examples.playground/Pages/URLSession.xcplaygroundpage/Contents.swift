import Foundation


/// Cool framework to interact with internet

/// To work with it
/// - Create configuration for a session
///   -- default (store in memory, cache, etc)
///   -- empheral (do not store, good for sensetive data)
///   -- background
///
/// - Then create a session with the configuration
///
/// - Create URL components
///   -- URL string
///   -- May be add querries
///   -- May be change encoding from `+` to `%2B`
///
/// - Then create URL Request from the URL compoenents
///   -- Maybe change http method
///   -- My be add headers
///
/// - Then call `dataTask()` method with callBack with `(data, response, error)` parameters, or assign delegate and handle with it
///   -- Check for error
///   -- Check response
///   -- Decode data
///



/// Example of ``Network Client``

enum HTTPError: String, Error {
    case unwrappingError = "Error: Unable to unwrap the data"
    case failed = "Error: Network request failed"
    case authenticationError = "Error: You must be authenticated"
    case badRequest = "Error: Bad request"
    case serverSideError = "Error: Server error"
    
    case missingURL = "Error: The URL is nil"
    case missingURLComponents = "Error: The URL with components is nil"
    
    case encodingFailed = "Error: Parameter encoding failed"
    case decodingFailed = "Error: Unable to decode the data"
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}


struct HTTPNetworkResponse {
    
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<Void, Error> {
        
        guard let res = response else {
            return .failure(HTTPError.unwrappingError)
        }
        
        switch res.statusCode {
            
        case 200 ... 299: return .success(())
            
        case 401: return .failure(HTTPError.authenticationError)
        
        case 400 ... 499: return .failure(HTTPError.badRequest)
        
        case 500 ... 599: return .failure(HTTPError.serverSideError)
            
        default: return.failure(HTTPError.failed)
            
        }
    }
    
}


typealias HTTPRequestQueryItem = (key: String, value: String?)

struct HTTPRequest {
    let route: String
    let headers: [String: String]
    let body: Data?
    let queryItems: [HTTPRequestQueryItem]
    let httpMethod: HTTPMethod
    
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    
    
    init(
        route: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        queryItems: [HTTPRequestQueryItem] = [],
        httpMethod: HTTPMethod = .get,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970
    ) {
        self.route = route
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
        self.httpMethod = httpMethod
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
    }
    
}


protocol NetworkClient {
    func processRequest<T: Decodable>(
        request: HTTPRequest,
        completion: @escaping (Result<T, HTTPError>) -> Void
    ) -> Cancellable?
}

protocol Cancellable {
    func cancel()
}


struct NetworkWorker: NetworkClient {
    
    private let urlSession: URLSession

    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    
    @discardableResult
    func processRequest<T: Decodable>(
        request: HTTPRequest,
        completion: @escaping (Result<T, HTTPError>) -> Void
    ) -> Cancellable? {
        
        do {
            
            let configuredURLRequest = try configureRequest(request: request)
            
            let task = urlSession.dataTask(with: configuredURLRequest) { data, response, _ in
                
                guard let response = response as? HTTPURLResponse, let unwrappedData = data else {
                    NetworkWorker.executeCompletionOnMainThread {
                        completion(.failure(HTTPError.decodingFailed))
                    }
                    
                    return
                }
                
                let handledResult = HTTPNetworkResponse.handleNetworkResponse(for: response)
                
                switch handledResult {
                    
                case .success:
                    let jsonDecoder = JSONDecoder()
                    
                    jsonDecoder.keyDecodingStrategy = request.keyDecodingStrategy
                    jsonDecoder.dateDecodingStrategy = request.dateDecodingStrategy
                    
                    guard let result = try? jsonDecoder.decode(T.self, from: unwrappedData) else {
                        NetworkWorker.executeCompletionOnMainThread {
                            completion(.failure(HTTPError.decodingFailed))
                        }
                        
                        return
                    }
                    
                    NetworkWorker.executeCompletionOnMainThread {
                        completion(.success(result))
                    }
                    
                case .failure:
                    NetworkWorker.executeCompletionOnMainThread {
                        completion(.failure(HTTPError.decodingFailed))
                    }
                    
                }
            }
            
            task.resume()
            return task
            
        } catch {
            
            NetworkWorker.executeCompletionOnMainThread {
                completion(.failure(HTTPError.failed))
            }

            return nil
        }
    
    }
    
    
    private func configureRequest(request: HTTPRequest) throws -> URLRequest {
        guard var components = URLComponents(string: request.route) else {
            throw HTTPError.missingURL
        }
        
        let queriesArray = request.queryItems.map { querry in
            URLQueryItem(name: querry.key, value: querry.value)
        }
        
        components.queryItems = queriesArray
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let componentsURL = components.url else {
            throw HTTPError.missingURLComponents
        }
        
        var generatedRequest = URLRequest(url: componentsURL)
        
        generatedRequest.httpMethod = request.httpMethod.rawValue
        generatedRequest.httpBody = request.body
        
        request.headers.forEach { headerItem in
            generatedRequest.addValue(headerItem.value, forHTTPHeaderField: headerItem.key)
        }
        
        return generatedRequest
    }
    
    
    private static func executeCompletionOnMainThread(_ closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
    
}

// MARK:  Cancellable
extension URLSessionDataTask: Cancellable {}
