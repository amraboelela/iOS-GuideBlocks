//
//  OpenChecklistViewModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class OpenChecklistViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadWithSampleTasks() {
        openChecklistViewModel.loadWithSampleTasks()
        // Check if taskModels are loaded with sample tasks
        XCTAssertEqual(openChecklistViewModel.taskModels.count, 12)
        
        // Verify the properties of each taskModel
        for (index, taskModel) in openChecklistViewModel.taskModels.enumerated() {
            XCTAssertEqual(taskModel.name, "Task \(index + 1)")
            XCTAssertEqual(taskModel.checked, false)
            XCTAssertTrue(taskModel.enabled)
        }
    }

    func testLoadWithCustomTasks() {
        // Define custom tasks
        let customTasks = ["Task A", "Task B", "Task C"]
        
        // Load tasks with custom tasks
        //openChecklistViewModel.load(tasks: customTasks)
        
        // Check if taskModels are loaded with custom tasks
        //XCTAssertEqual(openChecklistViewModel.taskModels.count, customTasks.count)
        
        // Verify the properties of each taskModel
        /*for (index, taskModel) in openChecklistViewModel.taskModels.enumerated() {
            let taskName = customTasks[index]
            XCTAssertEqual(
                taskModel.id,
                taskName.lowercased().replacingOccurrences(of: " ", with: "_")
            )
            XCTAssertEqual(taskModel.name, taskName)
            XCTAssertTrue(taskModel.enabled)
            XCTAssertNotNil(taskModel.action)
        }*/
    }
}
