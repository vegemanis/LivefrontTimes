@testable import LivefrontTimes
import XCTest

final class TopStoriesRequestTests: XCTestCase {
    /// Mocked api requestor.
    var apiMock: APIRequestMock!

    override func setUp () {
        apiMock = APIRequestMock()
    }

    /// Test fetching stories returns a list of properly mapped story objects.
    func testFetchStories() async throws {
        apiMock.mockedDataFilename = "TopStoriesData"

        let subject = DefaultTopStoriesRequest(apiRequest: apiMock)

        let stories = try await subject.fetchStories()
        XCTAssertEqual(stories.count, 36)
    }
}
