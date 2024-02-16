//
//  ViewTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/14.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI
import XCTest

@testable import GuideBlocks

class ViewTests: XCTestCase {
    
    func testContextualTextFormat() {
        let textElement = SHTipTextElement()
        textElement.fontName = "Helvetica"
        textElement.fontWeight = "bold"
        textElement.fontSize = 18.0
        textElement.textColor = .red
        let view = Text("Hello")
        
        let modifiedView = view.contextualTextFormat(textElement)
        
        XCTAssertTrue("\(modifiedView)".contains("ContextualTextModifier"))
    }
    
    func testContextualButtonFormat() {
        let buttonElement = SHTipButtonElement()
        buttonElement.fontName = "Helvetica"
        buttonElement.fontWeight = "bold"
        buttonElement.fontSize = 18.0
        buttonElement.textColor = .red
        buttonElement.backgroundColor = .blue
    
        let view = Button(
            action: {},
            label: {
                Text("Button")
            }
        )
        let modifiedView = view.contextualButtonFormat(buttonElement)
        XCTAssertTrue("\(modifiedView)".contains("ContextualButtonModifier"))
    }
    
    func testContextualImageBackground() {
        let imageElement = SHTipImageElement()
        imageElement.backgroundColor = .blue
        
        let view = Image(systemName: "photo")
        
        let modifiedView = view.contextualImageBackground(imageElement)
        XCTAssertTrue("\(modifiedView)".contains("ContextualImageBackgroundModifier"))
    }
    
    func testContextualImageResize() {
        let imageElement = SHTipImageElement()
        imageElement.width = 200
        imageElement.height = 100
        
        let view = Image(systemName: "photo")
        
        let modifiedView = view.contextualImageResize(imageElement)
        XCTAssertTrue("\(modifiedView)".contains("ContextualImageResizeModifier"))
    }
}
