//
//  DoListView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct DoListView: View {
    @ObservedObject var myChecklistViewModel: MyChecklistViewModel
    @State private var isPopupVisible = false
    
    var body: some View {
        VStack {
            List(myChecklistViewModel.taskModels, id: \.self.id) { toDoTask in
                Button(action: {
                    if toDoTask.enabled {
                        toDoTask.action?(toDoTask.name)
                    }
                }) {
                    HStack {
                        Text(toDoTask.name)
                        Spacer()
                        Image(systemName: toDoTask.checked ? "checkmark.square.fill" : "square.fill")
                            .foregroundColor(toDoTask.checked ? .green : .gray)
                    }
                    .foregroundColor(toDoTask.enabled ? .primary : .gray)
                }
                .disabled(toDoTask.enabled)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct DoListView_Previews: PreviewProvider {
    static var previews: some View {
        DoListView(myChecklistViewModel: MyChecklistViewModel())
    }
}
