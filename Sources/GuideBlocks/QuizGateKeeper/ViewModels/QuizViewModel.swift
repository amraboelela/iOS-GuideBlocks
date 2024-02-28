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
    @Published var isPopupVisible = true
    @Published var quizIsVisible = true
    @Published var currentQuestion = QuestionModel(question: "", answers: [AnswerModel]())
    var currentAnswers: [AnswerModel] {
        return currentQuestion.answers
    }
    
    init() {
        loadWithSampleQuizs()
    }
    
    func loadWithSampleQuizs() {
        currentQuestion = QuestionModel(question: "What is it?", answers: [AnswerModel]())
        for i in 1...4 {
            let answerModel = QuestionModel.sampleAnswerModelWith(index: i)
            currentQuestion.answers.append(answerModel)
        }
        currentQuestion.answers[3].correct = true
    }
    
    func updateData() {
        let guide = contextualContainer?.guidePayload.guide
        load(quizGuideJSON: guide?.extraJson)
    }
    
    func load(quizGuideJSON: Any?) {
        if let quizGuideDictionary = quizGuideJSON as? NSDictionary,
           let quizGuideData = quizGuideDictionary.toData() {
            do {
                let quizModel = try JSONDecoder().decode(QuizModel.self, from: quizGuideData)
                if let firstQuestion = quizModel.questions.first {
                    currentQuestion = firstQuestion
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
