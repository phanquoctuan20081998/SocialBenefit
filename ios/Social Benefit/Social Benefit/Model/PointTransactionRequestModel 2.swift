//
//  PointTransactionRequestModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 08/12/2021.
//

import Foundation

struct PointTransactionRequestData: Hashable, Codable {
    
//    internal var id = UUID()
    private var employeeId: Int
    private var point: Int
    private var message: String

    
    public init(employeeId: Int, point: Int, message: String) {
        self.employeeId = employeeId
        self.point = point
        self.message = message
    }
    
    public func getEmployeeId() -> Int {
        return employeeId
    }
    
    public mutating func setEmployeeId(employeeId: Int) {
        self.employeeId = employeeId
    }
    
    public func getPoint() -> Int {
        return point
    }
    
    public mutating func setPoint(point: Int) {
        self.point = point
    }
    
    public func getMessage() -> String {
        return message
    }
    
    public mutating func setMessage(message: String) {
        self.message = message
    }
}
