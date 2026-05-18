import Foundation
import SwiftUI
import YouTubeiOSPlayerHelper

struct YoutubePlayerView: UIViewRepresentable {
    let videoKey: String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let webView = YTPlayerView()
        return webView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        uiView.load(withVideoId: videoKey)
        }
    }
