//
//  ViewModifiers.swift
//
//
//  Created by Aamir on 17/02/24.
//

import SwiftUI
import ContextualSDK

struct ContexualButton: View {
    let button: SHTipButtonElement
    let action: () -> Void
    var body: some View {
        HStack {
            
            Button(action: action, label: {
                
                Text(button.buttonText)
                    .frame(width: button.buttonSize.width, height: button.buttonSize.height, alignment: button.buttonTextAligment)
                    .background(Color(uiColor: button.backgroundColor ?? .black))
                    .foregroundStyle(Color(uiColor: button.textColor ?? .white))
                    .contextualButtonFormat(button)
                    .clipShape(RoundedRectangle(cornerRadius: button.borderCornerRadius))
                    .border(Color(uiColor: button.borderColor ?? .clear), width: button.borderWidth)
                    .margin(button.margin)
            })
            if button.padding.hasNoLeftRightPadding && button.buttonSize.width != UIScreen.main.bounds.width {
                Spacer()
            }
            
        }
        
    }
}
