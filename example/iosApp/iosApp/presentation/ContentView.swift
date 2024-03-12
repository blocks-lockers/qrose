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

//    let qrCode = QRCode
//        .companion
//        .ofSquares()
//        .withBackgroundColor(bgColor: Colors().TRANSPARENT)
//        .withColor(color: Colors().BLACK)
//        .withSize(size: 10)
//        .withInnerSpacing(innerSpacing: 1)
//        .build(data: Strings.data)
//        .renderToBytes(format: Strings.imageFormat)

    var body: some View {
        VStack(spacing: 30) {
            Text(Strings.title)
                .font(.title2)
                .foregroundColor(.blue)
                .bold()
            
//            if let data {
                Image(
                    uiImage: UIImage(data: data) ?? .init()
                )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .background(Color.clear)
//            }
        }
    }
    
    init() {
        let qrShapes = QrShapes(
            code: QrCodeShapeCompanion.shared.Default,
            darkPixel: QrPixelShapeCompanion.shared.roundCorners(radius: 0.5),
            lightPixel: QrPixelShapeCompanion.shared.Default,
            ball: QrBallShapeCompanion.shared.circle(size: 1),
//            frame: QrFrameShapeCompanion.shared.Default,
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
//            dark: QrBrushCompanion.shared.brush { it in
//                Ui_graphicsBrush.companion.linearGradient(colors: [KotlinColor.Red, KotlinColor.Blue], start: 0, end: 1, tileMode: 0)
//            },
            dark: QrBrushCompanion.shared.Default,
            light: QrBrushCompanion.shared.Unspecified,
            ball: QrBrushCompanion.shared.solid(color: KotlinColor.Blue),
            frame: QrBrushCompanion.shared.Unspecified
        )
//        EmptyPainter
//        Ui_graphicsDrawScope.
        
        let logoData = UIImage(named: "jc")!.jpegData(compressionQuality: 1)!.toKotlinByteArary
        
        let qrLogo = QrLogo(
            painter: ConvertersKt.PainterFromBitmap(byteImage: logoData, width: 0, height: 0),
            size: 0.2,
//            padding: QrLogoPaddingEmpty.shared,
            padding: QrLogoPaddingNatural(size: 0.1),
//            shape: QrLogoShapeCompanion.shared.Default
            shape: QrLogoShapeCompanion.shared.circle()
        )
        
        let options = QrOptions(
            shapes: qrShapes,
            colors: qrColors,
            logo: qrLogo,
            errorCorrectionLevel: QrErrorCorrectionLevel.auto_,
            fourEyed: false
        )
        let painter = QrCodePainter(data: "asfd", options: options)
        let data = painter.toByteArray(width: 300, height: 300, format: .png).toData
        
        self.data = data
//        print(painter.toByteArray(width: 200, height: 300, format: .png))
    }
}

#Preview {
    ContentView()
}

private enum Strings {
    
    static let title = "QRCode-Kotlin"
    static let data = "https://github.com/g0dkar/qrcode-kotlin"
    static let imageFormat = "PNG"
}
