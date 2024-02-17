//
//  ISurveyQuestion.swift
//  GuideBlocks
//
//  Created by Marc Stroebel on 2023/3/31.
//  Copyright © 2024 Contextual.
//

import Foundation

protocol ISurveyQuestion : Codable {
    var title : String { get }
    var uuid : UUID { get }
    
    var type : SurveyItemType { get }
    var required : Bool { get set }
}
