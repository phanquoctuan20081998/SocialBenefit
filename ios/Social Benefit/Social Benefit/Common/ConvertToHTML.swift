//
//  ConvertToHTMLUTF8.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/12/2021.
//

import Foundation

func convertFromHTMLString(_ input: String?) -> NSAttributedString? {
    guard let input = input else { return nil }
    
    guard let data = input.data(using: String.Encoding.unicode, allowLossyConversion: true) else { return nil  }
    return try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
}

func convertToHTMLString(_ body: String) -> String {
    
    return "<!DOCTYPE html>\n" +
            "<html>\n" +
            "\n" +
            "<head>\n" +
            "<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=no\">" +
            "</head>\n" +
            "<style> \n" +
            "img{display: block;height: auto;max-width: 100%; margin-right: auto ;margin-left: auto;} \n" +
            "body { word-wrap: break-word; font-family: -apple-system, BlinkMacSystemFont, sans-serif; font-size: 0.775em;} \n" +
            "pre { white-space: pre-wrap; word-break: keep-all; } \n" +
            "</style> \n" +
            "\n" +
            "<body>\n" +
            body +
            "\n" +
            "</body>\n" +
            "\n" +
            "</html>";
}


