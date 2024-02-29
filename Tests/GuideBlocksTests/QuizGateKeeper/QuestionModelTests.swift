//
//  QuestionModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class QuestionModelTests: XCTestCase {
    
    func testSampleQuestion1() {
        let sampleQuestion = QuestionModel.sampleQuestion1
        
        XCTAssertEqual(sampleQuestion.answers.count, 3)
    }
    
    func testSampleQuestion2() {
        let sampleQuestion = QuestionModel.sampleQuestion2
        
        XCTAssertEqual(sampleQuestion.answers.count, 3)
    }
}
