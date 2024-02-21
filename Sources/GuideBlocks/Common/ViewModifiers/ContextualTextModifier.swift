//
//  ContextualTextModifier.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2024/1/22.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualTextModifier: ViewModifier {
    let fontName: String?
    let fontWeight: String?
    let fontSize: CGFloat?
    let textColor: UIColor?
    let backgroundColor: UIColor?
    
    private var customFont: Font {
        var font = Font.system(size: fontSize ?? 12.0)

        if let fontName {
            font = font.fontWith(name: fontName, size: fontSize)
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
    
    func body(content: Content) -> some View {
        if let textColor {
            if let backgroundColor {
                content
                    .font(customFont)
                    .foregroundColor(Color(textColor))
                    .background(Color(backgroundColor))
            } else {
                content
                    .font(customFont)
                    .foregroundColor(Color(textColor))
            }
        } else {
            if let backgroundColor {
                content
                    .font(customFont)
                    .background(Color(backgroundColor))
            } else {
                content
                    .font(customFont)
            }
        }
    }
}
