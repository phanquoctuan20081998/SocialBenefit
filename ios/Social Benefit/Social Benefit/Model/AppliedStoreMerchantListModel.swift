//
//  AppliedStoreMerchantListModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import Foundation

struct AppliedStoreMerchantListData: Identifiable, Hashable {
    var id: Int
    var logo: String
    var fullName: String
    var fullAddress: String
    var hotlines: String
    
    init() {
        id = 0
        logo = ""
        fullName = ""
        fullAddress = ""
        hotlines = ""
    }
    
    init(id: Int, logo: String, fullName: String, fullAddress: String, hotlines: String) {
        self.id = id
        self.logo = logo
        self.fullName = fullName
        self.fullAddress = fullAddress
        self.hotlines = hotlines
    }
}
