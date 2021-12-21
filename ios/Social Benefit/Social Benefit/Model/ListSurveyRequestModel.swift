//
//  ListSurveyRequestModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/11/2021.
//

import Foundation

struct ListSurveyRequestModel: APIModelProtocol {
    var companyId = userInfor.companyId
    let keyword: String
    let flag: Int
    var fromIndex = 0
    init(keyword: String, flag: Int) {
        self.keyword = keyword
        self.flag = flag
    }
    
}
