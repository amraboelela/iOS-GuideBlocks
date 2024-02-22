//
//  ContexualButton.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/17.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContexualButton: View {
    let button: SHTipButtonElement
    let containerSize: CGSize
    let action: () -> Void
    private let buttonSize: CGSize
    
    init(button: SHTipButtonElement, containerSize: CGSize, action: @escaping () -> Void) {
        self.button = button
        self.containerSize = containerSize
        self.buttonSize = button.buttonSize(containerSize: containerSize)
        self.action = action
        
    }
    var body: some View {
        HStack {
            
            Button(action: action, label: {
                
                Text(button.buttonText)
                    .frame(width: buttonSize.width, height: buttonSize.height, alignment: button.buttonTextAligment)
                    .background(Color(uiColor: button.backgroundColor ?? .black))
                    .foregroundStyle(Color(uiColor: button.textColor ?? .white))
                    .contextualButtonFormat(button)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: button.borderCornerRadius)
                            .stroke(Color(uiColor: button.borderColor), lineWidth: button.borderWidth)
                    })
                    .clipShape(RoundedRectangle(cornerRadius: button.borderCornerRadius))

                    .margin(button.margin)
            })
            if button.padding.hasNoLeftRightPadding && buttonSize.width != UIScreen.main.bounds.width {
                Spacer()
            }
            
        }
        
    }
}
