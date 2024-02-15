//
//  FancyAnnouncementGuideView.swift
//  airbnb-main
//
//  Created by Marc Stroebel on 7/11/2023.
//  Copyright © 2023 Contextual. All rights reserved.
//

import SwiftUI
import ContextualSDK

struct FancyAnnouncementGuideView: View {
    var titleElement: SHTipTextElement?
    var messageElement: SHTipTextElement?
    var leftButtonElement: SHTipButtonElement?
    var rightButtonElement: SHTipButtonElement?
    var image: Image?
    var imageUrl: String?
    var accentColor: Color?
    var closeButtonColor: Color?
    var closeButtonTapped: () -> ()
    var leftButtonTapped: (() -> ())?
    var rightButtonTapped: (() -> ())?
    
    @State private var fontSize: CGFloat = 20
    @State private var buttonWidth: CGFloat = 0
    @State private var mainImage: Image?
    
    var body: some View {
        let accentColorFinal = accentColor ?? Color(red: 76/255, green: 159/255, blue: 136/255)
        let imageBackgroundColor = Color(red: 245/255, green: 245/255, blue: 245/255)
        
        if mainImage == nil {
            if let imageUrl = imageUrl,
               let url = URL(string: imageUrl) {
                UIImage.loadFromUrl(url, completion: { image in
                    if let image = image {
                        mainImage = Image(uiImage: image)
                    }
                })
            } else {
                mainImage = Image(systemName: "person.circle.fill")
            }
        }
        
        let screenWidth = UIScreen.main.bounds.width
        
        let square = screenWidth - 50
        
        let circle = square / 2
        let circleBorderWidth = CGFloat(6)
        
        let buttonImageSize = CGFloat(35)
        let buttonXOffset = CGFloat(Int(square) / 2 - 5)
        let buttonYOffset = buttonXOffset * -1
        
        return ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(red: 247/255, green: 247/255, blue: 247/255))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .background(Color.clear)
                .shadow(color: Color.gray, radius: 4, x: 0, y: 0)
                .overlay(
                    VStack {
                        Spacer()
                        if let title = titleElement?.text {
                            Text(title)
                                .contextualTextWith(textElement: titleElement)
                        }
                        if let message = messageElement?.text {
                            Text(message)
                                .padding()
                                .contextualTextWith(textElement: messageElement)
                        }
                        HStack {
                            if let leftButtonText = leftButtonElement?.buttonText {
                                Button(
                                    action: {
                                        leftButtonTapped?()
                                    },
                                    label: {
                                        Text(leftButtonText)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(accentColorFinal, lineWidth: 1)
                                            )
                                            .contextualButtonWith(
                                                buttonElement: leftButtonElement
                                            )
                                            .offset(x: 20, y: 0)
                                    }
                                )
                            }
                            Spacer()
                            if let rightButtonText = rightButtonElement?.buttonText {
                                Button(
                                    action: {
                                        rightButtonTapped?()
                                    },
                                    label: {
                                        Text(rightButtonText)
                                            .padding()
                                            .background(accentColorFinal)
                                            .cornerRadius(8)
                                            .contextualButtonWith(
                                                buttonElement: rightButtonElement
                                            )
                                            .offset(x: -20, y: 0)
                                    }
                                )
                            }
                        }
                    }
                    .offset(x: 0, y: -20)
                )
                .frame(width: square, height: square)
                .zIndex(0)
            
            // Top Border Line
            Rectangle()
                .foregroundColor(accentColorFinal)
                .frame(width: square-6, height: 2)
                .offset(x: 1, y: -square/2+1)
                .zIndex(2)
            
            // Circular Header Image
            mainImage?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: circle, height: circle)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: circleBorderWidth))
                .background(
                    Circle()
                        .fill(imageBackgroundColor)
                        .frame(width: circle, height: circle)
                        .shadow(color: Color.gray, radius: 4, x: 0, y: 0)
                )
                .offset(x: 0, y: -circle)
                .zIndex(5)
            
            // Close Button
            Button(action: {
                closeButtonTapped()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonImageSize, height: buttonImageSize)
                    .background(Color.white)
                    .foregroundColor(accentColorFinal)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: circleBorderWidth/2))
                    .shadow(color: Color.gray, radius: 1, x: 0, y: 0)
                    .padding(8)
            }
            .offset(x: buttonXOffset, y: buttonYOffset)
            .zIndex(10)
        }
        .background(Color.clear)
    }
}

struct FrameModifier: ViewModifier {
    let condition: Bool?
    let width: CGFloat?
    let height: CGFloat?

    func body(content: Content) -> some View {
        guard let condition = condition else {
            return AnyView(content)
        }
        
        if condition {
            return AnyView(content.frame(width: width ?? .infinity,
                                         height: height ?? .infinity))
        } else {
            return AnyView(content)
        }
    }
}

struct FancyAnnouncementGuideView_Previews: PreviewProvider {
    static var previews: some View {
        let title = SHTipTextElement()
        title.text = "Create Account"
        title.fontSize = 32
        title.textColor = UIColor.red
        title.fontWeight = "bold"
        
        let message = SHTipTextElement()
        message.text = "By creating an account, you will benefit from Contextual extensibility as well as the conventional guides."
        
        let leftButton = SHTipButtonElement()
        leftButton.buttonText = "Cancel"
        leftButton.width = 100
        leftButton.height = 1
        
        let rightButton = SHTipButtonElement()
        rightButton.buttonText = "Submit"
        
        return FancyAnnouncementGuideView(
            titleElement: title,
            messageElement: message,
            leftButtonElement: leftButton,
            rightButtonElement: rightButton,
            imageUrl: "https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png",
            accentColor: nil,
            closeButtonColor: nil,
            closeButtonTapped: {

            },
            leftButtonTapped:  {
                // Do nothing
            },
            rightButtonTapped: {
                // Do nothing
            }
        )
    }
}
