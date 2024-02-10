//
//  MyChecklistView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/8.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct MyChecklistView: View {
    @ObservedObject var myChecklistViewModel: MyChecklistViewModel
    @State private var isPopupVisible = false
    
    var body: some View {
        VStack {
            Button(action: {
                isPopupVisible.toggle()
                print("Do list button tapped")
            }) {
                Text("To-do List")
                    .foregroundColor(.white) // Set text color to white
                    .padding() // Add padding to the text
                    .background(Color.blue) // Set background color to sky blue
                    .cornerRadius(10) // Apply round rectangle shape with corner radius
            }
        }
        .sheet(isPresented: $isPopupVisible) {
            if #available(iOS 16.0, *) {
                DoListView(myChecklistViewModel: myChecklistViewModel)
                    .presentationDetents([.medium, .large])
            } else {
                DoListView(myChecklistViewModel: myChecklistViewModel)
            }
        }
    }
}

struct MyChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        MyChecklistView(myChecklistViewModel: MyChecklistViewModel())
    }
}
