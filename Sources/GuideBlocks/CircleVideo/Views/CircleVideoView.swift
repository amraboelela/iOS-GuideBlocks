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
    var imageElement: SHTipImageElement?
    var videoUrl: String
    var circleDiameter: CGFloat
    var closeButtonTapped: () -> ()
    var videoIsPlaying: () -> ()
    
    var body: some View {
        ZStack {
            VideoWebView(
                url: URL(string: videoUrl),
                videoIsPlaying: {
                    videoIsPlaying()
                }
            )
            .cornerRadius(circleDiameter/2)
            .frame(width:circleDiameter, height: circleDiameter)
            .padding(25)
            .overlay(
                CloseButton(
                    imageElement: imageElement,
                    closeButtonTapped: {
                        closeButtonTapped()
                        circleVideoViewModel.videoIsDismissed = true
                    }
                ),
                alignment: .topTrailing
            )
        }
        .shadow(radius: circleDiameter/2)
    }
}

struct CircleVideoView_Previews: PreviewProvider {
    static var previews: some View {
        CircleVideoView(
            videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ?si=Wx9SC9sBIU6AlMnz",
            circleDiameter: 150,
            closeButtonTapped: {
            },
            videoIsPlaying: {
            }
        )
    }
}
