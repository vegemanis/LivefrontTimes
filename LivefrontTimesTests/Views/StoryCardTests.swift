@testable import LivefrontTimes
import SnapshotTesting
import SwiftData
import XCTest

final class StoryCardTests: XCTestCase {
    /// Tests the layout of the card.
    func testLayout() throws {
        let view = StoryCard(
            story: Story(
                data: TopStoryData(
                    abstract: "This is the abstract of the article.",
                    multimedia: nil,
                    title: "This is the title of the article.",
                    url: "https://example.com"
                )
            )!
        )

        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: .iPhone13ProMax),
                traits: .init(userInterfaceStyle: .light)
            )
        )
    }

    /// Tests the layout of the card with longer text.
    func testLayoutLong() throws {
        let view = StoryCard(
            story: Story(
                data: TopStoryData(
                    abstract: "This is the abstract of the article. This is the abstract of the article. This is the abstract of the article.",
                    multimedia: nil,
                    title: "This is the title of the article. This is the title of the article. This is the title of the article",
                    url: "https://example.com"
                )
            )!
        )

        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: .iPhone13ProMax),
                traits: .init(userInterfaceStyle: .light)
            )
        )
    }
}
