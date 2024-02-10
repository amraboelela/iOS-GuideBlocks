//
//  ToDoTaskModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import XCTest

@testable import iOS_GuideBlocks

class ToDoTaskModelTests: XCTestCase {
    
    func testEquality() {
        let task1 = ToDoTaskModel(id: "1", name: "Task 1", checked: false, enabled: true, action: nil)
        let task2 = ToDoTaskModel(id: "2", name: "Task 2", checked: true, enabled: false, action: nil)
        let task3 = ToDoTaskModel(id: "3", name: "Task 3", checked: false, enabled: true, action: nil)
        let task4 = ToDoTaskModel(id: "3", name: "Task 4", checked: false, enabled: true, action: nil)
        
        XCTAssertEqual(task1, task1) // A task is equal to itself
        XCTAssertNotEqual(task1, task2) // Different tasks should not be equal
        XCTAssertNotEqual(task1, task3) // Different tasks should not be equal
        
        XCTAssertEqual(task3, task4) // equal as they have same id
    }
    
    func testHashing() {
        let task1 = ToDoTaskModel(id: "1", name: "Task 1", checked: false, enabled: true, action: nil)
        let task2 = ToDoTaskModel(id: "2", name: "Task 2", checked: true, enabled: false, action: nil)
        let task3 = ToDoTaskModel(id: "3", name: "Task 3", checked: false, enabled: true, action: nil)
        let task4 = ToDoTaskModel(id: "3", name: "Task 4", checked: false, enabled: true, action: nil)
        
        XCTAssertEqual(task1.hashValue, task1.hashValue) // Hash value should be consistent
        XCTAssertNotEqual(task1.hashValue, task2.hashValue) // Different tasks should have different hash values
        XCTAssertNotEqual(task1.hashValue, task3.hashValue) // Different tasks should have different hash values
        XCTAssertEqual(task3.hashValue, task4.hashValue) // equal as they have same id
    }
}
