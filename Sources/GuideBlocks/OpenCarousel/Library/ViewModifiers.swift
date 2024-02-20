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
                    .clipShape(RoundedRectangle(cornerRadius: button.borderCornerRadius))
                    .border(Color(uiColor: button.borderColor ?? .clear), width: button.borderWidth)
                    .margin(button.margin)
            })
            if button.padding.hasNoLeftRightPadding && buttonSize.width != UIScreen.main.bounds.width {
                Spacer()
            }
            
        }
        
    }
}

struct MarginModifier: ViewModifier {
    let margin: FourSide
    
    func body(content: Content) -> some View {
        return content
            .padding(.top, margin.top)
            .padding(.bottom, margin.bottom)
            .padding(.leading, margin.left)
            .padding(.trailing, margin.right)

    }
}



