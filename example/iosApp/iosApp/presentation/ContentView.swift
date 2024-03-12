//
//  ContentView.swift
//  iosApp
//
//  Created by Rui Canas on 26/11/2023.
//

import SwiftUI
import qrose

struct ContentView: View {
    
    let data: Data

    var body: some View {
        VStack(spacing: 30) {
            Text("QRCode-Kotlin")
                .font(.title2)
                .foregroundColor(.blue)
                .bold()
            
            Image(uiImage: UIImage(data: data) ?? .init())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .background(Color.clear)
        }
    }
    
    init() {
        let qrShapes = QrShapes(
            code: QrCodeShapeCompanion.shared.Default,
            darkPixel: QrPixelShapeCompanion.shared.roundCorners(radius: 0.5),
            lightPixel: QrPixelShapeCompanion.shared.Default,
            ball: QrBallShapeCompanion.shared.circle(size: 1),
            frame: QrFrameShapeCompanion.shared.roundCorners(
                corner: 0.25,
                width: 1,
                topLeft: true,
                bottomLeft: true,
                topRight: true,
                bottomRight: true
            ),
            centralSymmetry: true
        )
        let qrColors = QrColors(
            dark: QrBrushCompanion.shared.Default,
            light: QrBrushCompanion.shared.Unspecified,
            ball: QrBrushCompanion.shared.solid(color: KotlinColor.BlocksBlue),
            frame: QrBrushCompanion.shared.solid(color: KotlinColor.BlocksBlue)
        )
        
        let logoData = UIImage(named: "blocks")!.pngData()!.toKotlinByteArary
        
        let qrLogo = QrLogo(
            painter: ConvertersKt.PainterFromBitmap(byteImage: logoData),
            size: 0.2,
            padding: QrLogoPaddingNatural(size: 0.3),
            shape: QrLogoShapeCompanion.shared.circle()
        )
        
        let options = QrOptions(
            shapes: qrShapes,
            colors: qrColors,
            logo: qrLogo,
            errorCorrectionLevel: QrErrorCorrectionLevel.auto_,
            fourEyed: false
        )
        let painter = QrCodePainter(data: "https://blockslockers.com", options: options)
        let data = painter.toByteArray(width: 1000, height: 1000, format: .png).toData
        
        self.data = data
    }
}

#Preview {
    ContentView()
}
