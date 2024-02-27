//
//  QRCodeScannerView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import CodeScanner
import SwiftUI

struct QRCodeScannerView: View {
    @ObservedObject var viewModel: QRViewModel
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?

    //var scanButtonTapped: (() -> ())?
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Button("Scan Code") {
                isPresentingScanner = true
                viewModel.scanButtonTapped?()
            }
            .padding(40)
            if let code = scannedCode {
                Text("Scanned code:")
                Text(code)
            } else {
                Text("Scan a QR code to begin")
            }
            Spacer()
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    scannedCode = result.string
                    isPresentingScanner = false
                    viewModel.scannedCodeCallback?(result.string)
                }
            }
        }
    }
}

struct QRCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerView(viewModel: qrViewModel)
    }
}
