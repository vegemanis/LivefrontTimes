import Foundation

/// Protocol that defines the URL network request.
///
protocol NetworkSession {
    /// Handles a network request for the given url request.
    ///
    /// - Parameter request: The url request for the API.
    ///
    func makeRequest(for request: URLRequest) async throws -> (Data, URLResponse)
}

/// The default implementation that uses the URLSession.shared singleton.
///
struct DefaultNetworkSession: NetworkSession {
    func makeRequest(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(for: request)
    }
}
