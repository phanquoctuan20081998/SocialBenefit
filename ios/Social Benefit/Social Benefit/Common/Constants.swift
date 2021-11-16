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
    static let INTERNALNEWS_TABHEADER = ["all", "training", "annoucement"]
    static let MYVOUCHER_TABHEADER = ["all", "active", "used", "expried"]
    static let VOUCHER_DETAIL_TAB = ["information", "applied_stores", "similar_promotions"]
    
    // API load...
    static let MAX_NUM_API_LOAD = 10
    static let MAX_API_LOAD_SECOND = DispatchTimeInterval.seconds(5)
    
    // Internal News Type
    struct InternalNewsType {
        static let ALL = 0
        static let BLANK = 1
        static let ANNOUCEMENT = 2
        static let TRAINING = 3
    }
    
    // Comment & React...
    struct ReactType {
        static var LIKE = 0
        static var LOVE = 1
        static var LAUGH = 2
        static var SURPRISE = 3
        static var SAD = 4
        static var ANGER = 5
    }
    
    struct ReactContentType {
        static var VOUCHER = 0
        static var INTERNAL_NEWS = 1
        static var COMMENT = 2
        static var SURVEY = 3
        static var RECOGNIZE = 4
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
    
    // Used Pints History
    struct UsedPointsHistory {
        static let FROMCOMPLIMENT = 0
        static let TOCOMPLIMENT = 1
        static let FROMBENEFIT = 2
        static let TOVOUCHER = 3
    }
    
    // Background Search Bar...
    static let BACKGROUND_SEARCH = [BackgroundSearch(tab: "company_surveys", icon: "chart.bar.xaxis", color: Color.purple, destination: 0),
                                    BackgroundSearch(tab: "employee_information", icon: "home_my_profile", color: Color.white, destination: 1),
                                    BackgroundSearch(tab:  "favorite merchants", icon: "heart.fill", color: Color.red, destination: 2),
                                    BackgroundSearch(tab: "home", icon: "ic_home", color: Color.white, destination: 3),
                                    BackgroundSearch(tab: "internal_news", icon: "newspaper.fill", color: Color.green, destination: 4),
                                    BackgroundSearch(tab: "list_of_your_benefits", icon: "list.number", color: Color.blue, destination: 5),
                                    BackgroundSearch(tab: "merchant_voucher_list", icon: "cart.fill", color: Color.blue, destination: 6),
                                    BackgroundSearch(tab: "my_vouchers", icon: "ic_my_voucher", color: Color.white, destination: 7),
                                    BackgroundSearch(tab: "recognize", icon: "star.fill", color: Color.yellow, destination: 8),
                                    BackgroundSearch(tab: "recognize_ranking", icon: "ic_medal_gold", color: Color.white, destination: 9),
                                    BackgroundSearch(tab: "used_points_history", icon: "clock.arrow.circlepath", color: Color.gray, destination: 10)]
    
}

struct BackgroundSearch {
    var tab: String
    var icon: String
    var color: Color
    var destination: Int
}
