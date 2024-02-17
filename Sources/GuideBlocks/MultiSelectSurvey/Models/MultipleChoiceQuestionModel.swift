//
//  MultipleChoiceQuestionModel.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/3/31.
//  Copyright © 2024 Contextual.
//

import Foundation

class MultipleChoiceQuestionModel : ObservableObject, ISurveyQuestion {

    let title : String
    let uuid: UUID
    var choices : [MultipleChoiceResponseModel]
    var required: Bool = false
    var allowsMultipleSelection = false
    var type: SurveyItemType = .multipleChoiceQuestion
    
    init(title:String, answers:[String], multiSelect : Bool = false) {
        self.title = title
        self.uuid = UUID()
        self.choices = answers.map({ MultipleChoiceResponseModel($0) })
        self.allowsMultipleSelection = multiSelect
    }
    
    init(title:String, items: [Any], multiSelect : Bool = false) {
        self.title = title
        self.uuid = UUID()
        
        self.choices = []
        
        for item in items {
            if let item2 = item as? String {
                self.choices.append( MultipleChoiceResponseModel(item2) )
            } else if let item2 = item as? MultipleChoiceResponseModel {
                self.choices.append( item2 )
            }
        }
        
        self.allowsMultipleSelection = multiSelect
    }
    
}
