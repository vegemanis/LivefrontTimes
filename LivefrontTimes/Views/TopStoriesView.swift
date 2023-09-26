import SwiftUI
import SwiftData

/// A view that displays a list of top stories, and allows the user to tap on them for more details.
///
struct TopStoriesView: View {
    /// The model context used for storing objects in SwiftData.
    @Environment(\.modelContext) private var modelContext

    /// The data that is queried from SwiftData and used to populate the views.
    @Query private var stories: [Story]

    /// Observable object that manages the view's state.
    @Bindable var state = TopStoriesState()

    var body: some View {
        NavigationView {
            articleList
            .navigationTitle("Top Stories")
        }
        .task {
            state.fetchingData = true
            defer { state.fetchingData = false }

            await fetchTopStories()
        }
        .alert("Something went wrong!", isPresented: $state.errorFetching) {
            Button("OK", role: .cancel) {
                state.errorFetching = false
            }
        } message: {
            Text("There was an issue attempting to get the latest stories.")
        }
    }
    
    // MARK: - Private Properties

    /// The list of articles to display.
    ///
    private var articleList: some View {
        List {
            if state.fetchingData {
                loadingStatus
            }

            ForEach(stories) { story in
                NavigationLink {
                    WebView(url: story.articleURL)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    StoryCard(story: story)
                }
            }
        }
        .listStyle(InsetListStyle())
        .refreshable {
            await fetchTopStories()
        }
    }

    /// Indicates that the data is being fetched on initial load.
    ///
    private var loadingStatus: some View {
        HStack {
            Spacer()
            ProgressView()
                .padding(.trailing, 8)
            Text("Loading Top Stories")
                .foregroundStyle(.secondary)
            Spacer()
        }
    }

    // MARK: - Private Functions

    /// Fetches the top stories from the API and stores them in SwiftData.
    ///
    @MainActor
    private func fetchTopStories() async {
        do {
            let newStories = try await state.topStoriesRequest.fetchStories()
            for story in stories {
                modelContext.delete(story)
            }
            for story in newStories {
                modelContext.insert(story)
            }
        } catch {
            print(error) // for testing purposes.
            state.errorFetching = true
        }
    }
}

#Preview {
    TopStoriesView()
        .modelContainer(for: Story.self, inMemory: true)
}
