//
//  QuizResultView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/27.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct QuizResultView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        VStack {
            Text("You scored \(viewModel.correctCount) / \(viewModel.questionsCount)")
                .padding()
            Button(
                action: {
                    print("Restart Quiz")
                    viewModel.restartQuiz()
                },
                label: {
                    Text("Restart Quiz")
                }
            )
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuizResultView(
            viewModel: quizViewModel
        )
    }
}
