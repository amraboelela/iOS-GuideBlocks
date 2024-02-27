//
//  QRViewModel.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import ContextualSDK
import SwiftUI

let qrViewModel = QRViewModel()

class QRViewModel : ObservableObject {
    var qrCodeGuide: QRCodeGuide?
    var contextualContainer: ContextualContainer? {
        qrCodeGuide?.contextualContainer
    }
    var scanButtonTapped: (() -> ())?
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

}
