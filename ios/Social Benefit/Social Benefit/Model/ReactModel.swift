//
//  ReactModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/09/2021.
//

import Foundation

struct ReactData: Identifiable, Hashable {
    var id: Int
    
    var employeeId: Int
    var reactType: Int?
    var name: String
    var avatar: String
}

