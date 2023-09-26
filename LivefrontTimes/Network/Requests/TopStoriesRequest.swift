import Foundation

/// Provides access to the top stories API.
/// 
protocol TopStoriesRequest {
    /// The APIRequest object to use to make the request and map the data model.
    var apiRequest: APIRequest { get set }

    /// Fetches stories from the API.
    ///
    /// - Returns: An array of stories,
    ///
    func fetchStories() async throws -> [Story]
}

/// The default implementation of the TopStoriesRequest.
///
struct DefaultTopStoriesRequest: TopStoriesRequest {
    var apiRequest: APIRequest = DefaultAPIRequest()

    func fetchStories() async throws -> [Story] {
        let data: TopStoriesData = try await apiRequest.request(
            urlString: "https://api.nytimes.com/svc/topstories/v2/world.json?api-key=\(apiKey)"
        )
        return data.results.compactMap({ Story(data: $0) })
    }
}
