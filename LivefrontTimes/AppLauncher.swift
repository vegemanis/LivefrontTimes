import SwiftData
import SwiftUI

@main
struct AppLauncher {
    /// To avoid running the actual app during testing, we should check that whether or not the
    /// testing framework is available. If it's not then run the real app. Otherwise, run the test flow.
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            LivefrontTimesApp.main()
        } else {
            TestApp.main()
        }
    }
}

/// The test view that is shown when running unit tests.
/// 
struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Running Unit Tests")
        }
        .modelContainer(for: Story.self, inMemory: true)
    }
}
