//
//  QRModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import Foundation

struct QRModel: Codable, Hashable {
    var qrCode: String
    
    enum CodingKeys: String, CodingKey {
        case qrCode
    }
    
    // MARK: - Delegates
    
    static func == (lhs: QRModel, rhs: QRModel) -> Bool {
        lhs.qrCode == rhs.qrCode
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(qrCode)
    }
}
