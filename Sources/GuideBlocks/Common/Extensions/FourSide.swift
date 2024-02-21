//
//  FourSide.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/16
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

extension FourSide {
    var hasNoLeftRightPadding: Bool {
        return self.left == 0 && self.right == 0
    }
}
