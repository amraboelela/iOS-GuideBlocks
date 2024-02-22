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
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator // Set the navigation delegate
        
        _ = webView.observe(\.estimatedProgress, options: .new) { webView, change in
            guard let progress = change.newValue else { return }
            
            // Check if the progress is increasing significantly
            if progress > 0.1 { // Adjust this threshold as needed
                print("Streaming might have started.")
            }
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            uiView.load(URLRequest(url: url))
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Inject JavaScript to access the YouTube player API
            let javaScript = "document.getElementsByTagName('video')[0].paused"
            
            // Execute the JavaScript and handle the result
            webView.evaluateJavaScript(javaScript) { (result, error) in
                if let error = error {
                    print("JavaScript evaluation error: \(error)")
                    return
                }
                
                // Check if the result is a boolean indicating whether the video is paused
                if let isPaused = result as? Bool {
                    if isPaused {
                        print("YouTube video is paused")
                    } else {
                        print("YouTube video is playing")
                    }
                } else {
                    print("Unexpected result: \(String(describing: result))")
                }
            }
        }
        /*
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
                // Inject JavaScript to access the YouTube player API
                let javaScript = "document.getElementsByTagName('video')[0].paused"
                
                // Execute the JavaScript and handle the result
                webView.evaluateJavaScript(javaScript) { (result, error) in
                    if let error = error {
                        print("JavaScript evaluation error: \(error)")
                        return
                    }
                    
                    // Check if the result is a boolean indicating whether the video is paused
                    if let isPaused = result as? Bool {
                        if isPaused {
                            print("YouTube video is paused")
                        } else {
                            print("YouTube video is playing")
                        }
                    } else {
                        print("Unexpected result: \(String(describing: result))")
                    }
                }
            }*/
    }
}
