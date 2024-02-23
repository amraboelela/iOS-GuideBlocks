//
//  CloseButtonView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/22.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct CloseButtonView: View {
    var imageElement: SHTipImageElement?
    var offsetX: CGFloat
    var offsetY: CGFloat
    var dismissbuttonTapped: () -> ()
    
    var body: some View {
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
                    .clipShape(Circle())
                    .shadow(radius: 8)
                    .zIndex(11)
            }
        )
        .offset(
            x: offsetX,
            y: offsetY
        )
    }
}

struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView(
            imageElement: nil,
            offsetX: 100,
            offsetY: 10,
            dismissbuttonTapped: {
            }
        )
    }
}
