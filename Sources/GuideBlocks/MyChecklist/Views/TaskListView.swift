//
//  TaskListView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: MyChecklistViewModel
    @State private var isPopupVisible = false
    
    var body: some View {
        VStack {
            List(viewModel.taskModels.indices, id: \.self) { index in
                TaskView(taskModel: viewModel.taskModelBinding(forIndex: index))
                Button(action: {
                    print("Tapped on task \(viewModel.taskModels[index].name)")
                }) {
                    Text("Tap me")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(viewModel: myChecklistViewModel)
    }
}
