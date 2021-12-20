//
//  ViewClickItem.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/12/2021.
//

import Foundation

struct ViewClickItemData: Hashable, Codable {
    
    private var contentId: Int
    private var contentType: Int
    
    public init(contentId: Int, contentType: Int) {
        self.contentId = contentId
        self.contentType = contentType
    }
    
    public func getContentId() -> Int {
        return contentId
    }
    
    public mutating func setContentId(contentId: Int) {
        self.contentId = contentId
    }
    
    public func getContentType() -> Int {
        return contentType
    }
    
    public mutating func setContentType(contentType: Int) {
        self.contentType = contentType
    }
}
