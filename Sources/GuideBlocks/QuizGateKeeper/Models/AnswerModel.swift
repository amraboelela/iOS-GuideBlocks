//
//  AnswerModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/28.
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
