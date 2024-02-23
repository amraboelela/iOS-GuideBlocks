//
//  OpenChecklistView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

struct OpenChecklistView: View {
    var buttonTextElement: SHTipTextElement?
    var imageElement: SHTipImageElement?
    @ObservedObject var viewModel: OpenChecklistViewModel
    var closeButtonTapped: () -> ()
    
    var body: some View {
        VStack {
            //if viewModel.taskListVisible {
            //ZStack {
            /*Button(
             action: {
             viewModel.isPopupVisible.toggle()
             print("Do list button tapped")
             },
             label: {
             Text(viewModel.title)
             .contextualTextFormat(buttonTextElement)
             .foregroundColor(.white)
             .background(.blue)
             .clipShape(RoundedRectangle(cornerRadius: 10))
             }
             )
             CloseButtonView(
             imageElement: imageElement,
             offsetX: 100,
             offsetY: -100,
             closeButtonTapped: {
             closeButtonTapped()
             viewModel.taskListVisible = false
             }
             )*/
            //}
            //}
            /*Button(
             action: {
             closeButtonTapped()
             },
             label: {
             Image(systemName: "xmark.circle.fill")
             .resizable()
             .contextualImageResize(imageElement)
             .padding(10)
             .contextualImageBackground(imageElement)
             .background(.red)
             .foregroundColor(.white)
             .clipShape(Circle())
             .shadow(radius: 8)
             //.zIndex(11)
             }
             )
             .position(x: 100, y: 100)
             */
            //Button(action: {
            // Action for the main button
            //}, label: {
            Text("Main Button")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            //})
                .overlay(
                    Button(
                        action: {
                            closeButtonTapped()
                        },
                        label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .contextualImageResize(imageElement)
                                .padding(10)
                                .contextualImageBackground(imageElement)
                                .background(.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 8)
                            //.zIndex(11)
                        }
                    )
                    .position(x:130, y:-10),
                    //.padding(80),
                    //.offset(x: 30, y: -30), // Adjust the offset for positioning
                    alignment: .topTrailing
                )
            /*.offset(
             x: 100,
             y: -100
             )*/
        }
        /*.sheet(isPresented: $viewModel.isPopupVisible) {
            if #available(iOS 16.0, *) {
                TaskListView(viewModel: viewModel)
                    .presentationDetents([.medium, .large])
            } else {
                TaskListView(viewModel: viewModel)
            }
        }*/
    }
}

struct OpenChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        OpenChecklistView(
            viewModel: openChecklistViewModel,
            closeButtonTapped: {
            }
        )
    }
}
