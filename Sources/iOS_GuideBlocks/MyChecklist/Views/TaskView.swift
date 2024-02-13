//
//  TaskView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct TaskView: View {
    @Binding var taskModel: TaskModel
    
    var body: some View {
        Button(action: {
            if taskModel.enabled {
                print("Action for task \(taskModel.name)")
                taskModel.checked = true
            }
        }) {
            HStack {
                Text(taskModel.name)
                Spacer()
                Image(systemName: taskModel.checked ? "checkmark.square.fill" : "square.fill")
                    .foregroundColor(taskModel.checked ? .green : .gray)
            }
            .foregroundColor(taskModel.enabled ? .primary : .gray)
        }
        .disabled(taskModel.enabled)
    }
}

struct TaskView_Previews: PreviewProvider {
    @State static var taskModel = TaskModel(
        name: "Task 1",
        rawActionType: "gotoScreen",
        taskActionData: TaskActionData(
            deepLink: "airbnb_contextual://screen/screen_1"
        ))
    
    static var previews: some View {
        TaskView(taskModel: $taskModel)
    }
}
