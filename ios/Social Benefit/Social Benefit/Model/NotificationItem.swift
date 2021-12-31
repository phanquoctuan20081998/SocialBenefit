//
//  NotificationItem.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/12/2021.
//

import Foundation

struct NotificationItemData: Hashable, Codable {
    
    private var id: Int
    private var imgURL: String
    private var typeId: Int
    private var type: Int
    private var content: String
    private var createdTime: Int
    private var status: Int
    private var contentParams: [String]
    private var receivedId: Int
    private var point: Int
    
    public init(id: Int, imgURL: String, typeId: Int, type: Int, content: String, createdTime: Int, status: Int, contentParams: [String], receivedId: Int, point: Int) {
        self.id = id
        self.imgURL = imgURL
        self.typeId = typeId
        self.type = type
        self.content = content
        self.createdTime = createdTime
        self.status = status
        self.contentParams = contentParams
        self.receivedId = receivedId
        self.point = point
    }
    
    public init() {
        self.id = 0
        self.imgURL = ""
        self.typeId = 0
        self.type = 0
        self.content = ""
        self.createdTime = 0
        self.status = 0
        self.contentParams = []
        self.receivedId = 0
        self.point = 0
    }
    
    public func getId() -> Int {
        return self.id
    }
    
    public mutating func setId(id: Int) {
        self.id = id
    }
    
    public func getImgURL() -> String {
        return self.imgURL
    }
    
    public mutating func setImgURL(imgURL: String) {
        self.imgURL = imgURL
    }
    
    public func getTypeId() -> Int {
        return self.typeId
    }
    
    public mutating func setTypeId(typeId: Int) {
        self.typeId = typeId
    }
    
    public func getType() -> Int {
        return self.type
    }
    
    public mutating func setType(type: Int) {
        self.type = type
    }
    
    public func getContent() -> String {
        return self.content
    }
    
    public mutating func setContent(content: String) {
        self.content = content
    }
    
    public func getCreatedTime() -> Int {
        return self.createdTime
    }
    
    public mutating func setCreatedTime(createdTime: Int) {
        self.createdTime = createdTime
    }
    
    public func getStatus() -> Int {
        return self.status
    }
    
    public mutating func setStatus(status: Int) {
        self.status = status
    }
    
    public func getContentParams() -> [String] {
        return self.contentParams
    }
    
    public mutating func setContentParams(contentParams: [String]) {
        self.contentParams = contentParams
    }
    
    public func getReceivedId() -> Int {
        return self.receivedId
    }
    
    public mutating func setReceivedId(receivedId: Int) {
        self.receivedId = receivedId
    }
    
    public func getPoint() -> Int {
        return self.point
    }
    
    public mutating func setPoint(point: Int) {
        self.point = point
    }
    
    public static var sampleData: [NotificationItemData] = [
        NotificationItemData(id: -1, imgURL: "", typeId: 198856, type: 1, content: "COO193_I", createdTime: 1639872010000, status: 1, contentParams: ["test hôm nay", "ABC"], receivedId: 0, point: -10)
    ]
}
