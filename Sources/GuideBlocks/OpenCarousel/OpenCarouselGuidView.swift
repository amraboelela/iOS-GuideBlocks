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
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
//        .clipShape(RoundedRectangle(cornerRadius: openCarouselDataManager.guide.borderCornerRadius))
//        .border(Color(uiColor: openCarouselDataManager.guide.borderColor), width: openCarouselDataManager.guide.borderWidth)
        .overlay(content: {
            RoundedRectangle(cornerRadius: openCarouselDataManager.guide.borderCornerRadius)
                .stroke(Color(uiColor: openCarouselDataManager.guide.borderColor), lineWidth: openCarouselDataManager.guide.borderWidth)
        })
        .clipShape(RoundedRectangle(cornerRadius: openCarouselDataManager.guide.borderCornerRadius))

        .margin(openCarouselDataManager.guide.padding)
        .margin(openCarouselDataManager.guide.margin)
        
//        .background {
//            Rectangle()
//                .frame(width: openCarouselDataManager.guide.containerSize.width, height: openCarouselDataManager.guide.containerSize.height)
//                .background(Color(uiColor: openCarouselDataManager.guide.backgroundColor))
//        }
        
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
                Image("")
                .resizable()

                primaryImage?
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 150)
//                    .frame(width: screenSize.width * 0.8, height: screenSize.width * 0.8)
                    //.frame(width: guide.containerSize.width * 0.8, height: guide.containerSize.width * 0.8)
                    .scaleEffect(isAnimating ? 1 : 0.9)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Spacer()
            if let title = data.carouselDataItem?.titleText {
                Text(title)
                    .contextualCarouselFormat(data.carouselDataItem)
            } else {
                Text("Title \(data.id)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
                        
            if let subtitle = data.carouselDataItem?.contentText {
                Text(subtitle)
                    .contextualCarouselContentElement(data.carouselDataItem)
                
            } else {
                Text("Subtitle \(data.id)")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 250)
                    .foregroundColor(.red)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)
            }
            if let button = data.button {
                ContexualButton(button: button,containerSize: guide.containerSize) {
                    if !data.isLastScreen {
                        withAnimation {
                            currentTab += 1
                        }
                    } else {
                        print("Reached last screen")
                        dismissController()
                    }
                    /*} else {
                     print("Reached last screen")
                     dismissController()
                     }*/
                }
            } else {
                Text("Next")
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
            self.backgroundImageSize = data.backgroundImage?.imageSize(containerSize: guide.containerSize) ?? .zero
            data.loadBackgroundImage { image in
                backgroundImage = image
            }
            
            data.loadPrimaryImage { image in
                primaryImage = image
            }
        }
        
        .background {
            ZStack(alignment: data.backgroundImage?.imageAligment ?? .center, content: {
                Rectangle()
                    //.frame(width: guide.containerSize.width, height: guide.containerSize.height)
                    .background(Color(uiColor: data.backgroundImage?.backgroundColor ?? .clear))

                backgroundImage?
                    .resizable()
                    .frame(width: backgroundImageSize.width, height: backgroundImageSize.height)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: data.backgroundImage?.cornerRadius ?? 0)
                            .stroke(Color(uiColor: data.backgroundImage?.borderColor ?? .clear), lineWidth: data.backgroundImage?.borderWidth ?? 0)
                    })
                    .clipShape(RoundedRectangle(cornerRadius: data.backgroundImage?.cornerRadius ?? 0))
                    .background(Color(uiColor: data.backgroundImage?.backgroundColor ?? .clear))
                    .margin(data.backgroundImage?.margin ?? FourSide(top: 0, bottom: 0, left: 0, right: 0))
                    
                Rectangle()
                    .frame(width: guide.containerSize.width, height: guide.containerSize.height)
                    .foregroundStyle(Color(uiColor: data.carouselDataItem?.backgroundColor ?? .clear))

            })
            
            .frame(width: guide.containerSize.width, height: guide.containerSize.height)
            .background(Color(uiColor: data.backgroundImage?.backgroundColor ?? .clear))

        }
    }
}
