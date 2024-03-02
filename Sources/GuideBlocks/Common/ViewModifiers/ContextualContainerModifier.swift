//
//  ContextualContainerModifier.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/3/1.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualContainerModifier: ViewModifier {
    let padding: FourSide?
    let backgroundColor: UIColor?
    
    var edgeInsets: EdgeInsets? {
        if let padding {
            return EdgeInsets(
                top: padding.top,
                leading: padding.left,
                bottom: padding.bottom,
                trailing: padding.right
            )
        } else {
            return nil
        }
    }
    
    func body(content: Content) -> some View {
        if let edgeInsets {
            if let backgroundColor {
                content
                    .padding(edgeInsets)
                    .background(Color(backgroundColor))
            } else {
                content
                    .padding(edgeInsets)
            }
        } else {
            if let backgroundColor {
                content
                    .background(Color(backgroundColor))
            } else {
                content
            }
        }
    }
}
