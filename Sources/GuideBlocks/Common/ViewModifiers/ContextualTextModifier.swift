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
    let padding: FourSide?
    let fontName: String?
    let fontWeight: String?
    let fontSize: CGFloat?
    let textColor: UIColor?
    let backgroundColor: UIColor?
    
    var edgeInsets: EdgeInsets {
        if let padding {
            return EdgeInsets(
                top: padding.top,
                leading: padding.left,
                bottom: padding.bottom,
                trailing: padding.right
            )
        }
        return EdgeInsets(
            top: 16,
            leading: 16,
            bottom: 16,
            trailing: 16
        )
    }
    
    private var customFont: Font {
        var font = Font.system(size: fontSize ?? 17.0)

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
                    .padding(edgeInsets)
                    .font(customFont)
                    .foregroundColor(Color(textColor))
                    .background(Color(backgroundColor))
            } else {
                content
                    .padding(edgeInsets)
                    .font(customFont)
                    .foregroundColor(Color(textColor))
            }
        } else {
            if let backgroundColor {
                content
                    .padding(edgeInsets)
                    .font(customFont)
                    .background(Color(backgroundColor))
            } else {
                content
                    .padding(edgeInsets)
                    .font(customFont)
            }
        }
    }
}
