//
//  BenefitsModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation
    


struct BenefitData: Identifiable, Hashable {
    
    var id: Int
    var title: String
    var body: String
    var logo: String
    var typeMember: Int
    var status: Int
    var mobileStatus: Int
    var actionTime: String
    
    init() {
        self.id = 0
        self.title = ""
        self.body = ""
        self.logo = ""
        self.typeMember = 0
        self.status = 0
        self.mobileStatus = 0
        self.actionTime = ""
    }
    
    init(id: Int, title: String, body: String, logo: String, typeMember: Int, status: Int, mobileStatus: Int, actionTime: String) {
        self.id = id
        self.title = title
        self.body = body
        self.logo = logo
        self.typeMember = typeMember
        self.status = status
        self.mobileStatus = mobileStatus
        self.actionTime = actionTime
    }
    
    // This is status of benefit...
    // Look at benefit table...
    struct STATUS {
        static let ON_GOING = 0
        static let PASSED = 1
        static let CANCELLED = 2
    }

    // This is status of approval benefit...
    // Look at employee_benefit table...
    struct APPROVAL_STATUS {
        static let REGISTERED = 0
        static let APPROVED = 1
        static let REJECTED = 2
        static let RECEIVED = 3
        
    }

    struct MEMBER_TYPE {
        static let BENEFIT_TYPE_ALL_MEMBER = 0
        static let BENEFIT_TYPE_WOMAN_MEMBER = 1
        static let BENEFIT_TYPE_REGISTER_MEMBER = 2
        static let BENEFIT_TYPE_UNION_MEMBER = 3
        static let BENEFIT_TYPE_SPECIAL_CHOSE = 5
    }

    struct MOBILE_STATUS {
        static let MOBILE_BENEFIT_STATUS_ON_GOING = 0      // Display "on going"
        static let MOBILE_BENEFIT_STATUS_UP_COMMING = 1    // Display "up comming"
        static let MOBILE_BENEFIT_STATUS_RECEIVED = 2      // Display tick mark
        static let MOBILE_BENEFIT_STATUS_NOT_REGISTER = 3  // Display aplly buton
        static let MOBILE_BENEFIT_STATUS_REGISTER = 4      // Display "waitting to confirm"
        static let MOBILE_BENEFIT_STATUS_APPROVED = 5      // Display nothing
        static let MOBILE_BENEFIT_STATUS_REJECTED = 6      // Display X
        static let MOBILE_BENEFIT_STATUS_PENDING_REGISTER = 7 // Display pending
    }
}
