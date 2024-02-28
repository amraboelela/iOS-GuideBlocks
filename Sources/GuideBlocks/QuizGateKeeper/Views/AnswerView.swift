//
//  AnswerView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct AnswerView: View {
    @ObservedObject var viewModel: QuizViewModel
    var answerIndex: Int
    
    var answerModel: AnswerModel {
        if answerIndex < viewModel.currentAnswers.count {
            return viewModel.currentAnswers[answerIndex]
        }
        return viewModel.currentAnswers.last ?? QuestionModel.sampleAnswerModelWith(index: 0)
    }
    
    var body: some View {
        Button(action: {
            /*if answerModel.enabled {
                print("Action for quiz \(quizModel.name)")
                viewModel.quizModels[quizIndex].doTheAction()
                viewModel.isPopupVisible = false
                viewModel.tappedAQuiz()
            } else {
                print("Quiz \(quizModel.name) is not enabled")
            }*/
        }) {
            HStack {
                Text(answerModel.label)
                Spacer()
            }
            /*.foregroundColor(answerModel.enabled ? .primary : .gray)*/
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(viewModel: quizViewModel, answerIndex: 2)
    }
}
