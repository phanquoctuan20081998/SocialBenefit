//
//  HTML.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import UIKit
import SwiftUI

extension String {
    var decoded: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)

        return attr?.string ?? self
    }
}

struct HTMLText: UIViewRepresentable {

   let html: String

   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
            }
        }

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}
