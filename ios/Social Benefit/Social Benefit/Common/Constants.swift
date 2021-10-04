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
    static let TABHEADER = ["all", "active", "used", "expried"]
    static let VOUCHER_DETAIL_TAB = ["information", "applied_stores", "similar_promotions"]
    
    // API load...
    static let MAX_NUM_API_LOAD = 10
    
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
    
    static let LANGUAGE_TAB = ["eng", "vn"]
    
    // Change Password Error
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
    
    // Background Search Bar
    static let SEARCH_TAB = ["company_surveys", "employee_information", "favorite merchants", "home", "internal_news",
                             "list_of_your_benefits", "merchant_voucher_list", "my_vouchers", "recognize", "recognize_ranking",
                             "used_points_history"]
    
    static let SEARCH_ICON = ["chart.bar.xaxis", "home_my_profile", "heart.fill", "ic_home", "newspaper.fill", "list.number",
                              "cart.fill", "ic_my_voucher", "star.fill", "ic_medal_gold", "clock.arrow.circlepath"]
    
    static let SEARCH_ICON_COLOR = [Color.purple, Color.white, Color.red, Color.white, Color.green, Color.blue, Color.blue,
                                    Color.white, Color.yellow, Color.white, Color.gray]
}
