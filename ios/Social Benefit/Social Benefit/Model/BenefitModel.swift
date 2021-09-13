//
//  BenefitsModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation
    
// This is status of benefit...
// Look at benefit table...
struct STATUS {
    let ON_GOING = 0
    let PASSED = 1
    let CANCELLED = 2
}

// This is status of approval benefit...
// Look at employee_benefit table...
struct APPROVAL_STATUS {
    let REGISTERED = 0
    let APPROVED = 1
    let REJECTED = 2
    let RECEIVED = 3
    
}

struct MEMBER_TYPE {
    let BENEFIT_TYPE_ALL_MEMBER = 0
    let BENEFIT_TYPE_WOMAN_MEMBER = 1
    let BENEFIT_TYPE_REGISTER_MEMBER = 2
    let BENEFIT_TYPE_UNION_MEMBER = 3
    let BENEFIT_TYPE_SPECIAL_CHOSE = 5
}

struct MOBILE_STATUS {
    let MOBILE_BENEFIT_STATUS_ON_GOING = 0      // Display "on going"
    let MOBILE_BENEFIT_STATUS_UP_COMMING = 1    // Display "up comming"
    let MOBILE_BENEFIT_STATUS_RECEIVED = 2      // Display tick mark
    let MOBILE_BENEFIT_STATUS_NOT_REGISTER = 3  // Display aplly buton
    let MOBILE_BENEFIT_STATUS_REGISTER = 4      // Display "waitting to confirm"
    let MOBILE_BENEFIT_STATUS_APPROVED = 5      // Display nothing
    let MOBILE_BENEFIT_STATUS_REJECTED = 6      // Display X
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
