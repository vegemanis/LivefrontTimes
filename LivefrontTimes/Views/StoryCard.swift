import NukeUI
import SwiftUI

/// A view that handles laying out the details of a story.
/// 
struct StoryCard: View {
    /// The story that contains the details to populate the card.
    let story: Story
    
    var body: some View {
        HStack(spacing: 16) {
            LazyImage(url: story.imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else if phase.error != nil {
                    Image("livefront-logo")
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(story.title)
                Text(story.abstract)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .font(.system(size: 15))

            Spacer()
        }
    }
}

#Preview {
    StoryCard(
        story: Story(
            data: TopStoryData(
                abstract: "This is the abstract of the article.",
                multimedia: nil,
                title: "This is the title of the article",
                url: "https://example.com"
            )
        )!
    )
}
