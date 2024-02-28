//
//  TaskModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class TaskModelTests: XCTestCase {
    
    func testIDGeneration() {
        let task1 = TaskModel(
            name: "Task 1",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_1")
        )
        let task2 = TaskModel(
            name: "Task 2",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_2")
        )
        let task3 = TaskModel(
            name: "Task 3",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_3")
        )
        XCTAssertEqual(task1.id, "task_1")
        XCTAssertEqual(task2.id, "task_2")
        XCTAssertEqual(task3.id, "task_3")
    }
    
    func testEquality() {
        let task1 = TaskModel(
            name: "Task 1",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_1")
        )
        let task2 = TaskModel(
            name: "Task 2",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_2")
        )
        let task3 = TaskModel(
            name: "Task 3",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_3")
        )
        let task4 = TaskModel(
            name: "Task 3 ",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_3")
        )
        
        XCTAssertEqual(task1, task1) // A task is equal to itself
        XCTAssertNotEqual(task1, task2) // Different tasks should not be equal
        XCTAssertNotEqual(task1, task3) // Different tasks should not be equal
        
        XCTAssertEqual(task3, task4) // equal as they have same id
    }
    
    func testHashing() {
        let task1 = TaskModel(
            name: "Task 1",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_1")
        )
        let task2 = TaskModel(
            name: "Task 2",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_2")
        )
        let task3 = TaskModel(
            name: "Task 3",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_3")
        )
        let task4 = TaskModel(
            name: "Task 3 ",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/screen_3")
        )
        
        XCTAssertEqual(task1.hashValue, task1.hashValue) // Hash value should be consistent
        XCTAssertNotEqual(task1.hashValue, task2.hashValue) // Different tasks should have different hash values
        XCTAssertNotEqual(task1.hashValue, task3.hashValue) // Different tasks should have different hash values
        XCTAssertEqual(task3.hashValue, task4.hashValue) // equal as they have same id
    }
    
    func testDeepLinkURL() {
        let taskModel1 = TaskModel(
            name: "Task 1",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "https://example.com")
        )
        XCTAssertNotNil(taskModel1.deepLinkURL)
        
        let taskModel2 = TaskModel(
            name: "Task 2",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "myApp://screen/home")
        )
        XCTAssertNotNil(taskModel2.deepLinkURL)
        
        let taskModel3 = TaskModel(
            name: "Task 3",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "airbnbContextual://screen/inbox")
        )
        XCTAssertNotNil(taskModel3.deepLinkURL)
    }
    
    func testSampleTaskModelWithIndex() {
        let index = 1
        
        let taskModel = TaskModel.sampleTaskModelWith(index: index)
        
        XCTAssertEqual(taskModel.name, "Task \(index)")
        XCTAssertEqual(taskModel.actionData.deepLink, "airbnbContextual://screen/task_\(index)")
    }
    
    func testGotoScreenAction() {
        var taskModel = TaskModel(
            name: "Task 1",
            action: "gotoScreen",
            actionData: TaskActionData(deepLink: "myApp://screen/home")
        )
        
        let expectation = XCTestExpectation(description: "Gotoscreen method gets called")
        let taskModelDeepLink = URL(string: taskModel.actionData.deepLink!)
        taskModel.gotoScreenAction = { deepLinkURL in
            XCTAssertEqual(deepLinkURL, taskModelDeepLink)
            expectation.fulfill()
        }
        taskModel.performAction()
        // Wait for the expectation to be fulfilled, or timeout after a specified interval
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSetTagAction() {
        var taskModel = TaskModel(
            name: "Task 2",
            action: "setTag",
            actionData: TaskActionData(tagKey: "tag_key", tagValue: "tag_value")
        )
        taskModel.performAction()
    }
    
    func testCheckTagAction() {
        var taskModel = TaskModel(
            name: "Task 2",
            action: "checkTag",
            actionData: TaskActionData(
                tagKey: "favourited_properties_count",
                tagValue: "3",
                rawTagType: "int",
                rawTagOperator: "gte"
            )
        )
        taskModel.performAction()
        XCTAssertEqual(taskModel.favouritedCount, 1)
        taskModel.performAction()
        XCTAssertEqual(taskModel.favouritedCount, 2)
        taskModel.performAction()
        XCTAssertEqual(taskModel.favouritedCount, 3)
    }
    
    // Test case for comparing two integer values with greater than or equal operator
    func testCompare() {
        let taskModel = TaskModel(
            name: "Task 2",
            action: "checkTag",
            actionData: TaskActionData(
                tagKey: "favourited_properties_count",
                tagValue: "3",
                rawTagType: "int",
                rawTagOperator: "gte"
            )
        )
        var result = taskModel.compare(value1: "5", value2: "3", tagType: .int, tagOperator: .gte)
        XCTAssertTrue(result)
        result = taskModel.compare(value1: "5", value2: "3", tagType: .int, tagOperator: .lte)
        XCTAssertFalse(result)
        result = taskModel.compare(value1: "5", value2: "5", tagType: .int, tagOperator: .equ)
        XCTAssertTrue(result)
        result = taskModel.compare(value1: "hello", value2: "hello", tagType: .string, tagOperator: .equ)
        XCTAssertTrue(result)
        result = taskModel.compare(value1: "hello", value2: "world", tagType: .string, tagOperator: .equ)
        XCTAssertFalse(result)
    }
}
