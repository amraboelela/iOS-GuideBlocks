//
//  TaskModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

public enum TaskActionType : String {
    case gotoScreen
    case setTag
    case checkTag
}

public enum TagType : String {
    case int
    case string
}

public enum TagOperator : String {
    case gte // greater than or equals
    case lte // less than or equals
    case equ // equals
}

struct TaskActionData: Codable {
    var deepLink: String? // e.g. "airbnbContextual://screen/profile"
    var tagKey: String?
    var tagValue: String?
    var rawTagType: String?
    var rawTagOperator: String?
    
    var tagType: TagType {
        get {
            return TagType(rawValue:rawTagType ?? "unknown") ?? .int
        }
        set {
            self.rawTagType = newValue.rawValue
        }
    }
    
    var tagOperator: TagOperator {
        get {
            return TagOperator(rawValue:rawTagOperator ?? "equ") ?? .equ
        }
        set {
            self.rawTagOperator = newValue.rawValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case deepLink = "deep_link"
        case tagKey = "key"
        case tagValue = "value"
        case rawTagType = "type"
    }
}

struct TaskModel: Codable, Hashable {
    var contextualContainer: ContextualContainer?
    
    var name: String
    var action: String
    var actionData: TaskActionData
    
    var gotoScreenAction: ((URL) -> ())?
    
    var id: String {
        return name.lowercased()
            .trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: " ", with: "_")
    }
    
    public var actionType: TaskActionType {
        get {
            return TaskActionType(rawValue:action) ?? .gotoScreen
        }
        set {
            self.action = newValue.rawValue
        }
    }
    
    var checkedKey: String {
        return id + "_checked"
    }
    
    var checked: Bool {
        get {
            let tagValue = contextualContainer?.tagManager.getTagValue(key: checkedKey)
            return tagValue == "true"
        }
        set {
            contextualContainer?.tagManager.saveTag(
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
    
    enum CodingKeys: String, CodingKey {
        case name
        case action
        case actionData = "action_data"
    }
    
    var deepLinkURL: URL? {
        if let deepLink = actionData.deepLink, let result = URL(string: deepLink) {
            return result
        } else {
            print("Invalid deeplink URL, actionData.deepLink: \(actionData.deepLink ?? "")")
        }
        return nil
    }
    
    static func sampleTaskModelWith(index: Int) -> TaskModel {
        return TaskModel(
            name: "Task \(index)",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/" + "task_\(index)")
        )
    }
    
    func compare(value1: String, value2: String, tagType: TagType, tagOperator: TagOperator) -> Bool {
        switch tagType {
        case .int:
            if let intValue1 = Int(value1), let intValue2 = Int(value2) {
                switch tagOperator {
                case .gte:
                    return intValue1 >= intValue2
                case .lte:
                    return intValue1 <= intValue2
                case .equ:
                    return intValue1 == intValue2
                }
            }
        case .string:
            return value1 == value2
        }
        return false
    }
    
    var favouritedCount = 0
    
    mutating func doTheAction() {
        switch actionType {
        case .gotoScreen:
            checked = true
            if let deepLinkURL {
                gotoScreenAction?(deepLinkURL)
            }
        case .setTag:
            checked = true
            if let tagKey = actionData.tagKey, let tagValue = actionData.tagValue {
                contextualContainer?.tagManager.saveTag(
                    key: tagKey,
                    value: tagValue,
                    success: nil,
                    failure: nil,
                    forceSend: false
                )
            }
        case .checkTag:
            print("TaskModel, doTheAction, checkTag actionType")
            if let tagKey = actionData.tagKey, let expectedTagValue = actionData.tagValue {
                
                favouritedCount += 1
                // TODO: remove when not testing
                contextualContainer?.tagManager.saveTag(
                    key: tagKey,
                    value: "\(favouritedCount)",
                    success: nil,
                    failure: nil,
                    forceSend: false
                )
                
                if let tagValue = contextualContainer?.tagManager.getTagValue(key: tagKey) {
                    checked = compare(
                        value1: tagValue,
                        value2: expectedTagValue,
                        tagType: actionData.tagType,
                        tagOperator: actionData.tagOperator
                    )
                }
            }
        }
    }
    
    // MARK: - Delegates
    
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
