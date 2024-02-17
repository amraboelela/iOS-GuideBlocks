//
//  MultipleChoiceResponseModel.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/3/31.
//  Copyright © 2024 Contextual.
//

import Foundation
import Combine

class MultipleChoiceResponseModel : ObservableObject, Codable {
    let text : String
    let uuid : UUID
    var selected = false
    
    let allowsCustomTextEntry : Bool
    var customTextEntry: String? = nil
    
    init(_ text : String, allowsCustomTextEntry : Bool = false) {
        self.text = text
        self.uuid = UUID()
        self.allowsCustomTextEntry = allowsCustomTextEntry
    }
}
