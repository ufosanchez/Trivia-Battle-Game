//
//  Gif_Enemy.swift
//  Trivia Battle Game
//
//  Created by Arnulfo Sánchez on 2023-05-23.
//

import SwiftUI
import WebKit

struct GifEnemy: UIViewRepresentable {
    private let name: String

        init(_ name: String) {
            self.name = name
        }

        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            let url = Bundle.main.url(forResource: name, withExtension: "gif")!
            let data = try! Data(contentsOf: url)
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingLastPathComponent()
            )
            webView.scrollView.isScrollEnabled = false
            webView.isOpaque = false
//            webView.bounds.width

            return webView
        }

        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.reload()
        }
}

//struct Gif_Enemy_Previews: PreviewProvider {
//    static var previews: some View {
//        Gif_Enemy()
//    }
//}
