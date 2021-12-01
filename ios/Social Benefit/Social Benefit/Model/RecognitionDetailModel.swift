//
//  RecognitionDetailModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/11/2021.
//

import Foundation

struct RecognitionDetailData: Identifiable, Hashable {
    
    internal var id: Int
    private var senderAvatar: String
    private var senderFullName: String
    private var senderJobDescription: String
    private var receiverAvatar: String
    private var receiverFullName: String
    private var point: Int
    private var recognitionNote: String
    private var recognitionTime: Date

    
    public init(id: Int, senderAvatar: String, senderFullName: String, senderJobDescription: String, receiverAvatar: String, receiverFullName: String, point: Int, recognitionNote: String, recognitionTime: Date) {
        self.id = id
        self.senderAvatar = senderAvatar
        self.senderFullName = senderFullName
        self.senderJobDescription = senderJobDescription
        self.receiverAvatar = receiverAvatar
        self.receiverFullName = receiverFullName
        self.point = point
        self.recognitionNote = recognitionNote
        self.recognitionTime = recognitionTime
    }
    
    public func getId() -> Int {
        return id
    }
    
    public mutating func setId(id: Int) {
        self.id = id
    }
    
    public func getSenderAvatar() -> String {
        return senderAvatar
    }
    
    public mutating func setSenderAvatar(senderAvatar: String) {
        self.senderAvatar = senderAvatar
    }
    
    public func getSenderFullName() -> String {
        return senderFullName
    }
    
    public mutating func setSenderFullName(senderFullName: String) {
        self.senderFullName = senderFullName
    }
    
    public func getSenderJobDescription() -> String {
        return senderJobDescription
    }
    
    public mutating func setSenderJobDescription(senderJobDescription: String) {
        self.senderJobDescription = senderJobDescription
    }
    
    public func getReceiverAvatar() -> String {
        return receiverAvatar
    }
    
    public mutating func setReceiverAvatar(receiverAvatar: String) {
        self.receiverAvatar = receiverAvatar
    }
    
    public func getReceiverFullName() -> String {
        return receiverFullName
    }
    
    public mutating func setReceiverFullName(receiverFullName: String) {
        self.receiverFullName = receiverFullName
    }
    
    public func getPoint() -> Int {
        return point
    }
    
    public mutating func setPoint(point: Int) {
        self.point = point
    }
    
    public func getRecognitionNote() -> String {
        return recognitionNote
    }
    
    public mutating func setRecognitionNote(recognitionNote: String) {
        self.recognitionNote = recognitionNote
    }
    
    public func getRecognitionTime() -> Date {
        return recognitionTime
    }
    
    public mutating func setRecognitionTime(recognitionTime: Date) {
        self.recognitionTime = recognitionTime
    }
    
    public static var sampleData: RecognitionDetailData = RecognitionDetailData(id: 9, senderAvatar: "", senderFullName: "Jen Jialun", senderJobDescription: "Truyền thông", receiverAvatar: "", receiverFullName: "Nguyễn Văn An 1", point: 400, recognitionNote: "Dep to employee 2", recognitionTime: Date())
    
    
}
