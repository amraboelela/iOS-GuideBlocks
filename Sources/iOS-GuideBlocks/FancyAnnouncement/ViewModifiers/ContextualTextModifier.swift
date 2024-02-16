//
//  ContextualTextModifier.swift
//  airbnb-main
//
//  Created by Marc Stroebel on 22/1/2024.
//  Copyright © 2024 Yonas Stephen. All rights reserved.
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
                    .contextualText(buttonElement: button)
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



struct ContextualTextModifier: ViewModifier {
    let fontName: String?
    let fontWeight: String?
    let fontSize: CGFloat?
    let textColor: UIColor?
    
    func body(content: Content) -> some View {
        return content.font(self.customFont()).foregroundColor(self.customColor())
    }
    
    private func customFont() -> Font {
        var font = Font.system(size: self.fontSize ?? 12.0)

        if let name = self.fontName {
            font = font.font(customName: name,size: self.fontSize)
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
}

extension Font {
    func font(customName name: String,size: CGFloat? = nil) -> Font {
        if let customFont = UIFont(name: name, size: size ?? UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).pointSize) {
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
                                             textColor: textElement?.textColor))
    }
    
    func contextualText(buttonElement: SHTipButtonElement?) -> some View {
        self.modifier(ContextualTextModifier(fontName: buttonElement?.fontName,
                                             fontWeight: buttonElement?.fontWeight,
                                             fontSize: buttonElement?.fontSize,
                                             textColor: buttonElement?.textColor))
    }
    
    func contextualCarouselTitleElement(_ titleElement: SHTipCarouselItem?) -> some View {
        self.modifier(ContextualTextModifier(fontName: titleElement?.titleFontName,
                                             fontWeight: titleElement?.titleFontWeight,
                                             fontSize: titleElement?.titleFontSize,
                                             textColor: titleElement?.titleColor))
    }
    
    func contextualCarouselContentElement(_ contentElement: SHTipCarouselItem?) -> some View {
        self.modifier(ContextualTextModifier(fontName: contentElement?.contentFontName,
                                             fontWeight: contentElement?.contentFontWeight,
                                             fontSize: contentElement?.contentFontSize,
                                             textColor: contentElement?.contentColor))
    }
    func margin(_ margin: FourSide) -> some View {
        self.modifier(MarginModifier(margin: margin))
    }
}
