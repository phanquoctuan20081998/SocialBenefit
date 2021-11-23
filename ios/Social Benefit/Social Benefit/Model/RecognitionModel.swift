//
//  RecognitionModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/11/2021.
//

import Foundation

struct RecognitionData: Identifiable, Hashable {
    
    internal var id: Int
    private var createdTime: Date
    private var time: String
    private var date: String
    private var from: String
    private var to: String
    private var message: String
    private var point: Int
    
    // React, comment
    private var myReact: Int
    private var reactTop1: Int
    private var reactTop2: Int
    private var totalOtherReact: Int
    private var commentCount: Int
    
    public init(id: Int, createdTime: Date, time: String, date: String, from: String, to: String, message: String, point: Int, myReact: Int, reactTop1: Int, reactTop2: Int, totalOtherReact: Int, commentCount: Int) {
        self.id = id
        self.createdTime = createdTime
        self.time = time
        self.date = date
        self.from = from
        self.to = to
        self.message = message
        self.point = point
        
        self.myReact = myReact
        self.reactTop1 = reactTop1
        self.reactTop2 = reactTop2
        self.totalOtherReact = totalOtherReact
        self.commentCount = commentCount
    }
    
    public func getId() -> Int {
        return id
    }
    
    public mutating func setId(id: Int) {
        self.id = id
    }
    
    public func getCreatedTime() -> Date {
        return createdTime
    }
    
    public mutating func setCreatedTime(createdTime: Date) {
        self.createdTime = createdTime
    }
    
    public func getTime() -> String {
        return time
    }
    
    public mutating func setTime(time: String) {
        self.time = time
    }
    
    public func getDate() -> String {
        return date
    }
    
    public mutating func setDate(date: String) {
        self.date = date
    }
    
    public func getFrom() -> String {
        return from
    }
    
    public mutating func setFrom(from: String) {
        self.from = from
    }
    
    public func getTo() -> String {
        return to
    }
    
    public mutating func setTo(to: String) {
        self.to = to
    }
    
    public func getMessage() -> String {
        return message
    }
    
    public mutating func setMessage(message: String) {
        self.message = message
    }
    
    public func getPoint() -> Int {
        return point
    }
    
    public mutating func setPoint(point: Int) {
        self.point = point
    }
    
    public func getMyReact() -> Int {
        return myReact
    }
    
    public mutating func setMyReact(myReact: Int) {
        self.myReact = myReact
    }
    
    public func getReactTop1() -> Int {
        return reactTop1
    }
    
    public mutating func setReactTop1(reactTop1: Int) {
        self.reactTop1 = reactTop1
    }
    
    public func getReactTop2() -> Int {
        return reactTop2
    }
    
    public mutating func setReactTop2(reactTop2: Int) {
        self.reactTop2 = reactTop2
    }
    
    public func getTotalOtherReact() -> Int {
        return totalOtherReact
    }
    
    public mutating func setTotalOtherReact(totalOtherReact: Int) {
        self.totalOtherReact = totalOtherReact
    }
    
    public func getCommentCount() -> Int {
        return commentCount
    }
    
    public mutating func setCommentCount(commentCount: Int) {
        self.commentCount = commentCount
    }
    
    public static var sampleData: [RecognitionData] = [
        RecognitionData(id: 1, createdTime: Date(), time: "16: 30", date: "11/02/2020", from: "HieuDT", to: "QuangTD", message: "Good job! Khách hàng rất hài lòng về sản phẩm!", point: 50, myReact: -1, reactTop1: 2, reactTop2: -1, totalOtherReact: 1, commentCount: 0),
        RecognitionData(id: 2, createdTime: Date(), time: "15: 30", date: "15/02/2020", from: "HungND", to: "TrangNTT", message: "Mẫu thiết kế khá ổn, cảm ơn em.", point: 100, myReact: -1, reactTop1: -1, reactTop2: -1, totalOtherReact: 1, commentCount: 0)
    ]
    
}
