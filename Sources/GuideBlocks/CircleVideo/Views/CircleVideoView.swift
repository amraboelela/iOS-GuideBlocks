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
    var circleDiameter: Int
    var closeButtonTapped: () -> ()
    var videoIsPlaying: () -> ()
    
    var body: some View {
        let width = CGFloat(circleDiameter)
        let height = CGFloat(circleDiameter)
        ZStack {
            VideoWebView(
                url: URL(string: videoUrl),
                videoIsPlaying: {
                    videoIsPlaying()
                }
            )
                .cornerRadius(width/2)
                .frame(width:width, height: height)
            CloseButtonView(
                imageElement: imageElement,
                offsetX: width / 2 - (imageElement?.width ?? 0) / 4,
                offsetY: -1 * (height/2) + (imageElement?.height ?? 0) / 4,
                dismissbuttonTapped: {
                    closeButtonTapped()
                    circleVideoViewModel.videoIsDismissed = true
                }
            )
        }
        .shadow(radius: width/2)
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
