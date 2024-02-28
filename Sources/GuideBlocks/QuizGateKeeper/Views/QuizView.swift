//
//  QuizView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/26.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        VStack {
            if viewModel.showResults {
                Text("Correct count: \(viewModel.correctCount)")
            } else {
                Text(viewModel.currentQuestion?.question ?? "A Question")
                List(viewModel.currentAnswers.indices, id: \.self) { index in
                    AnswerView(viewModel: quizViewModel, answerIndex: index)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(
            viewModel: quizViewModel
        )
    }
}
