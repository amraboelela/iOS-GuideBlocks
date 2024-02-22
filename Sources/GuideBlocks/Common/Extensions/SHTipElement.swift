//
//  SHTipElement.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/16
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

extension SHTipElement {
    var containerSize: CGSize {
        return CGSize.sizeFromGuide(width: width, height: height)
    }
}
