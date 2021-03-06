//
//  Constant.swift
//  Social Benefit
//
//  Created by Admin on 7/9/21.
//

import Foundation
import Foundation

struct Config {
    
    enum XcodeConfig {
        case dev
        case prod
        case ft
        case it
    }
    
    static let xcodeConfig: XcodeConfig = {
        #if DEV
        return .dev
        #elseif FT
        return .ft
        #elseif IT
        return .it
        #else
        return .prod
        #endif
    }()
    
    static var baseURL: String {
        switch xcodeConfig {
        case .dev:
            return "http://113.190.243.99:8044"
        case .ft:
            return "http://113.190.243.99:8066"
        case .prod:
            return "http://113.190.243.99:8089"
        case .it:
            return "http://113.190.243.99:8022"
        }
    }
    
    static var webAdminURL: String {
        switch xcodeConfig {
        case .dev:
            return "http://113.190.243.99:4044"
        case .ft:
            return "http://113.190.243.99:4066"
        case .prod:
            return "http://113.190.243.99:4000"
        case .it:
            return "http://113.190.243.99:4022"
        }
    }
    
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
    static let API_MY_FAVORITE_MERCHANT_LIST = "/my-favorite-merchant-list"
    static let API_UPDATE_MY_FAVORITE_MERCHANT_LIST = "/my-favorite-merchant-list/update"
    static let API_MERCHANT_LIST_BY_MERCHANT = "/merchant-voucher-list-by-merchant"

    static let API_INTERNAL_NEWS_LIST = "/internal_news/list"
    static let API_INTERNAL_NEWS_GET = "/internal_news/get"
    
    static let API_EMPLOYEE_INFO_UPDATE = "/mobile/employee/update"
    static let API_EMPLOYEE_INFO = "/employee/get"
    static let API_LOCATION_LIST = "/location/list"
    
    static let API_COMMENT_LIST = "/comment/list"
    static let API_COMMENT_ADD = "/comment/add"
    static let API_COMMENT_GET = "/comment/get"
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
    
    static let API_FAQ_POLICY_GET = "/mobile/faq_policy/get"
    
    static let API_RECENT_VIEW_VOUCHER = "/merchant-voucher-recent-view"
    
    static let API_HOME_SURVEY = "/mobile/survey/home/list"
    
    static let API_ONBOARING_VN = "/onBoarding_vn.json"
    static let API_ONBOARING = "/onBoarding.json"
}
