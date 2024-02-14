//
//  OpenChecklistViewModel.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import Foundation
import SwiftUI

let openChecklistViewModel = OpenChecklistViewModel()

class OpenChecklistViewModel : ObservableObject {
    var contextualContainer: ContextualContainer?
    
    @Published var isPopupVisible: Bool = false
    @Published var title = "Do List"
    @Published var taskModels = [TaskModel]()
    
    init() {
        loadWithSampleTasks()
    }
    
    func loadWithSampleTasks() {
        var result = [TaskModel]()
        for i in 1...12 {
            let taskModel = TaskModel(
                name: "Task \(i)",
                rawActionType: "gotoScreen",
                actionData: TaskActionData(deepLink: "airbnbContextual://screen/" + "task_\(i)")
            )
            result.append(taskModel)
        }
        taskModels = result
    }
    
    func load(tasks: Any?) {
        if let tasksArray = tasks as? NSArray, let tasksJson = tasksArray.toData() {
            if var resultTaskModels = try? JSONDecoder().decode([TaskModel].self, from: tasksJson) {
                for (i, taskModel) in resultTaskModels.enumerated() {
                    resultTaskModels[i].gotoScreenAction = { deepLinkURL in
                        print("gotoScreenAction for task: \(taskModel.name), deepLinkURL: \(deepLinkURL)")
                        //if let deepLinkURL = URL(string: deepLink) {
                        if UIApplication.shared.canOpenURL(deepLinkURL) {
                            UIApplication.shared.open(deepLinkURL)
                        } else {
                            print("Cannot open deeplink")
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
