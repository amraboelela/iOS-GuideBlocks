//
//  NSArrayTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import Foundation
import XCTest

@testable import GuideBlocks

class NSArrayTests: XCTestCase {
    
    func testToString() throws {
        let array: NSArray = ["value1", "value2", "value3"]
        let jsonString = array.toString()
        
        XCTAssertNotNil(jsonString)
        let theJsonString = try XCTUnwrap(jsonString)
        XCTAssertTrue(theJsonString.contains("\"value2\""))
    }
    
    func testEmptyDictionaryToString() {
        let emptyDict: NSArray = []
        
        let jsonString = emptyDict.toString()
        
        XCTAssertNotNil(jsonString)
        XCTAssertEqual(jsonString, "[]")
    }
    
    func testNilDictionaryToString() {
        let nilDict: NSDictionary? = nil
        
        let jsonString = nilDict?.toString()
        
        XCTAssertNil(jsonString)
    }
    
    func testToData() {
        let array: NSArray = ["value1", "value2", "value3"]
        
        let jsonData = array.toData()
        
        XCTAssertNotNil(jsonData)
        do {
            // Verify if the Data can be converted back to NSDictionary
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: [])
            XCTAssertTrue(jsonObject is NSArray)
            XCTAssertEqual(jsonObject as? NSArray, array)
        } catch {
            XCTFail("Error converting Data to NSDictionary: \(error.localizedDescription)")
        }
    }
    
    func testNilDictionaryToData() {
        let nilArray: NSArray? = nil
        
        let jsonData = nilArray?.toData()
        
        XCTAssertNil(jsonData)
    }
    
}
