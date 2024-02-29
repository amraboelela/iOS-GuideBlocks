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
    
    var correctCount: Int {
        viewModel.quizModel?.correctCount ?? 0
    }
    
    var body: some View {
        VStack {
            Text("You scored \(correctCount) / \(viewModel.questionsCount)")
                .padding()
            Button(
                action: {
                    print("Perform action")
                    viewModel.performAction()
                },
                label: {
                    Text("OK")
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
