//
//  File.swift
//  
//
//  Created by Marc Stroebel on 6/2/2024.
//

import SwiftUI
import ContextualSDK

struct UIAlertControllerGuideView: View {
    var title: SHTipTextElement?
    var message: SHTipTextElement?
    var actiontagvalue: String
    var nextButton: SHTipButtonElement?
    var prevButton: SHTipButtonElement?
    var nextButtonTapped: (() -> ())?
    var prevButtonTapped: (() -> ())?
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                if let title = self.title?.text {
                    Text("\(title) [[\(actiontagvalue)]]").contextualText(textElement: self.title)
                }

                if let message = self.message?.text {
                    Text(message).contextualText(textElement: self.message)
                        .multilineTextAlignment(self.message?.alignment)
                }
                HStack(spacing: 1) {
                    if let prevButtonText = self.prevButton?.buttonText {
                        Button(action: {
                            self.prevButtonTapped?()
                        }, label: {
                            Text(prevButtonText)
                                .padding()
                                .cornerRadius(8)
                                .contextualText(buttonElement: self.prevButton)
                                .offset(x: 20, y: 0)
                        })
                    }
                    //Spacer()
                    if let nextButtonText = self.nextButton?.buttonText {
                        Button(action: {
                            self.nextButtonTapped?()
                        }, label: {
                            Text(nextButtonText)
                                .padding()
                                .cornerRadius(8)
                                .contextualText(buttonElement: self.nextButton)
                                .offset(x: 20, y: 0)
                        })
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .border(Color.black, width: 1)
            .frame(maxWidth: 260)

            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

/*
struct UIAlertControllerGuideView_Previews: PreviewProvider {
    static var previews: some View {
        return UIAlertControllerGuideView(
            title: "title",
            message: "message",
            actiontagvalue: "last action"
            nextButton: "next",
            prevButton: "prev",
            nextButtonTapped:  {
                // Do nothing
            },
            prevButtonTapped: {
                // Do nothing
            },
        )
    }
}
*/
