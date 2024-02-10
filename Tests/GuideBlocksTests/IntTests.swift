//
//  IntTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/9.
//  Copyright © 2024 Contextual.
//

import XCTest
import Foundation

@testable import iOS_GuideBlocks

class IntTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsPrime() {
        XCTAssertTrue(2.isPrime())
        XCTAssertTrue(3.isPrime())
        XCTAssertTrue(5.isPrime())
        XCTAssertFalse(9.isPrime())
    }
}
