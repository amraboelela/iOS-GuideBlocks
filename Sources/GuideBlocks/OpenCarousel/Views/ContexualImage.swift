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
    
    @State private var loadedImage: Image?
    @State private var backgroundImageSize: CGSize = .zero
    @State var image: SHTipImageElement
    
    init(carouselData: OpenCarouselData,loadedImage: Image?) {
        self.carouselData = carouselData
        self.loadedImage = loadedImage
        self.backgroundImageSize = carouselData.backgroundImageSize
        self.image = carouselData.backgroundImage ?? SHTipImageElement()
    }
    var body: some View {
        loadedImage?
            .resizable()
            .frame(width: carouselData.backgroundImageSize.width, height: carouselData.backgroundImageSize.height)
            .overlay(content: {
                RoundedRectangle(cornerRadius: image.cornerRadius)
                    .stroke(Color(uiColor: image.borderColor), lineWidth: image.borderWidth)
            })
            .clipShape(RoundedRectangle(cornerRadius: image.cornerRadius))
            .background(Color(uiColor: image.backgroundColor))
            .margin(image.margin)
    }
}
