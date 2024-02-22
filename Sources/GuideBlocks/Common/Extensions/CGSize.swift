//
//  CGSize.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/16
//  Copyright © 2024 Contextual.
//

import SwiftUI

extension CGSize {
    static func sizeFromGuide(width: CGFloat, height: CGFloat, containerSize: CGSize = UIScreen.main.bounds.size) -> CGSize {
        
        let percentRange = 0.0...1.0
        
        var width_height: (width: CGFloat,height: CGFloat) = (width, height)
//        let screenSize = UIScreen.main.bounds
        
        if percentRange.contains(width) {
        
            width_height.width = containerSize.width * width
        }
        
        if percentRange.contains(height) {
            width_height.height = containerSize.height * height
        }

        
        return CGSize(width: width_height.width, height: width_height.height)
    }
}
