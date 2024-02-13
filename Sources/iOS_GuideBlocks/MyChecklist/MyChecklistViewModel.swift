//
//  MyChecklistViewModel.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import Foundation
import SwiftUI

let myChecklistViewModel = MyChecklistViewModel()

class MyChecklistViewModel : ObservableObject {
    var contextualContainer: ContextualContainer?
    @Published var title = "Do List"
    @Published var taskModels = [TaskModel]()
    
    init() {
        loadWithSampleTasks()
    }
    
    func taskModelBinding(forIndex index: Int) -> Binding<TaskModel> {
        Binding(
            get: { self.taskModels[index] },
            set: { self.taskModels[index] = $0 }
        )
    }
    
    func loadWithSampleTasks() {
        var result = [TaskModel]()
        for i in 1...12 {
            let taskModel = TaskModel(
                name: "Task \(i)",
                rawActionType: "gotoScreen",
                taskActionData: TaskActionData(deepLink: "airbnb_contextual://screen/" + "task_\(i)")
            )
            result.append(taskModel)
        }
        taskModels = result
    }
    
    func load(tasksJson: Data) {
        if let result = try? JSONDecoder().decode([TaskModel].self, from: tasksJson) {
            taskModels = result
        } else {
            print("couldn't JSON serialize data: \(tasksJson.hexEncodedString)")
        }
        /*
        if let taskModels = try? JSONDecoder().decode([TaskModel.self], from: tasksData) {
            taskModels = taskModels
        }*/
        /*
        var result = [TaskModel]()
        for (i, task) in tasks.enumerated() {
            var taskModel = TaskModel(
                name: task, deepLink: <#String#>
                /*action: { _ in
                    print("Action for task \(i)")
                    //taskModel.checked = true
                }*/
            )
            taskModel.action = { _ in
                print("Action for \(taskModel.name)")
                taskModel.checked = true
            }
            result.append(taskModel)
        }
        taskModels = result*/
    }
    
}
