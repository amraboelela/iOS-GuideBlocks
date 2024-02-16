//
//  Extensions.swift
//  
//
//  Created by Aamir on 16/02/24.
//

import SwiftUI
import ContextualSDK

extension SHTipButtonElement {
    
    var buttonTextAligment: Alignment {
        
        if self.alignment == .center {
            return .center
        } else if self.alignment == .left {
            return .leading
        } else if self.alignment == .right {
            return .trailing
        }
        return .center
    }
    
    var buttonSize: CGSize {
        
        return CGSize.sizeFromGuide(width: width, height: height)
    }
}

extension FourSide {
    var hasNoLeftRightPadding: Bool {
        return self.left == 0 && self.right == 0
    }
}


extension SHTipImageElement {
    
    var imageSize: CGSize {
        return CGSize.sizeFromGuide(width: width, height: height)
    }
    
    var imageAligment: Alignment {
        
        if imageAlign == SHTipImageAlignment_LeftTop {
            return .topLeading
        }
        else if imageAlign == SHTipImageAlignment_LeftMiddle {
            return .leading
        }
        else if imageAlign == SHTipImageAlignment_LeftBottom {
            return .bottomLeading
        }
        else if imageAlign == SHTipImageAlignment_CenterTop {
            return .top
        }
        else if imageAlign == SHTipImageAlignment_CenterMiddle {
            return .center
        }
        else if imageAlign == SHTipImageAlignment_CenterBottom {
            return .bottom
        }
        else if imageAlign == SHTipImageAlignment_RightTop {
            return .topTrailing
        }
        else if imageAlign == SHTipImageAlignment_RightMiddle {
            return .trailing
        }
        else if imageAlign == SHTipImageAlignment_RightBottom {
            return .bottomTrailing
        }
        return .topLeading
    }
}

extension CGSize {
    static func sizeFromGuide(width: CGFloat, height: CGFloat) -> CGSize {
        
        let percentRange = 0.0...1.0
        
        var width_height: (width: CGFloat,height: CGFloat) = (width, height)
        let screenSize = UIScreen.main.bounds
        
        if percentRange.contains(width) {
        
            width_height.width = screenSize.width * width
        }
        
        if percentRange.contains(height) {
            width_height.height = screenSize.height * height
        }

        
        return CGSize(width: width_height.width, height: width_height.height)
    }
}
