//
//  OpenChecklistView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct OpenChecklistView: View {
    @ObservedObject var openChecklistViewModel: OpenChecklistViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                openChecklistViewModel.isPopupVisible.toggle()
                print("Do list button tapped")
            }) {
                Text(openChecklistViewModel.title)
                    .foregroundColor(.white) // Set text color to white
                    .padding() // Add padding to the text
                    .background(Color.blue) // Set background color to sky blue
                    .cornerRadius(10) // Apply round rectangle shape with corner radius
            }
        }
        .sheet(isPresented: $openChecklistViewModel.isPopupVisible) {
            if #available(iOS 16.0, *) {
                TaskListView(viewModel: openChecklistViewModel)
                    .presentationDetents([.medium, .large])
            } else {
                TaskListView(viewModel: openChecklistViewModel)
            }
        }
    }
}

struct OpenChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        OpenChecklistView(openChecklistViewModel: openChecklistViewModel)
    }
}
