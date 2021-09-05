//
//  BenefitsModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/08/2021.
//

import Foundation

struct STATUS {
    let ON_GOING = 0 //Display "on going"
    let UP_COMMING = 1 //Display "up comming"
    let RECEIVED = 2//Display tick mark
    let NOT_REGISTER = 3 //Display aplly buton
    let REGISTER = 4//Display "waitting to confirm"
    let APPROVED = 5//
    let REJECTED = 6//Display X
}
    
struct ListOfBenefitData: Identifiable, Hashable {
    var id: Int
    
    var order: String
    var benefit: String
    var applied: Int
}
