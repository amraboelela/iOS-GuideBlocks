//
//  StringTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import Foundation
import XCTest

@testable import GuideBlocks

class StringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTruncateShortString() {
        let shortString = "Short"
    
        let truncatedString = shortString.truncate(length: 10)
        
        XCTAssertEqual(truncatedString, "Short")
    }
    
    func testTruncateLongString() {
        let longString = "This is a very long string that exceeds the specified length"
        
        let truncatedString = longString.truncate(length: 20)
        
        XCTAssertEqual(truncatedString, "This is a very long …")
    }
    
    func testTruncateLongStringWithCustomTrailing() {
        let longString = "This is a very long string that exceeds the specified length"
        let customTrailing = "..."
        
        let truncatedString = longString.truncate(length: 20, trailing: customTrailing)
        
        XCTAssertEqual(truncatedString, "This is a very long " + customTrailing)
    }
    
    func testTruncateEmptyString() {
        let emptyString = ""
        
        let truncatedString = emptyString.truncate(length: 10)
        
        XCTAssertEqual(truncatedString, "")
    }
    
}
