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
    @ObservedObject var viewModel: OpenChecklistViewModel
    var closeButtonTapped: () -> ()
    
    var container: SHTipElement? {
        viewModel.contextualContainer?.guidePayload.guide
    }
    
    var title: String {
        container?.title.text ?? "Do List"
    }
    
    var body: some View {
        VStack {
            if viewModel.taskListVisible {
                Button(
                    action: {
                        viewModel.isPopupVisible.toggle()
                        print("Do list button tapped")
                    },
                    label: {
                        Text(title)
                            .contextualContainerFormat(container)
                            .contextualTextFormat(container?.title)
                            .contextualTextFormat(container?.content)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                )
                .padding(40)
                //.background(Color.yellow)
                .overlay(
                    CloseButton(
                        imageElement: container?.arrayImages.first,
                        closeButtonTapped: {
                            closeButtonTapped()
                            viewModel.taskListVisible = false
                        }
                    ),
                    alignment: .topTrailing
                )
                .sheet(isPresented: $viewModel.isPopupVisible) {
                    if #available(iOS 16.0, *) {
                        TaskListView(viewModel: viewModel)
                            .presentationDetents([.medium, .large])
                    } else {
                        TaskListView(viewModel: viewModel)
                    }
                }
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
