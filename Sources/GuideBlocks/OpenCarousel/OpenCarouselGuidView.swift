//
//  OpenCarouselGuidView.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/10.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct OpenCarouselGuidView: View {
    
    let screenSize = UIScreen.main.bounds
    let openCarouselDataManager: OpenCarouselDataManager
    
    var dismissController: () -> ()
    
    init(guide: SHTipElement,onDismiss dismissController: @escaping () -> Void) {
        self.openCarouselDataManager = OpenCarouselDataManager(guide: guide)
        self.dismissController = dismissController
    }

    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(openCarouselDataManager.carouselItems) { viewData in
                OpenCarouselView(data: viewData,
                                 dismissController: dismissController,
                                 guide: openCarouselDataManager.guide,
                                 currentTab: $currentTab)
                .tag(viewData.id)
            }
        })
        .frame(width: openCarouselDataManager.containerSize.width, height: openCarouselDataManager.containerSize.height)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
        
        //background color of Container > Fill
        .background(Color(uiColor: openCarouselDataManager.guide.backgroundColor))
        .overlay(content: {
            RoundedRectangle(cornerRadius: openCarouselDataManager.guide.borderCornerRadius)
                .stroke(Color(uiColor: openCarouselDataManager.guide.borderColor), lineWidth: openCarouselDataManager.guide.borderWidth)
        })
        .clipShape(RoundedRectangle(cornerRadius: openCarouselDataManager.guide.borderCornerRadius))
        .margin(openCarouselDataManager.guide.padding)
        .margin(openCarouselDataManager.guide.margin)
    }
}

struct OpenCarouselView: View {
    
    var data: OpenCarouselData
    let screenSize = UIScreen.main.bounds
    @State private var backgroundImageSize: CGSize = .zero
    
    var dismissController: () -> ()
    var guide: SHTipElement
    
    @Binding var currentTab: Int
    @State private var backgroundImage: Image?
    @State private var primaryImage: Image?
    @State private var isAnimating = false
    
    var body: some View {
        
        VStack(spacing: 20) {
            ZStack {
                //Added empty image just to keep primary image in proper position.
                Image("")
                .resizable()

                primaryImage?
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 150)
                    .frame(width: guide.containerSize.width * 0.8, height: guide.containerSize.width * 0.8)
                    .scaleEffect(isAnimating ? 1 : 0.9)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            Spacer()
            
            if let title = data.carouselDataItem?.titleText {
                Text(title)
                    .contextualCarouselFormat(data.carouselDataItem)
                    .multilineTextAlignment(.center)
            } else {
                PlaceholderTitleView(id: data.id)
            }
                        
            if let subtitle = data.carouselDataItem?.contentText {
                Text(subtitle)
                    .contextualCarouselContentElement(data.carouselDataItem)
                    .multilineTextAlignment(.center)
            } else {
                PlaceholderSubtitleView(id: data.id)
            }
            
            if let button = data.button {
                ContexualButton(button: button,containerSize: guide.containerSize) {
                    if !data.isLastScreen {
                        withAnimation {
                            currentTab += 1
                        }
                    } else {
                        //
                        dismissController()
                    }
                }
            } else {
                Text(Constants.PlaceholderTexts.button_next_title)
            }
            Spacer()
        }
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
        })
        .task {
            data.loadBackgroundImage { image in
                backgroundImage = image
            }
            
            data.loadPrimaryImage { image in
                primaryImage = image
            }
        }
        
        .background {
            ZStack(alignment: data.backgroundImage?.imageAligment ?? .center, content: {
                
                ContexualImage(carouselData: data, loadedImage: $backgroundImage, image: data.backgroundImage)
                
                // Handles Carousel's background color.
                Rectangle()
                    .foregroundStyle(Color(uiColor: data.carouselDataItem?.backgroundColor ?? .clear))
            })
            
            .frame(width: guide.containerSize.width, height: guide.containerSize.height)
        }
    }
}
