//
//  ContextualImageModifier.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/15.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct ContextualImageModifier: ViewModifier {
    let width: CGFloat?
    let height: CGFloat?
    let backgroundColor: UIColor?
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .background(backgroundColor.map { Color($0) })
    }
}
