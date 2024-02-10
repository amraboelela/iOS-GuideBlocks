//
//  ToDoTaskModel.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import Foundation

struct ToDoTaskModel: Hashable {
    var id: String
    var name: String
    var checked: Bool
    var enabled: Bool
    var action: ((String) -> Void)?
    
    // MARK: - Delegates
    
    static func == (lhs: ToDoTaskModel, rhs: ToDoTaskModel) -> Bool {
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
