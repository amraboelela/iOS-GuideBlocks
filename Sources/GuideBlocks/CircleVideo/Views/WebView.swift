//
//  WebView.swift
//  GuideBlocks
//
//  Created by David Jones on 2023/12/11.
//  Copyright © 2024 Contextual.
//

import SwiftUI
import WebKit

// WebView Representable
struct WebView: UIViewRepresentable {
    let url: URL?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url {
            uiView.load(URLRequest(url: url))
        }
    }
}
