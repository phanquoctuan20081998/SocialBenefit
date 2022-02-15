//
//  VUIAppResponseModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 18/01/2022.
//

import Foundation

struct VUIAppResponse {
    
    private var error: Int
    private var applicationCode: String
    private var webUrl: String
    
    public init() {
        error = 0
        applicationCode = ""
        webUrl = ""
    }
    
    public func getError() -> Int {
        return self.error
    }
    
    public mutating func setError(error: Int) {
        self.error = error
    }
    
    public func getApplicationCode() -> String {
        return self.applicationCode
    }
    
    public mutating func setApplicationCode(applicationCode: String) {
        self.applicationCode = applicationCode
    }
    
    public func getWebUrl() -> String {
        return self.webUrl
    }
    
    public mutating func setWebUrl(url: String) {
        self.webUrl = url
    }
}
