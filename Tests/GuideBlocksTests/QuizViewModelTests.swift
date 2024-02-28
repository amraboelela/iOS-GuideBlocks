//
//  QuizViewModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/27.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class QuizViewModelTests: XCTestCase {
    
    var viewModel: QuizViewModel?
    
    override func setUpWithError() throws {
        viewModel = QuizViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoadWithSampleQuizs() {
        XCTAssertEqual(viewModel?.currentAnswers.count, 4)
        XCTAssertEqual(viewModel?.currentAnswers.filter { $0.correct }.count, 1)
    }
    
    func testUpdateData() {
        guard let viewModel else {
            XCTFail("viewModel is nil")
            return
        }
        let jsonString = """
         {
             "guideBlockKey": "QuizGateKeeper",
             "questions": [
                 {
                     "question": "How would you do X?",
                     "answers": [
                         {
                             "label": "By clicking the edit profile",
                             "correct": false
                         },
                         {
                             "label": "By praying to my fave deity",
                             "correct": false
                         },
                         {
                             "label": "By entering the dish and selecting Fave",
                             "correct": true
                         }
                     ]
                 },
                 {
                     "question": "What planet are you on?",
                     "answers": [
                         {
                             "label": "Earth",
                             "correct": true
                         },
                         {
                             "label": "Betelgeuse Seven",
                             "correct": false
                         },
                         {
                             "label": "Golgafrincham",
                             "correct": false
                         }
                     ]
                 }
             ],
             "fail": {
                 "action": "restartQuiz",
                 "action_data": {
                     "key": "Quiz_fail_datetime",
                     "value": "@now",
                     "attempts": 2,
                     "lockout_seconds": 600,
                     "allow_screen_access": false
                 }
             },
             "pass": {
                 "action": "setTag",
                 "action_data": {
                     "key": "Quiz_pass_datetime",
                     "value": "@now",
                     "allow_screen_access": true
                 }
             }
         }
        """
        // Convert JSON string to Data
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        do {
            // Decode JSON data to NSDictionary
            if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                // Use jsonDictionary as needed
                print(jsonDictionary)
                viewModel.load(quizGuideJSON: jsonDictionary)
                XCTAssertEqual(viewModel.currentAnswers.count, 3)
            } else {
                print("Failed to decode JSON data to NSDictionary")
            }
        } catch {
            XCTFail("Error decoding JSON data: \(error)")
        }
    }
}
