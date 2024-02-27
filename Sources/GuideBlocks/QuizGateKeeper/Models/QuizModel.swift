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
    let questions: [QuestionModel]
    let fail: FailActionModel
    let pass: PassActionModel
}

struct QuestionModel: Codable {
    let question: String
    let answers: [AnswerModel]
    
    static func sampleAnswerModelWith(index: Int) -> AnswerModel {
        return AnswerModel(
            label: "Answer \(index)",
            correct: false
        )
    }
}

struct AnswerModel: Codable {
    let label: String
    let correct: Bool
}

struct FailActionModel: Codable {
    let quizAction: String
    let allowScreenAccess: Bool
    let attempts: Int
    let lockoutSeconds: Int
    let setTag: SetTag
}

struct PassActionModel: Codable {
    let quizAction: QuizAction
    let allowScreenAccess: Bool
}

struct SetTag: Codable {
    let key: String
    let value: String
}

struct QuizAction: Codable {
    let setTag: SetTag
    let allowScreenAccess: Bool
}
