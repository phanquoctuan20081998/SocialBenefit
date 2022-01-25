//
//  Constants.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 18/09/2021.
//

import Foundation
import SwiftUI

struct Constants {
    
    // Sort...
    static let FilterAndSortType = ["ENUM_NEAREST_DEADLINE", "ENUM_FARTHEST_DEADLINE", "ENUM_LOWEST_PRICE", "ENUM_HIGHEST_PRICE", "ENUM_NAME_AZ", "ENUM_NAME_ZA", "ENUM_MOST_DISCOUNTS", "ENUM_BESTSELLER", "ENUM_BEST_REVIEW"]
    static let SortDirectionType = ["ASC", "DESC"]
    
    // Header...
    static let INTERNALNEWS_TABHEADER = ["all", "training", "annoucement", "other"]
    static let MYVOUCHER_TABHEADER = ["all", "active", "used", "expried"]
    static let VOUCHER_DETAIL_TAB = ["information", "applied_stores", "similar_promotions"]
    
    // Function ID...
    struct FuctionId {
        static let BENEFIT = "benefit"
        static let INTERNAL_NEWS = "internal_news"
        static let SURVEY = "survey"
        static let COMPANY_BUDGET_POINT = "company_budget_point"
    }
    
    // API load...
    static let MAX_NUM_API_LOAD = 10
    static let MAX_API_LOAD_SECOND = DispatchTimeInterval.seconds(100)
    
    // Internal News Type
    struct InternalNewsType {
        static let ALL = 0
        static let ANNOUCEMENT = 1
        static let TRAINING = 2
        static let OTHER = 3
    }
    
    // Comment & React...
    struct ReactType {
        static var LIKE = 0
        static var LOVE = 1
        static var LAUGH = 2
        static var SURPRISE = 3
        static var SAD = 4
        static var ANGRY = 5
    }
    
    struct ReactContentType {
        static var VOUCHER = 0
        static var INTERNAL_NEWS = 1
        static var COMMENT = 2
        static var SURVEY = 3
        static var RECOGNIZE = 4
    }
    
    struct CommentContentType {
        static var COMMENT_TYPE_RECOGNITION = 0
        static var COMMENT_TYPE_INTERNAL_NEWS = 1
        static var COMMENT_TYPE_COMMENT = 2
        static var COMMENT_TYPE_SURVEY = 3
    }
    
    // Language...
    struct LANGUAGE {
        static let ENG = 0
        static let VN = 1
    }
    
    static let LANGUAGE_TAB = ["en", "vn"]
    
    // Change Password Error...
    struct ChangePasswordErrors {
        static let password_not_match = "password_not_match"
        static let password_6_to_15 = "password_6_to_15"
        static let need_to_fill_all_data = "need_fill_all_data"
        static let wrong_old_password = "wrong_old_password"
        static let api_call_failed = "api_call_failed"
    }
    
    struct ChangePasswordErrorCodeResponse {
        static let MOBILE_WRONG_OLD_PASSWORD = 1
        static let MOBILE_CHANGE_PASSWORD_FAIL = -1
        static let MOBILE_CHANGE_PASSWORD_OK = 0
    }
    
    // Used Points History...
    struct UsedPointsHistory {
        static let FROMCOMPLIMENT = 0
        static let TOCOMPLIMENT = 1
        static let FROMBENEFIT = 2
        static let TOVOUCHER = 3
    }
    
    // Used Points History - Point Action Type...
    struct PointActionType {
        static let ALL = 0
        static let RECEIVED = 1
        static let COMSUMED = 2
    }
    
    // Recognition News Feed...
    struct RecognitionNewsFeedType {
        static let ALL = 0
        static let YOUR_HISTORY = 1
    }
    
    // Auto Resize Textfield...
    struct AutoResizeTextfieldType {
        static let DEFAULT = 0
        static let RECOGNITION_ACTION = 1
        static let CUSTOMER_SUPPORT = 2
    }
    
