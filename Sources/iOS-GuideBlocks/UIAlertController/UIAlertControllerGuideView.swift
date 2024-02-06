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
    var nextButtonTapped: (() -> ())?
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

                HStack(spacing: 16) {
                    Button("Cancel") {
                        self.prevButtonTapped?()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    
                    Spacer()

                    Button(nextlabel) {
                        self.nextButtonTapped?()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
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
            nextButtonTapped:  {
                // Do nothing
            },
            prevButtonTapped: {
                // Do nothing
            }
        )
    }
}
