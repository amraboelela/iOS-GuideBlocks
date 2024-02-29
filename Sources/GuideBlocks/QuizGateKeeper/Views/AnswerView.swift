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
        return viewModel.currentAnswers.last ?? AnswerModel.sampleAnswer11
    }
    
    var body: some View {
        Button(action: {
            viewModel.choseAnswerWith(index: answerIndex)
        }) {
            HStack {
                Text(answerModel.label)
                Spacer()
            }
        }
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(viewModel: quizViewModel, answerIndex: 2)
    }
}