    // Click counting...
    struct ViewContent {
        static let TYPE_VOUCHER = 0
        static let TYPE_INTERNAL_NEWS = 1
        static let TYPE_BENEFIT = 2
        static let TYPE_SURVEY = 3
        static let TYPE_RECOGNITION = 4
        static let TYPE_OTHER = 5
        static let TYPE_COMMENT = 6
    }
    
    // Notification log type
    struct NotificationLogType {
        static let NOTIFICATION_HR = 0
        static let SURVEY = 1
        static let COMMENT = 2
        static let COMMENT_RECOGNITION = 20
        static let BENEFIT = 3
        static let RECOGNIZE = 4
        static let SYSTEM = 5
        static let INTERNAL_NEWS = 6
        static let BENEFIT_REQUEST = 7
        static let BENEFIT_APPROVE = 8
        static let SURVEY_REMIND = 9
        static let REACT_RECOGNITION = 10
        static let VOUCHER_REMIND = 11
        static let VOUCHER_EXPIRED = 12
        static let NEW_VOUCHER = 13
    }
    
    // Merchant Special
    struct MerchantSpecialCode {
        static let VNP = "VNP"
        static let VUI = "VUI"
        static let MED247 = "MED247"
        static let PTI = "PTI"
    }
    
    struct MerchantSpecialSettings {
        static let URL_WEBVIEW = "URL_WEBVIEW"
        static let AUTH_URL = "AUTH_URL"
        static let API_URL = "API_URL"
        static let COMPANY = "COMPANY"
        static let CODE = "CODE"
        static let ENV = "ENV"
    }
    
    static let APPID = "1601163900"
    static let RATEAPPURL = "https://itunes.apple.com/app/id\(APPID)?action=write-review"
    
    // Background Search Bar...
    static let BACKGROUND_SEARCH = [BackgroundSearch(tab: "company_surveys", icon: "chart.bar.xaxis", color: Color.purple, destination: 0, functionId: FuctionId.SURVEY),
                                    BackgroundSearch(tab: "employee_information", icon: "home_my_profile", color: Color.white, destination: 1, functionId: ""),
//                                    BackgroundSearch(tab:  "favorite merchants", icon: "heart.fill", color: Color.red, destination: 2),
                                    BackgroundSearch(tab: "home", icon: "ic_home", color: Color.white, destination: 3, functionId: ""),
                                    BackgroundSearch(tab: "search_internal_news", icon: "newspaper.fill", color: Color.green, destination: 4, functionId: FuctionId.INTERNAL_NEWS),
                                    BackgroundSearch(tab: "list_of_your_benefits", icon: "list.number", color: Color.blue, destination: 5, functionId: FuctionId.BENEFIT),
                                    BackgroundSearch(tab: "merchant_voucher_list", icon: "cart.fill", color: Color.blue, destination: 6, functionId: FuctionId.COMPANY_BUDGET_POINT),
                                    BackgroundSearch(tab: "my_vouchers", icon: "ic_my_voucher", color: Color.white, destination: 7, functionId: FuctionId.COMPANY_BUDGET_POINT),
                                    BackgroundSearch(tab: "recognize", icon: "star.fill", color: Color.yellow, destination: 8, functionId: FuctionId.COMPANY_BUDGET_POINT),
                                    BackgroundSearch(tab: "recognize_ranking", icon: "ic_medal_gold", color: Color.white, destination: 9, functionId: FuctionId.COMPANY_BUDGET_POINT),
                                    BackgroundSearch(tab: "used_points_history", icon: "clock.arrow.circlepath", color: Color.gray, destination: 10, functionId: FuctionId.COMPANY_BUDGET_POINT)]
}

enum AppLanguage: String, CaseIterable {
    case en
    case vi
}

struct BackgroundSearch {
    var tab: String
    var icon: String
    var color: Color
    var destination: Int
    var functionId: String
}
