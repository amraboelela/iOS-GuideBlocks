//
//  MyChecklistViewModel.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import Foundation

class MyChecklistViewModel : ObservableObject {
    @Published var title = "Do List"
    @Published var taskModels = [ToDoTaskModel]()
    
    init() {
        loadWithSampleTasks()
    }
    
    func loadWithSampleTasks() {
        var result = [ToDoTaskModel]()
        for i in 1...12 {
            let taskModel = ToDoTaskModel(
                id: "task\(i)",
                name: "Task \(i)",
                checked: i.isPrime(),
                enabled: true,
                action: { text in print("Action for task \(i)") }
            )
            result.append(taskModel)
        }
        taskModels = result
    }
    
    func load(tasks: [String]) {
        var result = [ToDoTaskModel]()
        for (i, task) in tasks.enumerated() {
            let taskModel = ToDoTaskModel(
                id: "task\(i)",
                name: task,
                checked: i.isPrime(),
                enabled: true,
                action: { text in print("Action for task \(i)") }
            )
            result.append(taskModel)
        }
        taskModels = result
    }
    
}
