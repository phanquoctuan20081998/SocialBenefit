//
//  WalletInforModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 06/12/2021.
//

import Foundation

struct WalletInforData: Hashable, Codable {
    
//    internal var id = UUID()
    private var companyPoint: Int
    private var personalPoint: Int

    
    public init(companyPoint: Int, personalPoint: Int) {
        self.companyPoint = companyPoint
        self.personalPoint = personalPoint
    }
    
    public func getCompanyPoint() -> Int {
        return companyPoint
    }
    
    public mutating func setCompanyPoint(companyPoint: Int) {
        self.companyPoint = companyPoint
    }
    
    public func getPersonalPoint() -> Int {
        return personalPoint
    }
    
    public mutating func setPersonalPoint(personalPoint: Int) {
        self.personalPoint = personalPoint
    }
    
   
    public static var sampleData: WalletInforData = WalletInforData(companyPoint: 1000, personalPoint: 700)
    
}
