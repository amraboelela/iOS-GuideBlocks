//
//  Font.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import SwiftUI

extension Font {
    func fontWith(name: String, size: CGFloat? = nil) -> Font {
        if let customFont = UIFont(
            name: name,
            size: size ?? UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).pointSize
        ) {
            return Font(customFont)
        } else {
            return self
        }
    }
}
