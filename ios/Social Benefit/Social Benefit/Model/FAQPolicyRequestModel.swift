//
//  FaqPolicyRequestModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 03/03/2022.
//

import Foundation

struct FAQPolicyRequestModel: APIModelProtocol {
    var docType: Int
    var typeTab = Constants.SystemType.Mobile
    var lang_code = UserDefaults.getAppLanguage().code
}
