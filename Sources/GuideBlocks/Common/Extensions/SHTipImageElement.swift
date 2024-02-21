//
//  SHTipImageElement.swift
//  GuideBlocks
//
//  Created by Aamir on 2024/2/16
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

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
