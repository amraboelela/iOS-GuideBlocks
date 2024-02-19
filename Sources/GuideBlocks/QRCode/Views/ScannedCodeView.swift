//
//  ScannedCodeView.swift
//  GuideBlocks
//
//  Created by Amr Aboelela on 2024/2/19.
//  Copyright © 2024 Contextual.
//

import SwiftUI

struct ScannedCodeView: View {
    @State var scannedCode: String
    
    var body: some View {
        Text("QR Code: \(scannedCode)")
    }
}

struct ScannedCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedCodeView(scannedCode: "1234ABC567890")
    }
}
