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
    
    static var sampleQuiz: QuizModel {
        let question1 = QuestionModel(question: "What is it?", answers: [AnswerModel]())
        let question2 = QuestionModel(question: "Why is it?", answers: [AnswerModel]())
        return QuizModel(
            guideBlockKey: "QuizGateKeeper",
            questions: [question1, question2],
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
    
    func loadWithSampleQuizs() {
        quizModel = QuizViewModel.sampleQuiz
        for i in 1...4 {
            let answerModel = QuestionModel.sampleAnswerModelWith(index: i)
            quizModel?.questions[currentQuestionIndex].answers.append(answerModel)
        }
        quizModel?.questions[currentQuestionIndex].answers[3].correct = true
        quizModel?.contextualContainer = contextualContainer
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
                quizModel?.contextualContainer = contextualContainer
            } catch {
                print("couldn't serialize JSON, error: \(error)")
            }
        }
    }
    
    func choseAnswerWith(index: Int) {
        if currentQuestion?.answers[index].correct == true {
            quizModel?.correctCount += 1
        }
        if let quizModel, currentQuestionIndex < quizModel.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResults = true
        }
    }
    
    func performAction() {
        if let quizAction = quizModel?.performAction() {
            switch quizAction.actionType {
            case .restartQuiz:
                print("QuizViewModel, performAction, restartQuiz")
            case .goHome:
                print("QuizViewModel, performAction, goHome")
                isPopupVisible = false
                quizIsVisible = false
            }
        }
        showResults = false
        currentQuestionIndex = 0
    }
}
