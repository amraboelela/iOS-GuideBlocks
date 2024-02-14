//
//  OpenChecklistView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct OpenChecklistView: View {
    @ObservedObject var viewModel: OpenChecklistViewModel
    
    var body: some View {
        VStack {
            if viewModel.taskListVisible {
                Button(action: {
                    viewModel.isPopupVisible.toggle()
                    print("Do list button tapped")
                }) {
                    Text(viewModel.title)
                        .foregroundColor(.white) // Set text color to white
                        .padding() // Add padding to the text
                        .background(Color.blue) // Set background color to sky blue
                        .cornerRadius(10) // Apply round rectangle shape with corner radius
                }
            }
        }
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

struct OpenChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        OpenChecklistView(viewModel: openChecklistViewModel)
    }
}
