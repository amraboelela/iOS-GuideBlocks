//
//  CircleVideoView.swift
//  iOS-GuideBlocks
//
//  Created by David Jones on 2023/12/11.
//  Copyright © 2023 Contextual.
//

import ContextualSDK
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

// Round Popup View
struct CircleVideoView: View {
    var imageElement: SHTipImageElement?
    var videoUrl: String
    var circleDiameter: Int
    var dismissbuttonTapped: () -> ()
    
    var body: some View {
        let width = CGFloat(circleDiameter)
        let height = CGFloat(circleDiameter)
        ZStack {
            Button(
                action: {
                    dismissbuttonTapped()
                },
                label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .contextualImageResize(imageElement)
                        .padding(10)
                        .contextualImageBackground(imageElement)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(width/2)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                        .zIndex(11)
                }
            )
            .offset(
                x: width/2 - (imageElement?.width ?? 0) / 4,
                y: -1*(height/2) + (imageElement?.height ?? 0) / 4
            )
            .zIndex(10)
            WebView(url: URL(string: videoUrl))
                .cornerRadius(width/2)
                .frame(width:width, height: height)
        }
        .shadow(radius: width/2)
        
    }
}

struct CircleVideoView_Previews: PreviewProvider {
    static var previews: some View {
        CircleVideoView(
            videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ?si=Wx9SC9sBIU6AlMnz",
            circleDiameter: 150,
            dismissbuttonTapped: {
            }
        )
    }
}
