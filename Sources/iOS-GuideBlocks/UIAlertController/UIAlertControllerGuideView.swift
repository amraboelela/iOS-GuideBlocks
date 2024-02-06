//
//  File.swift
//  
//
//  Created by Marc Stroebel on 6/2/2024.
//

import SwiftUI
import ContextualSDK

struct UIAlertControllerGuideView: View {
    var title: String
    var message: String
    var nextlabel: String
    var nextbgcolor: UIColor
    var nextButtonTapped: (() -> ())?
    var prevlabel: String
    var prevbgcolor: UIColor
    var prevButtonTapped: (() -> ())?
    
    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                HStack(spacing: 1) {
                    Button(prevlabel) {
                        self.prevButtonTapped?()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(prevbgcolor))
                    
                    //Spacer()

                    Button(nextlabel) {
                        self.nextButtonTapped?()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(nextbgcolor))
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
struct UIAlertControllerGuideView_Previews: PreviewProvider {
    static var previews: some View {
        return UIAlertControllerGuideView(
            title: "title",
            message: "message",
            nextlabel: "next",
            nextbgcolor: UIColor(Color.green),
            nextButtonTapped:  {
                // Do nothing
            },
            prevlabel: "back",
            prevbgcolor: UIColor(Color.red),
            prevButtonTapped: {
                // Do nothing
            }
        )
    }
}
