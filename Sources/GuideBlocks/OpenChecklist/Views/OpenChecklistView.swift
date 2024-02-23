//
//  OpenChecklistView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct OpenChecklistView: View {
    var buttonTextElement: SHTipTextElement?
    var imageElement: SHTipImageElement?
    @ObservedObject var viewModel: OpenChecklistViewModel
    var closeButtonTapped: () -> ()
    
    var body: some View {
        VStack {
            if viewModel.taskListVisible {
                Button(
                    action: {
                        viewModel.isPopupVisible.toggle()
                        print("Do list button tapped")
                    },
                    label: {
                        Text(viewModel.title)
                            .contextualTextFormat(buttonTextElement)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                )
                .padding(40)
                //.background(Color.yellow)
                .overlay(
                    CloseButton(
                        imageElement: imageElement,
                        closeButtonTapped: {
                            closeButtonTapped()
                            viewModel.taskListVisible = false
                        }
                    ),
                    alignment: .topTrailing
                )
            }
        }
    }
}

struct OpenChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        OpenChecklistView(
            viewModel: openChecklistViewModel,
            closeButtonTapped: {
            }
        )
    }
}
