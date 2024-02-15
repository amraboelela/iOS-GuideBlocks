//
//  View.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

extension View {
    func contextualTextFormat(_ textElement: SHTipTextElement?) -> some View {
        modifier(
            ContextualTextModifier(
                fontName: textElement?.fontName,
                fontWeight: textElement?.fontWeight,
                fontSize: textElement?.fontSize,
                textColor: textElement?.textColor
            )
        )
    }
    
    func contextualButtonFormat(_ buttonElement: SHTipButtonElement?) -> some View {
        modifier(
            ContextualButtonModifier(
                fontName: buttonElement?.fontName,
                fontWeight: buttonElement?.fontWeight,
                fontSize: buttonElement?.fontSize,
                textColor: buttonElement?.textColor,
                backgroundColor: buttonElement?.backgroundColor
            )
        )
    }
}
