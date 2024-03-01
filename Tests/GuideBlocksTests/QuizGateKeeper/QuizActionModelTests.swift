//
//  QuizActionModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class QuizActionDataTests: XCTestCase {
    
    func testEncodingDecoding() throws {
        // Given
        let quizActionData = QuizActionData(
            allowScreenAccess: false,
            attempts: 2,
            lockoutSeconds: 600
        )
        
        // When
        let encodedData = try JSONEncoder().encode(quizActionData)
        let decodedData = try JSONDecoder().decode(QuizActionData.self, from: encodedData)
        
        // Then
        XCTAssertEqual(decodedData.allowScreenAccess, false)
        XCTAssertEqual(decodedData.attempts, 2)
        XCTAssertEqual(decodedData.lockoutSeconds, 600)
    }
}

class QuizActionModelTests: XCTestCase {
    
    func testEncodingDecoding() throws {
        // Given
        let quizActionData = QuizActionData(
            allowScreenAccess: false,
            attempts: 2,
            lockoutSeconds: 600
        )
        let quizActionModel = QuizActionModel(action: "restartQuiz", actionData: quizActionData)
        
        // When
        let encodedData = try JSONEncoder().encode(quizActionModel)
        let decodedData = try JSONDecoder().decode(QuizActionModel.self, from: encodedData)
        
        // Then
        XCTAssertEqual(decodedData.action, "restartQuiz")
        XCTAssertEqual(decodedData.actionData.allowScreenAccess, false)
        XCTAssertEqual(decodedData.actionData.attempts, 2)
        XCTAssertEqual(decodedData.actionData.lockoutSeconds, 600)
    }
    
    func testActionType() {
        // Given
        let quizActionModel = QuizActionModel(
            action: "restartQuiz",
            actionData: QuizActionData(
                allowScreenAccess: false,
                attempts: 2,
                lockoutSeconds: 600
            )
        )
        
        // When
        let actionType = quizActionModel.actionType
        
        // Then
        XCTAssertEqual(actionType, .restartQuiz)
    }
}

