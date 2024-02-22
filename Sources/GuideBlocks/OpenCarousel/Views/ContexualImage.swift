//
//  ContexualImage.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/17.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContexualImage: View {
    
    let carouselData: OpenCarouselData
    
    @Binding var loadedImage: Image?
    @State var image: SHTipImageElement?
    
    var body: some View {
        
        loadedImage?
            .resizable()
            .frame(width: carouselData.backgroundImageSize.width, height: carouselData.backgroundImageSize.height)
            .overlay(content: {
                RoundedRectangle(cornerRadius: image?.cornerRadius ?? 0)
                    .stroke(Color(uiColor: image?.borderColor ?? .clear), lineWidth: image?.borderWidth ?? 0)
            })
            .clipShape(RoundedRectangle(cornerRadius: image?.cornerRadius ?? 0))
            .background(Color(uiColor: image?.backgroundColor ?? .clear))
            .margin(image?.margin)
    }
}
