//
//  MyChecklistViewModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import XCTest

@testable import iOS_GuideBlocks

class MyChecklistViewModelTests: XCTestCase {
    var viewModel: MyChecklistViewModel!

    override func setUp() {
        super.setUp()
        viewModel = MyChecklistViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testLoadWithSampleTasks() {
        // Check if taskModels are loaded with sample tasks
        XCTAssertEqual(viewModel.taskModels.count, 12)
        
        // Verify the properties of each taskModel
        for (index, taskModel) in viewModel.taskModels.enumerated() {
            XCTAssertEqual(taskModel.name, "Task \(index + 1)")
            XCTAssertEqual(taskModel.checked, (index + 1).isPrime())
            XCTAssertTrue(taskModel.enabled)
            XCTAssertNotNil(taskModel.action)
        }
    }

    func testLoadWithCustomTasks() {
        // Define custom tasks
        let customTasks = ["Task A", "Task B", "Task C"]
        
        // Load tasks with custom tasks
        viewModel.load(tasks: customTasks)
        
        // Check if taskModels are loaded with custom tasks
        XCTAssertEqual(viewModel.taskModels.count, customTasks.count)
        
        // Verify the properties of each taskModel
        for (index, taskModel) in viewModel.taskModels.enumerated() {
            XCTAssertEqual(taskModel.id, "task\(index)")
            XCTAssertEqual(taskModel.name, customTasks[index])
            XCTAssertTrue(taskModel.enabled)
            XCTAssertNotNil(taskModel.action)
        }
    }
}
