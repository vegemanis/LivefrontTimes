import Foundation

/// The possible formats for the media items.
///
enum MultimediaFormatType: String, Codable {
    /// The large size.
    case threeByTwoSmallAt2X

    /// The jumbo size.
    case superJumbo = "Super Jumbo"

    /// The thumbnail size.
    case largeThumbnail = "Large Thumbnail"
}
