//
//  GeneratorQRCode.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import Foundation
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

struct QRCodeView : View {

    var code : String
    
    var body:some View{
        Image(uiImage: genrateQRImage(_url: code))
            .interpolation(.none)
            .resizable()
            .frame(width: 100, height: 100, alignment: .center)
    }
 
    func genrateQRImage(_url:String) -> UIImage {
        let data = Data(code.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent){
            return UIImage(cgImage: qrCodeCGImage)
           }
        }
            return UIImage(systemName: "xmark") ?? UIImage()
    }
}


