import Foundation
import SwiftData

/// Model that provides details about a story to display in a view. Cacheable via SwiftData.
///
@Model
final class Story: Identifiable {
    /// The URL to the article.
    @Attribute(.unique) let articleURL: URL
    
    /// An abstract about the article.
    let abstract: String
    
    /// The URL for an image associated to the article (Optional).
    let imageURL: URL?
    
    /// The title of the article.
    let title: String
    
    /// Initializer that takes the data from the API and flattens it for ease of use.
    ///
    /// - Parameter data: The data received from the API.
    ///
    init? (data: TopStoryData) {
        guard let url = URL(string: data.url) else { return nil }
        
        self.abstract = data.abstract
        self.articleURL = url
        self.imageURL = data.multimedia?.first(where: { $0.format == .largeThumbnail })?.url
        self.title = data.title
    }
}
