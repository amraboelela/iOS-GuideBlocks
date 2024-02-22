//
//  NSDictionaryTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/12.
//  Copyright © 2024 Contextual.
//

import XCTest

@testable import GuideBlocks

class NSDictionaryTests: XCTestCase {
    
    func testToString() throws {
        let dict: NSDictionary = ["key1": "value1", "key2": 123, "key3": true]
        let jsonString = dict.toString()
        
        XCTAssertNotNil(jsonString)
        let theJsonString = try XCTUnwrap(jsonString)
        XCTAssertTrue(theJsonString.contains("\"key2\":123"))
    }
    
    func testEmptyDictionaryToString() {
        // Given
        let emptyDict: NSDictionary = [:]
        
        // When
        let jsonString = emptyDict.toString()
        
        // Then
        XCTAssertNotNil(jsonString)
        XCTAssertEqual(jsonString, "{}")
    }
    
    func testNilDictionaryToString() {
        // Given
        let nilDict: NSDictionary? = nil
        
        // When
        let jsonString = nilDict?.toString()
        
        // Then
        XCTAssertNil(jsonString)
    }
    
    func testToData() {
        // Given
        let dict: NSDictionary = ["key1": "value1", "key2": 123, "key3": true]
        
        // When
        let jsonData = dict.toData()
        
        // Then
        XCTAssertNotNil(jsonData)
        do {
            // Verify if the Data can be converted back to NSDictionary
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: [])
            XCTAssertTrue(jsonObject is NSDictionary)
            XCTAssertEqual(jsonObject as? NSDictionary, dict)
        } catch {
            XCTFail("Error converting Data to NSDictionary: \(error.localizedDescription)")
        }
    }
    
    func testNilDictionaryToData() {
        // Given
        let nilDict: NSDictionary? = nil
        
        // When
        let jsonData = nilDict?.toData()
        
        // Then
        XCTAssertNil(jsonData)
    }
    
}
