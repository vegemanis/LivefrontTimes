import Foundation

/// The data model for an individual story from the API.
/// 
struct TopStoryData: Codable {
    /// The abstract of the story.
    let abstract: String

    /// Image data for the story.
    let multimedia: [MultimediaData]?

    /// Title of the story.
    let title: String

    /// URL to the story.
    let url: String
}
