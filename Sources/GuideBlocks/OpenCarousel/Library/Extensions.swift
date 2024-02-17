//
//  Extensions.swift
//  
//
//  Created by Aamir on 16/02/24.
//

import SwiftUI
import ContextualSDK

extension View {
    func contextualCarouselTitleElement(_ titleElement: SHTipCarouselItem?) -> some View {
        self.modifier(ContextualTextModifier(fontName: titleElement?.titleFontName,
                                             fontWeight: titleElement?.titleFontWeight,
                                             fontSize: titleElement?.titleFontSize,
                                             textColor: titleElement?.titleColor))
    }

    func contextualCarouselContentElement(_ contentElement: SHTipCarouselItem?) -> some View {
        self.modifier(ContextualTextModifier(fontName: contentElement?.contentFontName,
                                             fontWeight: contentElement?.contentFontWeight,
                                             fontSize: contentElement?.contentFontSize,
                                             textColor: contentElement?.contentColor))
    }
    func margin(_ margin: FourSide) -> some View {
        self.modifier(MarginModifier(margin: margin))
    }
}

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
