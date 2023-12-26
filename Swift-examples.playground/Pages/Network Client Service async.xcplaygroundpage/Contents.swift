import Foundation


/// ``Network Client``

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
    
    func processRequest<T: Decodable>( request: HTTPRequest ) async throws -> T
    
}



