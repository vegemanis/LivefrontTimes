import Foundation

/// The data model the contains the list of stories from the API.
/// 
struct TopStoriesData: Codable {
    /// The list of stories.
    let results: [TopStoryData]
}
