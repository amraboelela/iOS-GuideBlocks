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
                Text("Do list")
                    .foregroundColor(.white) // Set text color to white
                    .padding() // Add padding to the text
                    .background(Color.blue) // Set background color to sky blue
                    .cornerRadius(10) // Apply round rectangle shape with corner radius
            }
        }
        .sheet(isPresented: $isPopupVisible) {
            DoListView()
        }
    }
}

struct DoListView: View {
    @State private var isPopupVisible = false
    @State private var selectedRow: Int?
    @State private var rowsEnabled = [true, true, true] // Enable/disable rows programmatically
    
    let rowActions: [(String) -> Void] = [
        { text in print("Action for row 1 with text: \(text)") },
        { text in print("Action for row 2 with text: \(text)") },
        { text in print("Action for row 3 with text: \(text)") }
    ]
    
    let rowData: [(String, Bool)] = [
        ("Task 1", false),
        ("Task 2", true),
        ("Task 3", true)
    ]
    
    var body: some View {
        VStack {
            Text("Do list")
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
