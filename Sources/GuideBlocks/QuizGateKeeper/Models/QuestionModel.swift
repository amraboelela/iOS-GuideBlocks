//
//  QuestionModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import ContextualSDK

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
