//
//  FontTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import SwiftUI
import XCTest

@testable import GuideBlocks

class FontExtensionTests: XCTestCase {
    func testFontWithValidName() {
        let font = Font.title // or any other initial font
        
        let modifiedFont = font.fontWith(name: "Helvetica")
        
        XCTAssertNotEqual(modifiedFont, font) // Ensure the font has changed
    }
    
    func testFontWithInvalidName() {
        let font = Font.title // or any other initial font
        
        let modifiedFont = font.fontWith(name: "InvalidFontName")
        
        XCTAssertEqual(modifiedFont, font) // Ensure the font remains unchanged
    }
}
