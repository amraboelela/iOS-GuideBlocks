//
//  TaskModel.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import Foundation

public enum TaskActionType : String {
    case setTag
    case gotoScreen
    case unknown
}

struct TaskActionData: Codable {
    var deepLink: String? // e.g. "airbnb_contextual://screen/profile"
    var tagKey: String?
    var tagValue: String?
    
    public enum CodingKeys: String, CodingKey {
        case deepLink = "deep_link"
        case tagKey = "key"
        case tagValue = "value"
    }
}

struct TaskModel: Codable, Hashable {
    
    var name: String
    var rawActionType: String
    var taskActionData: TaskActionData
    
    var id: String {
        return name.lowercased()
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: " ", with: "_")
    }
    
    public var actionType: TaskActionType {
        get {
            return TaskActionType(rawValue:rawActionType) ?? .unknown
        }
        set {
            self.rawActionType = newValue.rawValue
        }
    }
    
    var checkedKey: String {
        return id + "_checked"
    }
    
    var checked: Bool {
        get {
            let tagValue = myChecklistViewModel.contextualContainer?.tagManager.getTagValue(
                key: checkedKey
            )
            return tagValue == "true"
        }
        set {
            myChecklistViewModel.contextualContainer?.tagManager.saveTag(
                key: checkedKey,
                value: "\(newValue)",
                success: nil,
                failure: nil,
                forceSend: false
            )
        }
    }
    
    var enabled: Bool {
        return !checked
    }
    
    public enum CodingKeys: String, CodingKey {
        case name
        case rawActionType = "action"
        case taskActionData = "action_data"
    }
    
    // MARK: - Delegates
    
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
