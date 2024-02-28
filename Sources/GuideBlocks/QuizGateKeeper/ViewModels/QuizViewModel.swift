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
    @Published var quizModel: QuizModel?
    @Published var currentQuestionIndex = 0
    var correctCount = 0
    var currentQuestion: QuestionModel? {
        quizModel?.questions[currentQuestionIndex]
    }
    var questionsCount: Int {
        quizModel?.questions.count ?? 0
    }
    @Published var showResults = false
    var currentAnswers: [AnswerModel] {
        return currentQuestion?.answers ?? [AnswerModel]()
    }
    
    init() {
        loadWithSampleQuizs()
    }
    
    func loadWithSampleQuizs() {
        var aQuestion = QuestionModel(question: "What is it?", answers: [AnswerModel]())
        quizModel = QuizModel(
            guideBlockKey: "QuizGateKeeper",
            questions: [aQuestion],
            fail: QuizActionModel(
                action: "setTag",
                actionData: QuizActionData(
                    allowScreenAccess: false,
                    attempts: 2,
                    lockoutSeconds: 600
                )
            ),
            pass: QuizActionModel(
                action: "setTag",
                actionData: QuizActionData(
                    allowScreenAccess: true,
                    attempts: nil,
                    lockoutSeconds: nil
                )
            )
        )
        for i in 1...4 {
            let answerModel = QuestionModel.sampleAnswerModelWith(index: i)
            quizModel?.questions[currentQuestionIndex].answers.append(answerModel)
        }
        quizModel?.questions[currentQuestionIndex].answers[3].correct = true
    }
    
    func updateData() {
        let guide = contextualContainer?.guidePayload.guide
        load(quizGuideJSON: guide?.extraJson)
    }
    
    func load(quizGuideJSON: Any?) {
        if let quizGuideDictionary = quizGuideJSON as? NSDictionary,
           let quizGuideData = quizGuideDictionary.toData() {
            do {
                quizModel = try JSONDecoder().decode(QuizModel.self, from: quizGuideData)
            } catch {
                print("couldn't serialize JSON, error: \(error)")
            }
        }
    }
    
    func choseAnswerWith(index: Int) {
        if currentQuestion?.answers[index].correct == true {
            correctCount += 1
        }
        if let quizModel, currentQuestionIndex < quizModel.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResults = true
        }
    }
    
    func restartQuiz() {
        correctCount = 0
        showResults = false
        currentQuestionIndex = 0
    }
    
    func tappedAQuiz() {
        quizGuide?.nextStepOfGuide()
    }
    
}
