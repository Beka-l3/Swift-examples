import Foundation


/// Cool framework to interact with internet

/// To work with it
/// - Create configuration for a session
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
/// - Then call `dataTask()` method with callBack with `(data, response, error)` Parameters
///   -- Cehck for error
///   -- Check response
///   -- Decode data
///
