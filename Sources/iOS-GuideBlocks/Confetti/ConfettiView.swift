//
//  ConfettiView.swift
//  iOS-GuideBlocks
//
//  Created by Marc Stroebel on 8/12/2023.
//  Copyright © 2023 Yonas Stephen.
//

import SwiftUI
import ConfettiSwiftUI

struct ConfettiView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        Button("") {
        }
        .onAppear() {
            counter += 1
        }
        .confettiCannon(counter: $counter)
    }
}
