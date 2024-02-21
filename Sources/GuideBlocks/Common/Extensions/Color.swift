//
//  View.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import SwiftUI

extension Color {
    init(uiColor: UIColor) {
        if let components = uiColor.cgColor.components {
            switch components.count {
            case 2: // Grayscale color with alpha
                self.init(white: Double(components[0]), opacity: Double(components[1]))
            case 3: // RGB color without alpha
                self.init(red: Double(components[0]), green: Double(components[1]), blue: Double(components[2]))
            case 4: // RGB color with alpha
                self.init(red: Double(components[0]), green: Double(components[1]), blue: Double(components[2]), opacity: Double(components[3]))
            default:
                // Unsupported color format, fallback to black
                self.init(red: 0, green: 0, blue: 0, opacity: 1)
            }
        } else {
            // Unable to extract components, fallback to black
            self.init(red: 0, green: 0, blue: 0, opacity: 1)
        }
    }
}
