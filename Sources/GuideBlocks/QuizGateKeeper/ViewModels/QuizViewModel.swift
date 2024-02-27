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
    @Published var answerModels = [AnswerModel]() {
        didSet {
            dismissIfNeeded()
        }
    }
    
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
        load(quizs: guide?.extraJson?["quizs"])
        if let title = guide?.title?.text {
            self.title = title
        }
    }
    
    func load(quizs: Any?) {
        /*if let quizsArray = quizs as? NSArray, let quizsJson = quizsArray.toData() {
            if var loadedAnswerModels = try? JSONDecoder().decode([QuizModel].self, from: quizsJson) {
                for (i, quizModel) in loadedQuizModels.enumerated() {
                    //loadedQuizModels[i].contextualContainer = contextualContainer
                    /*loadedQuizModels[i].gotoScreenAction = { deepLinkURL in
                        print("gotoScreenAction for quiz: \(quizModel.name), deepLinkURL: \(deepLinkURL)")
                        if UIApplication.shared.canOpenURL(deepLinkURL) {
                            UIApplication.shared.open(deepLinkURL)
                        } else {
                            print("Cannot open deeplink")
                        }
                    }*/
                }
                answerModels = loadedAnswerModels
            } else {
                print("couldn't JSON serialize data: \(quizsJson.hexEncodedString)")
            }
        }*/
    }
    
    func tappedAQuiz() {
        quizGuide?.nextStepOfGuide()
    }
    
    func dismissIfNeeded() {
        var needToDismiss = true
        /*for quizModel in quizModels {
            if quizModel.enabled {
                needToDismiss = false
            }
        }
        quizListVisible = !needToDismiss
        if let quizGuide, needToDismiss {
            quizGuide.dismissGuide()
            quizGuide.completedCallback?()
        }*/
    }
    
}
