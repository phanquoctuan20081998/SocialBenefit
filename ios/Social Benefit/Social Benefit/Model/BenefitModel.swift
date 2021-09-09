//
//  BenefitsModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation

struct STATUS {
    let ON_GOING = 0 //Display "on going"
    let UP_COMMING = 1 //Display "up comming"
    let RECEIVED = 2//Display tick mark
    let NOT_REGISTER = 3 //Display aplly buton
    let REGISTER = 4//Display "waitting to confirm"
    let APPROVED = 5//
    let REJECTED = 6//Display X
}
    
struct BenefitData: Identifiable, Hashable {
    var id: Int
    var title: String
    var body: String
    var logo: String
    var typeMember: Int
    var status: Int
    var mobileStatus: Int
    
    init() {
        self.id = 0
        self.title = ""
        self.body = ""
        self.logo = ""
        self.typeMember = 0
        self.status = 0
        self.mobileStatus = 0
    }
    
    init(id: Int, title: String, body: String, logo: String, typeMember: Int, status: Int, mobileStatus: Int) {
        self.id = id
        self.title = title
        self.body = body
        self.logo = logo
        self.typeMember = typeMember
        self.status = status
        self.mobileStatus = mobileStatus
    }
}
