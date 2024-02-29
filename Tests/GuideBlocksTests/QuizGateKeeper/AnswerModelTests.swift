//
//  AnswerModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class AnswerModelTests: XCTestCase {
    
    func testSampleAnswer1() {
        var sampleAnswer = AnswerModel.sampleAnswer11
        
        XCTAssertTrue(sampleAnswer.label.count > 0)
        XCTAssertFalse(sampleAnswer.correct)
        
        sampleAnswer = AnswerModel.sampleAnswer12
        
        XCTAssertTrue(sampleAnswer.correct)
        
        sampleAnswer = AnswerModel.sampleAnswer13
        
        XCTAssertFalse(sampleAnswer.correct)
    }
    
}
