//
//  QuizModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

struct QuizModel: Codable {
    var contextualContainer: ContextualContainer?
    
    let guideBlockKey: String
    var questions: [QuestionModel]
    let fail: QuizActionModel
    let pass: QuizActionModel
    
    var correctCount = 0
    var numberOfAttempts = 0
    
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
            fail: QuizActionModel(
                action: "restartQuiz",
                actionData: QuizActionData(
                    allowScreenAccess: false,
                    attempts: 2,
                    lockoutSeconds: 600
                )
            ),
            pass: QuizActionModel(
                action: "goHome",
                actionData: QuizActionData(
                    allowScreenAccess: true,
                    attempts: nil,
                    lockoutSeconds: nil
                )
            )
        )
    }
    
    var quizActionModel: QuizActionModel {
        correctCount < questions.count ? fail : pass
    }
    
    mutating func performAction()  {
        let quizAction = quizActionModel
        switch quizAction.actionType {
        case .restartQuiz:
            print("QuizModel, performAction, restartQuiz")
        case .goHome:
            print("QuizModel, performAction, goHome")
        }
        if let tagKey = quizAction.actionData.tagKey, let tagValue = quizAction.actionData.tagValue {
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

