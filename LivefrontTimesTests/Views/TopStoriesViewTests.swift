@testable import LivefrontTimes
import SnapshotTesting
import SwiftData
import SwiftUI
import ViewInspector
import XCTest

final class TopStoriesViewTests: XCTestCase {
    /// Mocked api requestor.
    var requestMock: TopStoriesRequestMock!

    /// SwiftData in memory Model Container.
    var modelContainer: ModelContainer!

    override func setUp () {
        requestMock = TopStoriesRequestMock(mockedDataFilename: "TopStoriesData")
        
        let schema = Schema([Story.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    /// Tests error fetching scenario, and the alert.
    @MainActor
    func testErrorFetching() throws {
        let state = TopStoriesState(errorFetching: true, topStoriesRequest: requestMock)
        let view = TopStoriesView(state: state)
            .modelContainer(modelContainer)

        _ = try view.inspect().find(text: "Something went wrong!")

        try view.inspect().find(button: "OK").tap()
        XCTAssertFalse(state.errorFetching)
    }

    /// Tests fetching stories returns a list of properly mapped story objects.
    @MainActor
    func testFetchStories() async throws {
        let newStories = try await requestMock.fetchStories()
        for story in newStories {
            modelContainer.mainContext.insert(story)
        }

        let state = TopStoriesState(topStoriesRequest: requestMock)
        let view = TopStoriesView(state: state)
            .modelContainer(modelContainer)
        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: .iPhone13ProMax),
                traits: .init(userInterfaceStyle: .light)
            )
        )
    }

    /// Test error fetching scenario.
    @MainActor
    func testFetching() async {
        let state = TopStoriesState(fetchingData: true, topStoriesRequest: requestMock)
        let view = TopStoriesView(state: state)
            .modelContainer(modelContainer)
        assertSnapshot(
            of: view,
            as: .image(
                layout: .device(config: .iPhone13ProMax),
                traits: .init(userInterfaceStyle: .light)
            )
        )
    }
}
