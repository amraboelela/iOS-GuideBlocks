//
//  MyChecklistView.swift
//  iOS-GuideBlocks
//
//  Created by Amr Aboelela on 2/8/2024.
//

import SwiftUI

struct MyChecklistView: View {
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
                DoListView()
                    .presentationDetents([.medium, .large])
            } else {
                DoListView()
            }
        }
    }
}

struct DoListView: View {
    @State private var isPopupVisible = false
    @State private var selectedRow: Int?
    @State private var rowsEnabled = [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true
    ] // Enable/disable rows programmatically
    
    let rowActions: [(String) -> Void] = [
        { text in print("Action for task 1 with text: \(text)") },
        { text in print("Action for task 2 with text: \(text)") },
        { text in print("Action for task 3 with text: \(text)") },
        { text in print("Action for task 4 with text: \(text)") },
        { text in print("Action for task 5 with text: \(text)") },
        { text in print("Action for task 6 with text: \(text)") },
        { text in print("Action for task 7 with text: \(text)") },
        { text in print("Action for task 8 with text: \(text)") },
        { text in print("Action for task 9 with text: \(text)") },
        { text in print("Action for task 10 with text: \(text)") },
        { text in print("Action for task 11 with text: \(text)") },
        { text in print("Action for task 12 with text: \(text)") },
    ]
    
    let rowData: [(String, Bool)] = [
        ("Task 1", false),
        ("Task 2", false),
        ("Task 3", true),
        ("Task 4", true),
        ("Task 5", false),
        ("Task 6", true),
        ("Task 7", true),
        ("Task 8", false),
        ("Task 9", true),
        ("Task 10", true),
        ("Task 11", false),
        ("Task 12", false)
    ]
    
    var body: some View {
        VStack {
            Text("Do List")
                .font(.headline)
                .padding()
            List(0..<rowData.count, id: \.self) { index in
                Button(action: {
                    if self.rowsEnabled[index] {
                        self.rowActions[index](self.rowData[index].0)
                        self.selectedRow = index
                    }
                }) {
                    HStack {
                        Text(self.rowData[index].0)
                        Spacer()
                        Image(systemName: self.rowData[index].1 ? "checkmark.square.fill" : "square.fill")
                            .foregroundColor(self.rowData[index].1 ? .green : .gray)
                    }
                    .foregroundColor(self.rowsEnabled[index] ? .primary : .gray)
                }
                .disabled(!self.rowsEnabled[index])
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct MyChecklistView_Previews: PreviewProvider {
    static var previews: some View {
        MyChecklistView()
    }
}

struct DoListView_Previews: PreviewProvider {
    static var previews: some View {
        DoListView()
    }
}
