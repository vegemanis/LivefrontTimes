import Foundation

/// Model representing the multimedia data from the API.
/// 
struct MultimediaData: Codable {
    /// The url for the media item.
    let url: URL?

    /// The format of the media item.
    let format: MultimediaFormatType?
}
