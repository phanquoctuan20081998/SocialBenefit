//
//  RecentTransferModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 03/12/2021.
//

import Foundation

struct UserData: Identifiable, Hashable {
    
    internal var id: Int
    private var avatar: String
    private var employeeCode: String
    private var nickname: String
    private var fullName: String
    private var positionName: String
    private var devisionName: String
    private var departmentName: String

    
    public init(id: Int, avatar: String, employeeCode: String, nickname: String, fullName: String, positionName: String, devisionName: String, departmentName: String) {
        self.id = id
        self.avatar = avatar
        self.employeeCode = employeeCode
        self.nickname = nickname
        self.fullName = fullName
        self.positionName = positionName
        self.devisionName = devisionName
        self.departmentName = departmentName
    }
    
    public init() {
        self.id = -1
        self.avatar = ""
        self.employeeCode = ""
        self.nickname = ""
        self.fullName = ""
        self.positionName = ""
        self.devisionName = ""
        self.departmentName = ""
    }
    
    public func getId() -> Int {
        return id
    }
    
    public mutating func setId(id: Int) {
        self.id = id
    }
    
    public func getAvatar() -> String {
        return avatar
    }
    
    public mutating func setAvatar(avatar: String) {
        self.avatar = avatar
    }
    
    public func getEmployeeCode() -> String {
        return employeeCode
    }
    
    public mutating func setEmployeeCode(employeeCode: String) {
        self.employeeCode = employeeCode
    }
    
    public func getNickname() -> String {
        return nickname
    }
    
    public mutating func setNickname(nickname: String) {
        self.nickname = nickname
    }
    
    public func getFullName() -> String {
        return fullName
    }
    
    public mutating func setFullName(fullName: String) {
        self.fullName = fullName
    }
    
    public func getPositionName() -> String {
        return positionName
    }
    
    public mutating func setPositionName(positionName: String) {
        self.positionName = positionName
    }
    
    public func getDevisionName() -> String {
        return devisionName
    }
    
    public mutating func setDevisionName(devisionName: String) {
        self.devisionName = devisionName
    }
    
    public func getDepartmentName() -> String {
        return departmentName
    }
    
    public mutating func setDepartmentName(departmentName: String) {
        self.departmentName = departmentName
    }

    
    public static var sampleData: [UserData] = [UserData(id: 370, avatar: "", employeeCode: "13131231", nickname: "", fullName: "Nguyễn Văn An1", positionName: "", devisionName: "", departmentName: "Quản lý hệ thống"),
                                                          UserData(id: 370, avatar: "", employeeCode: "13131231", nickname: "", fullName: "N An1", positionName: "", devisionName: "", departmentName: "Quản lý hệ thống"),
                                                          UserData(id: 370, avatar: "", employeeCode: "13131231", nickname: "", fullName: "Nguyễn Vănadasdasd An1", positionName: "", devisionName: "", departmentName: "Quản lý hệ thống")]
                                                
    
    
}
