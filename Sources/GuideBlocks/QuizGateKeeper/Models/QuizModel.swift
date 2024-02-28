//
//  QuizModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

struct QuizModel: Codable {
    let guideBlockKey: String
    var questions: [QuestionModel]
    let fail: QuizActionModel
    let pass: QuizActionModel
}

struct QuestionModel: Codable {
    let question: String
    var answers: [AnswerModel]
    
    static func sampleAnswerModelWith(index: Int) -> AnswerModel {
        return AnswerModel(
            label: "Answer \(index)",
            correct: false
        )
    }
}

struct AnswerModel: Codable {
    let label: String
    var correct: Bool
}

public enum QuizActionType : String {
    case restartQuiz
    case setTag
}

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

struct QuizActionModel: Codable {
    var action: String
    let actionData: QuizActionData
    
    public var actionType: QuizActionType {
        get {
            return QuizActionType(rawValue:action) ?? .restartQuiz
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
