//
//  OpenCarouselGuidView.swift
//
//
//  Created by Aamir on 10/02/24.
//

import SwiftUI
import ContextualSDK

struct OpenCarouselGuidView: View {
    
    let screenSize = UIScreen.main.bounds
    let openCarouselDataManager: OpenCarouselDataManager
    
    var dismissController: () -> ()

    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            ForEach(openCarouselDataManager.carouselItems) { viewData in
                OpenCarouselView(data: viewData,currentTab: $currentTab, dismissController: dismissController)
                    .tag(viewData.id)
            }
        })
        
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .frame(width: screenSize.width, height: screenSize.height * 0.95)

        
    }
}

struct OpenCarouselView: View {
    var data: OpenCarouselData
    
    @Binding var currentTab: Int
    @State private var backgroundImage: Image?
    @State private var primaryImage: Image?
    @State private var isAnimating: Bool = false
    
    let screenSize = UIScreen.main.bounds
    var dismissController: () -> ()
    var body: some View {
        
        data.loadBackgroundImage { image in
            backgroundImage = image
        }
        
        data.loadPrimaryImage { image in
            primaryImage = image
        }
        
        return VStack(spacing: 20) {
            ZStack {
                backgroundImage?
                .resizable()
//                .scaledToFit()


                primaryImage?
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 150)
                    .frame(width: screenSize.width * 0.8, height: screenSize.width * 0.8)
                    .scaleEffect(isAnimating ? 1 : 0.9)
                    .foregroundStyle(.gray)
            }

            Spacer()
            Spacer()

            if let title = data.carouselDataItem?.titleText {
                Text(title).contextualCarouselTitleElement(data.carouselDataItem)
            } else {
                Text("Title \(data.id)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

            }
            
            
            //TODO: Below code will be removed later
            //
            
            if let subtitle = data.carouselDataItem?.contentText {
                Text(subtitle).contextualCarouselContentElement(data.carouselDataItem)

            } else {
                Text("Subtitle \(data.id)")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 250)
                    .foregroundColor(.red)
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)

            }

//            Spacer()

            Button(action: {
                    if !data.isLastScreen {
                        withAnimation {
                            currentTab += 1
                        }
                    } else {
                        print("Reached last screen")
                        dismissController()
                        
                    }
                
                
            }, label: {
                if let text = data.button?.buttonText {
                    Text(text)
                        .background(Color(uiColor: data.button?.backgroundColor ?? .black))
                        .contextualText(buttonElement: data.button)

                } else {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(
                                    Color(
                                        red: 255 / 255,
                                        green: 115 / 255,
                                        blue: 115 / 255
                                    )
                                )
                        )
                }
                
            })
            .shadow(radius: 10)

            Spacer()
        }
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
        })
    }
}

//#Preview {
//    OpenCarouselGuidView()
//}
