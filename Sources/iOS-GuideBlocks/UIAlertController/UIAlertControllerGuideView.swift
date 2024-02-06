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
    var okButtonTapped: (() -> ())?
    var cancelButtonTapped: (() -> ())?
    
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
                        self.cancelButtonTapped?()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    
                    Spacer()

                    Button("OK") {
                        self.okButtonTapped?()
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
            okButtonTapped:  {
                // Do nothing
            },
            cancelButtonTapped: {
                // Do nothing
            }
        )
    }
}
