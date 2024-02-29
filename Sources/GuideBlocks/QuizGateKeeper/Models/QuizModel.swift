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
    
    static var sampleAnswer11: AnswerModel {
        return AnswerModel(
            label: "It is this way",
            correct: false
        )
    }
    
    static var sampleAnswer12: AnswerModel {
        return AnswerModel(
            label: "It is that way",
            correct: true
        )
    }
    
    static var sampleAnswer13: AnswerModel {
        return AnswerModel(
            label: "It is no way",
            correct: false
        )
    }
    
    static var sampleAnswer21: AnswerModel {
        return AnswerModel(
            label: "It is all the way",
            correct: false
        )
    }
    
    static var sampleAnswer22: AnswerModel {
        return AnswerModel(
            label: "It is some way",
            correct: false
        )
    }
    
    static var sampleAnswer23: AnswerModel {
        return AnswerModel(
            label: "It is the correct way",
            correct: true
        )
    }
}

struct QuestionModel: Codable {
    let question: String
    var answers: [AnswerModel]
    
    static var sampleQuestion1: QuestionModel {
        return QuestionModel(
            question: "What is it?",
            answers: [
                AnswerModel.sampleAnswer11,
                AnswerModel.sampleAnswer12,
                AnswerModel.sampleAnswer13
            ]
        )
    }
    
    static var sampleQuestion2: QuestionModel {
        return QuestionModel(
            question: "Why is what?",
            answers: [
                AnswerModel.sampleAnswer21,
                AnswerModel.sampleAnswer22,
                AnswerModel.sampleAnswer23
            ]
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
    
    static var sampleQuiz: QuizModel {
        return QuizModel(
            guideBlockKey: "QuizGateKeeper",
            questions: [QuestionModel.sampleQuestion1, QuestionModel.sampleQuestion2],
            fail: QuizAction(
                action: "restartQuiz",
                actionData: QuizActionData(
                    allowScreenAccess: false,
                    attempts: 2,
                    lockoutSeconds: 600
                )
            ),
            pass: QuizAction(
                action: "goHome",
                actionData: QuizActionData(
                    allowScreenAccess: true,
                    attempts: nil,
                    lockoutSeconds: nil
                )
            )
        )
    }
    
    var quizAction: QuizAction {
        correctCount < questions.count ? fail : pass
    }
    
    mutating func performAction()  {
        let theQuizAction = quizAction
        switch theQuizAction.actionType {
        case .restartQuiz:
            print("QuizModel, performAction, restartQuiz")
        case .goHome:
            print("QuizModel, performAction, goHome")
        }
        correctCount = 0
        if let tagKey = theQuizAction.actionData.tagKey, let tagValue = theQuizAction.actionData.tagValue {
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

