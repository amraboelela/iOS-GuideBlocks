//
//  UIAlertControllerGuideView.swift
//  
//
//  Created by Marc Stroebel on 2024/2/6.
//

import SwiftUI
import ContextualSDK

struct UIAlertControllerGuideView: View {
    var guide: SHTipElement?
    var title: SHTipTextElement?
    var message: SHTipTextElement?
    var actiontagvalue: String
    var nextButton: SHTipButtonElement?
    var prevButton: SHTipButtonElement?
    var nextButtonTapped: (() -> ())?
    var prevButtonTapped: (() -> ())?
    
    var body: some View {
        if let unwrappedGuide = guide {
            let guideBorderColor: Color = unwrappedGuide.borderColor != nil ? Color(unwrappedGuide.borderColor) : Color.clear
            let guideCnr = unwrappedGuide.borderCornerRadius >= 0 ? unwrappedGuide.borderCornerRadius : 5
            let guideBorderWidth = unwrappedGuide.borderWidth >= 0 ? unwrappedGuide.borderWidth : 5
            let prevBG = Color(unwrappedGuide.prev.backgroundColor)
            let prevFG = Color(unwrappedGuide.prev.textColor)
            let nextBG = Color(unwrappedGuide.next.backgroundColor)
            let nextFG = Color(unwrappedGuide.next.textColor)
            let prevCnr = self.prevButton?.borderCornerRadius ?? 5
            let nextCnr = self.nextButton?.borderCornerRadius ?? 5
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    if let title = self.title?.text {
                        Text("\(title) [[\(actiontagvalue)]]")
                            .contextualTextFormat(self.title)
                    }
                    if let message = self.message?.text {
                        Text(message)
                            .contextualTextFormat(self.message)
                    }
                    HStack(spacing: 5) {
                        if let prevButtonText = self.prevButton?.buttonText {
                            Button(action: {
                                self.prevButtonTapped?()
                            }, label: {
                                Text(prevButtonText)
                                    .padding()
                                    .cornerRadius(prevCnr)
                                    .contextualButtonFormat(self.prevButton)
                                    .background(prevBG)
                                    .foregroundColor(prevFG)
                            })

                        }
                        //Spacer()
                        if let nextButtonText = self.nextButton?.buttonText {
                            Button(action: {
                                self.nextButtonTapped?()
                            }, label: {
                                Text(nextButtonText)
                                    .padding()
                                    .cornerRadius(nextCnr)
                                    .contextualButtonFormat(self.nextButton)
                                    .background(nextBG)
                                    .foregroundColor(nextFG)
                            })
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(guideCnr)
                .border(guideBorderColor, width:guideBorderWidth)
                .frame(maxWidth: 260)

                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
