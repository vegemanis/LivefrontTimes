import Foundation
import Observation

/// Object that manages the top stories state.
/// 
@Observable
final class TopStoriesState {
    /// Whether or not there was an error fetching data.
    var errorFetching: Bool

    /// Whether or not the data is loading from the API.
    var fetchingData: Bool

    /// The API to fetch story details from.
    var topStoriesRequest: TopStoriesRequest

    /// Initializer for the observable object.
    ///
    /// - Parameters:
    ///  - errorFetching: Whether or not there was an error fetching data.
    ///  - fetchingData: Whether or not the data is loading from the API.
    ///  - topStoriesRequest: The API to fetch story details from.
    ///
    init(
        errorFetching: Bool = false,
        fetchingData: Bool = false,
        topStoriesRequest: TopStoriesRequest = DefaultTopStoriesRequest()
    ) {
        self.errorFetching = errorFetching
        self.fetchingData = fetchingData
        self.topStoriesRequest = topStoriesRequest
    }
}
