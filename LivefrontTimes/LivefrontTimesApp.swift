import SwiftUI
import SwiftData

/// The main entryway into the app.
/// 
struct LivefrontTimesApp: App {
    /// The model container that manages SwiftData storage.
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Story.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TopStoriesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
