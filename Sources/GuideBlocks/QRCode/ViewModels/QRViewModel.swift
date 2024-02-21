//
//  QRViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import Foundation
import SwiftUI

let qrViewModel = QRViewModel()

class QRViewModel : ObservableObject {
    var qrCodeGuide: QRCodeGuide?
    var contextualContainer: ContextualContainer? {
        qrCodeGuide?.contextualContainer
    }
    var scannedCodeCallback: ((String) -> ())?
    
    @Published var isPopupVisible: Bool = false
    @Published var title = "QR Code Scanner"
    @Published var qrCodeVisible = true
    
    init() {
    }
    
    func updateData() {
        let guide = contextualContainer?.guidePayload.guide
        if let title = guide?.title?.text {
            self.title = title
        }
    }
    
    func scanned(code: String) {
        scannedCodeCallback?(code)
    }
}
