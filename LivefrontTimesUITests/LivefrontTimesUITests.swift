import XCTest

final class LivefrontTimesUITests: XCTestCase {
    /// Tests opening the app and navigating to a story.
    func testNormalUsage() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews.cells.firstMatch.tap()
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Top Stories"].tap()
    }
}
