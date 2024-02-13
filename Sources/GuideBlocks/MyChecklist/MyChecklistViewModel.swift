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
                actionData: TaskActionData(deepLink: "airbnb_contextual://screen/" + "task_\(i)")
            )
            result.append(taskModel)
        }
        taskModels = result
    }
    
    func load(tasks: Any?) {
        if let tasksArray = tasks as? NSArray, let tasksJson = tasksArray.toData() {
            if var resultTaskModels = try? JSONDecoder().decode([TaskModel].self, from: tasksJson) {
                for (i, taskModel) in resultTaskModels.enumerated() {
                    resultTaskModels[i].gotoScreenAction = { deepLink in
                        print("gotoScreenAction for task: \(taskModel.name), deepLink: \(deepLink)")
                        if let deepLinkURL = URL(string: deepLink) {
                            if UIApplication.shared.canOpenURL(deepLinkURL) {
                                UIApplication.shared.open(deepLinkURL)
                            } else {
                                print("Cannot open deeplink")
                            }
                        } else {
                            print("Invalid deeplink URL")
                        }
                    }
                }
                taskModels = resultTaskModels
            } else {
                print("couldn't JSON serialize data: \(tasksJson.hexEncodedString)")
            }
        }
    }
    
}
