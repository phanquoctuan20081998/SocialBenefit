//
//  Constant.swift
//  Social Benefit
//
//  Created by Admin on 7/9/21.
//

import Foundation
import Foundation

struct Config {
    
//    static let baseURL = "http://172.20.109.102:8089"
//    static let baseURL = "http://172.20.108.151:8066"
//    static let baseURL = "http://localhost:8089"
//    static let baseURL = "http://demo-sb.nissho-vn.com:8089"
    static let baseURL = "http://113.190.243.99:8089"
    
    static let API_LOGIN = "/employee/login"
    static let API_EMPLOYEE_FORGOTPASS = "/employee/forgotpassword"
    static let API_EMPLOYEE_CHANGEPASSWORD = "/employee/changepassword"
    
    static let API_BENEFIT_LIST = "/benefit/list"
    static let API_BENEFIT_APPLY = "/benefit/employee/apply"
    static let API_BENEFIT_CHECK = "/benefit/employee/check"
    static let API_BENEFIT_GET = "/benefit/get"
    
    static let API_MERCHANT_CATEGORY = "/merchant-voucher-category"
    static let API_MERCHANT_LIST_SPECIAL = "/merchant-voucher-special-list"
    static let API_MERCHANT_LIST_BY_CATEGORY = "/merchant-voucher-list-by-category"
    static let API_CONFIRM_BUY_VOUCHER = "/mobile/voucher/confirm_info_buy"
    static let API_BUY_VOUCHER = "/by-voucher"
    static let API_MY_VOUCHER = "/list-my-voucher"
    static let API_GEN_VOUCHER_CODE = "/gen-voucher-code"
    static let API_MERCHANT_VOUCHER_DETAIL = "/merchant-voucher-detail"
    static let API_APPLIED_STORE_MERCHANT_LIST = "/applied-store-merchant-list"
    static let API_MERCHANT_VOUCHER_LIST_BY_SIMILAR = "/merchant-voucher-list-by-similar"

    static let API_INTERNAL_NEWS_LIST = "/internal_news/list"
    static let API_INTERNAL_NEWS_GET = "/internal_news/get"
    
    static let API_EMPLOYEE_INFO_UPDATE = "/mobile/employee/update"
    static let API_EMPLOYEE_INFO = "/employee/get"
    static let API_LOCATION_LIST = "/location/list"
    
    static let API_COMMENT_LIST = "/comment/list"
    static let API_COMMENT_ADD = "/comment/add"
    static let API_COMMENT_UPDATE = "/comment/update"
    static let API_COMMENT_DELETE = "/comment/delete"
    
    static let API_CONTENT_LIST_REACT = "/content/get/react"
    static let API_CONTENT_REACT = "/content/react"
    
    static let API_GET_REACT_COUNT_GROUP = "/content/get/react/group_count"
    static let API_GET_REACT_LIST = "/content/get/react/list"
    
    static let API_SEND_MAIL_CUSTOMER_SUPPORT = "/mobile/mail/customer_support"
    
    static let API_USED_POINTS_HISTORY_GET = "/used-points-history"
    
    static let API_RECOGNITION_LIST_BY_COMPANY = "/mobile/recognition/company/list"
    static let API_RECOGNITION_LIST_BY_EMPLOYEE = "/mobile/recognition/employee/list"
    static let API_RECOGNITION_TOP_RANK = "/mobile/recognition/top"
    static let API_RECOGNITION_RANKING_LIST = "/mobile/recognition/ranking/list"
    static let API_RECOGNITION_RANKING_EMPLOYEE_GET = "/mobile/recognition/ranking/employee/get"
    static let API_RECOGNITION_DETAIL_GET = "/mobile/recognition/detail/get"
    static let API_RECOGNITION_GET = "/mobile/recognition/get"
    
    static let API_RECOGNITION_FIND_EMPLOYEE = "/mobile/recognition/employee/find"
    static let API_RECENT_TRANSACTION_LIST = "/mobile/recent_transaction/list"
    static let API_EMPLOYEE_WALLET_INFO_GET = "/mobile/employee/wallet/get"
    static let API_RECOGNITION_SEND  = "/mobile/recognition/send"
    
    static let API_MOBILE_VIEW_CLICK = "/mobile/view_click"
    
    static let API_SURVEY_LIST = "/mobile/survey/list"
    static let API_SURVEY_CHOICE = "/mobile/survey/choice"
    static let API_SURVEY_GET = "/survey/get"
    
    static let API_NOTIFICATION_LIST = "/notification_log/list"
    static let API_NOTIFICATION_READ = "/notification_log/read"
    static let API_NOTIFICATION_TOTAL = "/notification_log/total"
    
    static let API_MERCHANT_SPECIAL_SETTINGS_GET = "/merchant_special_settings/get"
}
