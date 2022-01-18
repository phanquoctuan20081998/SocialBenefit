//
//  VUIAppResponseModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation

struct VUIAppResponse {
    
    private var error: Int
    private var message: String
    private var webUrl: String
    
    public func getWebUrl() -> String {
        return self.webUrl
    }
    
    public mutating func setWebUrl(url: String) {
        self.webUrl = url
    }
}
