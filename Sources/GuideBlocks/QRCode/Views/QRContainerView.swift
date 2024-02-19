//
//  QRContainerView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct QRContainerView: View {
    @ObservedObject var viewModel: QRViewModel
    //@State private var isPopupVisible = false
    
    var body: some View {
        VStack {
            Text("QR Code scanning")
            QRCodeScannerView(viewModel: viewModel)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct QRContainerView_Previews: PreviewProvider {
    static var previews: some View {
        QRContainerView(viewModel: qrViewModel)
    }
}
