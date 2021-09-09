//
//  Constant.swift
//  Social Benefit
//
//  Created by Admin on 7/9/21.
//

import Foundation
import Foundation

struct Constant {
    static let baseURL = "http://172.20.109.102:8089"
    static let API_LOGIN = "/employee/login"
    static let API_EMPLOYEE_FORGOTPASS = "/employee/forgotpassword"
    
    static let API_BENEFIT_LIST = "/benefit/list"
    static let API_BENEFIT_APPLY = "/benefit/employee/apply"
    
    static let API_INTERNEL_NEWS_LIST = "/internal_news/list"
    static let API_LOCATION_LIST = "/location/list"
    static let API_MERCHANT_LIST_SPECIAL = "/merchant-voucher-special-list"
    
    static let API_COMMENT_LIST = "/comment/list"
    static let API_COMMENT_ADD = "/comment/add"
    
    static let API_CONTENT_LIST_REACT = "/content/get/react"
    static let API_CONTENT_REACT = "/content/react"
    
}
