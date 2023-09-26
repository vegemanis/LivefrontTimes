import Foundation

/// Protocol in that defines the API request and mapping to the expected data object.
///
protocol APIRequest {
    /// Makes a network request to the given url, then maps the response to an object.
    ///
    /// - Parameter urlString: The url for the API.
    ///
    func request<T>(urlString: String) async throws -> T where T: Decodable
}

/// The default implementation of the api request.
/// 
struct DefaultAPIRequest: APIRequest {
    /// The networking object to handle the actual request.
    var networkSession: NetworkSession = DefaultNetworkSession()

    func request<T>(urlString: String) async throws -> T where T: Decodable {
        guard let url = URL(string: urlString) else { throw APIRequestError.invalidURL }
        
        let request = URLRequest(url: url)
        
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await networkSession.makeRequest(for: request)
        } catch {
            throw APIRequestError.requestError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else { throw APIRequestError.invalidResponseType }
        guard httpResponse.statusCode < 300, httpResponse.statusCode >= 200 else {
            throw APIRequestError.otherStatusCodeError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIRequestError.dataObjectMismatch(error)
        }
    }
}
