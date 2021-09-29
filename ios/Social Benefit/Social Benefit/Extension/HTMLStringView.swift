//
//  HTML.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import UIKit
import SwiftUI

struct HTMLText: UIViewRepresentable {
    
    private(set) var html: String
    
    func makeUIView(context: UIViewRepresentableContext<HTMLText>) -> UILabel {
        let label = UILabel()
        label.text = """
        This is UILabel, one of the most interesting View class in UIKit.
        With autolayout and multiline and it often give you some surprises.
        Now using it with SwiftUI = 🤯
        """
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        DispatchQueue.global(qos: .userInitiated).async {
            // do something
            label.attributedText = html.convertHtml()
        }
        
        return label
    }

    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<HTMLText>) { }
}


extension String {
    
    func convertToAttributedFromHTML() -> NSAttributedString? {
        var attributedText: NSAttributedString = NSAttributedString(string: "")
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        if let data = data(using: .unicode, allowLossyConversion: true), let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attrStr
        }
        return attributedText
    }

    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
}

