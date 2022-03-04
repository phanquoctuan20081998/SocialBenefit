//
//  FAQPolicyModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 03/03/2022.
//

import Foundation

struct FAQPolicyModel: APIResponseProtocol {
    var status: Int?
    var result: FAQPolicyResultModel?
    var messages: [String]?
    
    var hasContent: Bool {
        if let content = result?.content, !content.isEmpty {
            return true
        }
        return false
    }
}

struct FAQPolicyResultModel: APIModelProtocol {
    var content: String?
}
