//
//  QRViewModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class QRViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdateData() {
        qrViewModel.updateData()
        
        XCTAssertEqual(qrViewModel.title, "QR Code Scanner")
    }
    
    func testScannedCallback() {
        // Given
        let viewModel = QRViewModel()
        var capturedCode: String?
        viewModel.scannedCodeCallback = { code in
            capturedCode = code
        }
        
        // When
        let expectedCode = "TestQRCode"
        viewModel.scanned(code: expectedCode)
        
        // Then
        XCTAssertEqual(capturedCode, expectedCode, "Scanned code should match the expected code")
    }
}
