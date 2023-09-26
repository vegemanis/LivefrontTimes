import Foundation

/// Possible error types we could get back from APIRequest.
/// 
enum APIRequestError: Error {
    /// Mapping the json data to the expected object type did not match.
    case dataObjectMismatch(Error)

    /// The response was not an HTTPURLResponse type.
    case invalidResponseType

    /// The string passed in for the url is not valid.
    case invalidURL

    /// The status code returned is not 2xx.
    case otherStatusCodeError(Int)

    /// There was an error making the request.
    case requestError(Error)
}
