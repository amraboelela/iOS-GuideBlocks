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
    
    func testSampleAnswerModelWithIndex() {
        let index = 1
        
        let answerModel = QuestionModel.sampleAnswerModelWith(index: index)
        
        XCTAssertEqual(answerModel.label, "Answer \(index)")
    }
}
