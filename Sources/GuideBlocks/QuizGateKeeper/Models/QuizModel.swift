//
//  QuizModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

struct AnswerModel: Codable {
    let label: String
    var correct: Bool
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

struct QuizAction: Codable {
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

struct QuizModel: Codable {
    var contextualContainer: ContextualContainer?
    
    let guideBlockKey: String
    var questions: [QuestionModel]
    let fail: QuizAction
    let pass: QuizAction
    
    var correctCount = 0
    
    enum CodingKeys: String, CodingKey {
        case guideBlockKey
        case questions
        case fail
        case pass
    }
    
    mutating func performAction() {
        var actionData: QuizActionData
        if correctCount < questions.count { // fail
            actionData = fail.actionData
            switch pass.actionType {
            case .restartQuiz:
                print("performAction, pass, restartQuiz")
            case .goHome:
                print("performAction, pass, goHome")
            }
        } else { // pass
            actionData = pass.actionData
            switch fail.actionType {
            case .restartQuiz:
                print("performAction, fail, restartQuiz")
            case .goHome:
                print("performAction, fail, goHome")
            }
        }
        correctCount = 0
        if let tagKey = actionData.tagKey, let tagValue = actionData.tagValue {
            if tagValue == "@now" {
                contextualContainer?.tagManager.saveTag(
                    key: tagKey,
                    value: Date.now,
                    success: nil,
                    failure: nil,
                    forceSend: false
                )
            } else {
                contextualContainer?.tagManager.saveTag(
                    key: tagKey,
                    value: tagValue,
                    success: nil,
                    failure: nil,
                    forceSend: false
                )
            }
        }
    }
}

