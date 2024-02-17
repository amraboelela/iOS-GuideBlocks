//
//  CustomButtonStyle.swift
//  GuideBlocksSDK
//
//  Created by Marc Stroebel on 2023/3/31.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let bgColor : Color
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label            
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .frame(minWidth: 104, minHeight: 40)
            
            .background(bgColor)
            .cornerRadius(20.0)
            .foregroundColor(Color.white)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.easeInOut(duration: 0.2))
    }
}
