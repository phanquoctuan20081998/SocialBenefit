//
//  RankingOfRecognitionModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 27/11/2021.
//

import Foundation

struct RankingOfRecognitionData: Identifiable, Hashable {
    
    internal var id: Int
    private var rank: Int
    private var avatar: String
    private var employeeName: String
    private var totalScore: Int

    
    public init(id: Int, rank: Int, avatar: String, employeeName: String, totalScore: Int) {
        self.id = id
        self.rank = rank
        self.avatar = avatar
        self.employeeName = employeeName
        self.totalScore = totalScore
    }
    
    public func getId() -> Int {
        return id
    }
    
    public mutating func setId(id: Int) {
        self.id = id
    }
    
    public func getRank() -> Int {
        return rank
    }
    
    public mutating func setRank(rank: Int) {
        self.rank = rank
    }
    
    public func getAvatar() -> String {
        return avatar
    }
    
    public mutating func setAvatar(avatar: String) {
        self.avatar = avatar
    }
    
    public func getEmployeeName() -> String {
        return employeeName
    }
    
    public mutating func setEmployeeName(employeeName: String) {
        self.employeeName = employeeName
    }
    
    public func getTotalScore() -> Int {
        return totalScore
    }
    
    public mutating func setTotalScore(totalScore: Int) {
        self.totalScore = totalScore
    }
    
    public static var sampleData: [RankingOfRecognitionData] = [
        RankingOfRecognitionData(id: 367, rank: 1, avatar: "", employeeName: "Bé khỏe", totalScore: 0),
        RankingOfRecognitionData(id: 368, rank: 2, avatar: "", employeeName: "ssssss", totalScore: 0),
        RankingOfRecognitionData(id: 369, rank: 3, avatar: "", employeeName: "ssssss", totalScore: 0),
        RankingOfRecognitionData(id: 370, rank: 4, avatar: "", employeeName: "ssssss", totalScore: 0)
    ]
    
}
