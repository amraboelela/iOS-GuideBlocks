//
//  PlaceholderViews.swift
//  GuideBlocks
//
//  Created by Aamir on 23/02/24.
//  Copyright © 2024 Contextual.
//

import Foundation
import SwiftUI


struct PlaceholderSubtitleView: View {
    
    //Used just to display subtitle with number(id).
    let id: Int
    
    var body: some View {
        Text("\(Constants.PlaceholderTexts.subtitle) \(id)")
            .font(.headline)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 250)
            .foregroundColor(.red)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 2, y: 2)

    }
}

struct PlaceholderTitleView: View {
    
    //Used just to display subtitle with number(id).
    let id: Int
    
    var body: some View {
        Text("\(Constants.PlaceholderTexts.title) \(id)")
            .font(.title2)
            .bold()
            .foregroundColor(.white)

    }
}
