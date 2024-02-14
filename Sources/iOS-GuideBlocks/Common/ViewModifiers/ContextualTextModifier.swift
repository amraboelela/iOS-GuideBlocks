//
//  ContextualTextModifier.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2024/1/22.
//  Copyright © 2024 Contextual.
//

import SwiftUI
import ContextualSDK

struct ContextualTextModifier: ViewModifier {
    let fontName: String?
    let fontWeight: String?
    let fontSize: CGFloat?
    let textColor: UIColor?
    
    private var customFont: Font {
        var font = Font.system(size: fontSize ?? 12.0)

        if let fontName {
            font = font.fontWith(name: fontName)
        }

        if let weight = fontWeight {
            switch weight {
            case "bold":
                font = font.weight(.bold)
            default:
                font = font.weight(.regular)
            }
        }
        return font
    }
    
    private var customColor: Color {
        if let textColor {
            return Color(textColor)
        } else {
            return Color.black
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(customFont)
            .foregroundColor(customColor)
    }
}

extension View {
    func contextualText(textElement: SHTipTextElement?) -> some View {
        modifier(ContextualTextModifier(
            fontName: textElement?.fontName,
            fontWeight: textElement?.fontWeight,
            fontSize: textElement?.fontSize,
            textColor: textElement?.textColor
        ))
    }
    
    func contextualText(buttonElement: SHTipButtonElement?) -> some View {
        modifier(ContextualTextModifier(
            fontName: buttonElement?.fontName,
            fontWeight: buttonElement?.fontWeight,
            fontSize: buttonElement?.fontSize,
            textColor: buttonElement?.textColor
        ))
    }
}
