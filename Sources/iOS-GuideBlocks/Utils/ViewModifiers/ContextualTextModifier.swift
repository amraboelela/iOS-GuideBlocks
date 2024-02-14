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
    
    func body(content: Content) -> some View {
        content
            .font(customFont())
            .foregroundColor(customColor())
    }
    
    private func customFont() -> Font {
        var font = Font.system(size: fontSize ?? 12.0)

        if let name = fontName {
            font = font.font(customName: name)
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
    
    private func customColor() -> Color {
        var color = Color.black
        
        if let textColor = self.textColor {
           var red: CGFloat = 0
           var green: CGFloat = 0
           var blue: CGFloat = 0
           var alpha: CGFloat = 0
           textColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
           color = Color(red: red, green: green, blue: blue).opacity(alpha)
        }
        
        return color
    }
}

extension Font {
    func font(customName name: String) -> Font {
        if let customFont = UIFont(name: name, size: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).pointSize) {
            return Font(customFont)
        } else {
            return self
        }
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
