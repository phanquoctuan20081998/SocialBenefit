//
//  Constant.swift
//  Social Benefit
//
//  Created by Admin on 7/9/21.
//

import Foundation
import Foundation

struct Config {
    
    static let baseURL = "http://172.20.109.102:8089"
    
    static let API_LOGIN = "/employee/login"
    static let API_EMPLOYEE_FORGOTPASS = "/employee/forgotpassword"
    
    static let API_BENEFIT_LIST = "/benefit/list"
    static let API_BENEFIT_APPLY = "/benefit/employee/apply"
    static let API_BENEFIT_CHECK = "/benefit/employee/check"
    
    static let API_MERCHANT_CATEGORY = "/merchant-voucher-category"
    static let API_MERCHANT_LIST_SPECIAL = "/merchant-voucher-special-list"
    static let API_MERCHANT_LIST_BY_CATEGORY = "/merchant-voucher-list-by-category"
    static let API_CONFIRM_BUY_VOUCHER = "/mobile/voucher/confirm_info_buy"
    static let API_BUY_VOUCHER = "/by-voucher"

    static let API_INTERNEL_NEWS_LIST = "/internal_news/list"
    static let API_LOCATION_LIST = "/location/list"
    
    static let API_COMMENT_LIST = "/comment/list"
    static let API_COMMENT_ADD = "/comment/add"
    
    static let API_CONTENT_LIST_REACT = "/content/get/react"
    static let API_CONTENT_REACT = "/content/react"
    
}
