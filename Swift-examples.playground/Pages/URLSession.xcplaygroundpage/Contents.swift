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

enum HTTPError: String, Error {
    case unwrappingError = "Error: Unable to unwrap the data"
    case failed = "Error: Network request failed"
    case authenticationError = "Error: You must be authenticated"
    case badRequest = "Error: Bad request"
    case serverSideError = "Error: Server error"
    
    case missingURLComponents = "Error: The URL with components is nil"
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
            
            
        default: return.failure(HTTPError.failed)
            
        }
    }
}
