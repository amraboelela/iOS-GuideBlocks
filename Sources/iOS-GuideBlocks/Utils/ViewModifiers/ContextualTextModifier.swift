//
//  ContextualTextModifier.swift
//  airbnb-main
//
//  Created by Marc Stroebel on 22/1/2024.
//  Copyright © 2024 Yonas Stephen. All rights reserved.
//

import SwiftUI
import ContextualSDK

struct ContextualTextModifier: ViewModifier {
    let fontName: String?
    let fontWeight: String?
    let fontSize: CGFloat?
    let textColor: UIColor?
    let textAlignment: NSTextAlignment?
    
    func body(content: Content) -> some View {
        return content
            .font(self.customFont())
            .foregroundColor(self.customColor())
            .multilineTextAlignment(self.customAlignment())
    }
    
    private func customFont() -> Font {
        var font = Font.system(size: self.fontSize ?? 12.0)

        if let name = self.fontName {
            font = font.font(customName: name)
        }

        if let weight = self.fontWeight {
            switch weight {
            case "bold":
                font = font.weight(.bold)
                break
            default:
                font = font.weight(.regular)
                break
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
    
    private func customAlignment() -> TextAlignment {
        var alignment = TextAlignment.leading
        
        if let textAlignment = self.textAlignment {
            switch textAlignment {
            case NSTextAlignment.left:
                alignment = .leading
            case NSTextAlignment.right:
                alignment = .trailing
            case NSTextAlignment.center:
                alignment = .center
            case NSTextAlignment.justified:
                alignment = .leading
            case NSTextAlignment.natural:
                alignment = .leading
            default:
                alignment = .leading
            }
        }
        
        return alignment
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
        self.modifier(ContextualTextModifier(fontName: textElement?.fontName,
                                             fontWeight: textElement?.fontWeight,
                                             fontSize: textElement?.fontSize,
                                             textColor: textElement?.textColor,
                                             textAlignment: textElement?.alignment))
    }
    
    func contextualText(buttonElement: SHTipButtonElement?) -> some View {
        self.modifier(ContextualTextModifier(fontName: buttonElement?.fontName,
                                             fontWeight: buttonElement?.fontWeight,
                                             fontSize: buttonElement?.fontSize,
                                             textColor: buttonElement?.textColor,
                                             textAlignment: buttonElement?.alignment))
    }
}
