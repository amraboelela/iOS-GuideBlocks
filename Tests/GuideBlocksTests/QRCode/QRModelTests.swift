//
//  QRModelTests.swift
//  GuideBlocksTests
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import XCTest

@testable import GuideBlocks

class QRModelTests: XCTestCase {
    
    // Test Codable conformance: Encoding and Decoding
    func testQRModelCodable() throws {
        // Given
        let qrCode = "exampleQRCode"
        let qrModel = QRModel(qrCode: qrCode)
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(qrModel)
        
        let decoder = JSONDecoder()
        let decodedQRModel = try decoder.decode(QRModel.self, from: data)
        
        // Then
        XCTAssertEqual(decodedQRModel.qrCode, qrCode)
    }
    
    // Test Hashable conformance
    func testQRModelHashable() {
        // Given
        let qrCode1 = "QRCode1"
        let qrCode2 = "QRCode2"
        
        let qrModel1 = QRModel(qrCode: qrCode1)
        let qrModel2 = QRModel(qrCode: qrCode1)
        let qrModel3 = QRModel(qrCode: qrCode2)
        
        // When
        let qrModels: Set<QRModel> = [qrModel1, qrModel2]
        
        // Then
        XCTAssertTrue(qrModels.contains(qrModel1))
        XCTAssertTrue(qrModels.contains(qrModel2))
        XCTAssertFalse(qrModels.contains(qrModel3))
    }
}
