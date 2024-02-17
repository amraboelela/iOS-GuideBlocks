//
//  ContextualButtonModifier.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualButtonModifier: ViewModifier {
    let fontName: String?
    let fontWeight: String?
    let fontSize: CGFloat?
    let textColor: UIColor?
    let backgroundColor: UIColor?
    
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
    
    func body(content: Content) -> some View {
        content
            .font(customFont)
            .foregroundColor(textColor.map { Color($0) })
            .background(backgroundColor.map { Color($0) })
            .tint(backgroundColor.map { Color($0) })
    }
}
