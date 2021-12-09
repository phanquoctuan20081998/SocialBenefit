//
//  NotiPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import Foundation
import SwiftUI

func getError(errorCode: String) -> String {
    switch errorCode {
    case "M00136_E":
        return "buy_over_error".localized
    case "M00137_E":
        return "not_enough_voucher_error".localized
    case "M00121_E":
        return "not_exist".localized
    case "need_to_fill_all_data":
        return "need_to_fill_all_data".localized
    case "wrong_data":
        return "wrong_data".localized
    case "wrong_email_format":
        return "wrong_email_format".localized
    case "wrong_email":
        return "wrong_email".localized
    case "blank_email":
        return "blank_email".localized
    case "blank_phone":
        return "blank_phone".localized
    case "can_connect_server":
        return "can_connect_server".localized
    case "this_person_is_exist":
        return "this_person_is_exist".localized
    case "C00177_E":
        return "no_point_has_been_tranferred".localized
    case "C00168_E":
        return "not_enough_personal_point".localized
    case "need_to_fill_wish":
        return "need_to_fill_wish".localized
    default:
        return ""
    }
}
