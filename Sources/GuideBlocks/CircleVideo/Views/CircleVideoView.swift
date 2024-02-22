//
//  CircleVideoView.swift
//  GuideBlocks
//
//  Created by David Jones on 2023/12/11.
//  Copyright © 2023 Contextual.
//

import ContextualSDK
import SwiftUI

// Round Popup View
struct CircleVideoView: View {
    //@ObservedObject var circleVideoViewModel: CircleVideoViewModel
    var imageElement: SHTipImageElement?
    var videoUrl: String
    var circleDiameter: Int
    var dismissbuttonTapped: () -> ()
    var videoIsPlaying: () -> ()
    
    var body: some View {
        let width = CGFloat(circleDiameter)
        let height = CGFloat(circleDiameter)
        ZStack {
            Button(
                action: {
                    dismissbuttonTapped()
                    circleVideoViewModel.videoIsDismissed = true
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
            VideoWebView(
                url: URL(string: videoUrl),
                videoIsPlaying: {
                    videoIsPlaying()
                }
            )
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
            },
            videoIsPlaying: {
            }
        )
    }
}
