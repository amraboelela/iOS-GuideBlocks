//
//  QuizActionModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

struct QuizActionData: Codable {
    var tagKey: String?
    var tagValue: String?
    let allowScreenAccess: Bool
    let attempts: Int?
    let lockoutSeconds: Int?
    
    enum CodingKeys: String, CodingKey {
        case tagKey = "key"
        case tagValue = "value"
        case allowScreenAccess = "allow_screen_access"
        case attempts
        case lockoutSeconds = "lockout_seconds"
    }
}

public enum QuizActionType : String {
    case restartQuiz
    case goHome
}

struct QuizActionModel: Codable {
    var action: String
    let actionData: QuizActionData
    
    public var actionType: QuizActionType {
        get {
            return QuizActionType(rawValue:action) ?? .goHome
        }
        set {
            self.action = newValue.rawValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case action
        case actionData = "action_data"
    }
}

