//
//  FancyAnnouncementView.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/11/7.
//  Copyright © 2023 Contextual.
//


import ContextualSDK
import SwiftUI

struct FrameModifier: ViewModifier {
    let condition: Bool?
    let width: CGFloat?
    let height: CGFloat?

    func body(content: Content) -> some View {
        guard let condition = condition else {
            return AnyView(content)
        }
        
        if condition {
            return AnyView(content.frame(width: width ?? .infinity,
                                         height: height ?? .infinity))
        } else {
            return AnyView(content)
        }
    }
}
