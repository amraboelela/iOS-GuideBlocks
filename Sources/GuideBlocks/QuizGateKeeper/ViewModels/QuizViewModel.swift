//
//  QuizViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let quizViewModel = QuizViewModel()

class QuizViewModel : ObservableObject {
    var quizGuide: QuizGuide?
    var contextualContainer: ContextualContainer? {
        quizGuide?.contextualContainer
    }
    
    var quizModel: QuizModel?
    
    @Published var isPopupVisible: Bool = false
    @Published var title = "Do List"
    @Published var quizListVisible = true
    @Published var answerModels = [AnswerModel]()
    
    init() {
        loadWithSampleQuizs()
    }
    
    func loadWithSampleQuizs() {
        var result = [AnswerModel]()
        for i in 1...4 {
            let answerModel = QuestionModel.sampleAnswerModelWith(index: i)
            //quizModel.contextualContainer = contextualContainer
            result.append(answerModel)
        }
        result[3].correct = true
        answerModels = result
    }
    
    func updateData() {
        let guide = contextualContainer?.guidePayload.guide
        load(quizGuideJSON: guide?.extraJson)
        if let title = guide?.title?.text {
            self.title = title
        }
    }
    
    func load(quizGuideJSON: Any?) {
        if let quizGuideDictionary = quizGuideJSON as? NSDictionary,
           let quizGuideData = quizGuideDictionary.toData() {
            do {
                let quizModel = try JSONDecoder().decode(QuizModel.self, from: quizGuideData)
                if let loadedAnswerModels = quizModel.questions.first?.answers {
                    for answerModel in loadedAnswerModels {
                        print("answerModel: \(answerModel)")
                    }
                    answerModels = loadedAnswerModels
                }
            } catch {
                print("couldn't serialize JSON, error: \(error)")
            }
        }
    }
    
    func tappedAQuiz() {
        quizGuide?.nextStepOfGuide()
    }
    
}
