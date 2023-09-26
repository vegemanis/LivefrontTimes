import SwiftUI
import WebKit

/// A UIViewRepresentable to allow the use of UIKit's WebView in SwiftUI.
/// 
struct WebView: UIViewRepresentable {
    /// The URL of the web page to load.
    let url: URL

    // MARK: - UIViewRepresentable Delegate Implementation

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
