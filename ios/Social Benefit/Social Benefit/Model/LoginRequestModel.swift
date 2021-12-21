//
//  LoginRequestModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 09/12/2021.
//

import Foundation
import UIKit

struct LoginRequestModel: APIModelProtocol {
    var companyCode: String?
    var userLogin: String?
    var password: String?
    var deviceId = UIDevice.current.identifierForVendor?.uuidString
    var deviceToken = "abc"
    var deviceType = "1"
}
