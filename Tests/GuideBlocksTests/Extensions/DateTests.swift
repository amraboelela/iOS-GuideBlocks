//
//  DateTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/28.
//  Copyright © 2024 Contextual.
//

import Foundation
import XCTest

@testable import GuideBlocks

class DateTests: XCTestCase {
    
    func testNow() {
        XCTAssertTrue(Date.now <= Int(Date().timeIntervalSince1970))
    }
}
