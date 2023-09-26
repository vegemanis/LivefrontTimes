# Livefront Times

This is the Livefront Times app. It shows the top headlines from the New York Times. You may pull to refresh the list to get the latest data.

This compiles using Xcode 15. It uses Macros, SwiftData, and the Observation Framework.

## API Key
To access the New York Times API, an API key is needed. Search the codebase for <API_KEY>, and replace it in the Keys.swift file with a valid key.

## Package Dependencies
* [NukeUI](https://github.com/kean/Nuke) - Used for the LazyImage control to allow asynchronous loading and caching of image data.
* [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) - Used for Snapshot testing on the views.
* [ViewInspector](https://github.com/nalexn/ViewInspector) - Used to further test the views with interactions.
