//
//  ContexualDismissButton.swift
//  GuideBlocks
//
//  Created by Aamir on 02/03/24.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContexualDismissButton: View {
    let button: SHTipDismissElement
    let containerSize: CGSize
    let action: () -> Void
    private let buttonSize: CGSize
    
    init(button: SHTipDismissElement, containerSize: CGSize, action: @escaping () -> Void) {
        self.button = button
        self.containerSize = containerSize
        self.buttonSize = button.buttonSize(containerSize: containerSize)
        self.action = action
        
    }
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: buttonSize.width, height: buttonSize.height)
                .background(Color(uiColor: button.backgroundColor ?? .black))
                .foregroundStyle(Color(uiColor: button.buttonColor ?? .white))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: button.borderCornerRadius)
                        .stroke(Color(uiColor: button.borderColor == nil ? .clear : button.borderColor), lineWidth: button.borderWidth)
                })
                .clipShape(RoundedRectangle(cornerRadius: button.borderCornerRadius))
                .margin(button.margin)
        })
    }
}
