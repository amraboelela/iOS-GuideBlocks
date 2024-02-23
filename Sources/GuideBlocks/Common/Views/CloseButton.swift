//
//  CloseButton.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/22.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct CloseButton: View {
    var imageElement: SHTipImageElement?
    //var offsetX: CGFloat
    //var offsetY: CGFloat
    var closeButtonTapped: () -> ()
    
    var body: some View {
        Button(
            action: {
                closeButtonTapped()
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
        /*.offset(
            x: offsetX,
            y: offsetY
        )*/
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(
            //imageElement: nil,
            //offsetX: 100,
            //offsetY: 10,
            closeButtonTapped: {
            }
        )
    }
}
