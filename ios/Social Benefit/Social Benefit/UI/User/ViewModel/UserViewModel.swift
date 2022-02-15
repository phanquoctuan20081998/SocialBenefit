//
//  UserViewModel.swift
//  Social Benefit
//
//  Created by Admin on 11/11/21.
//

import Foundation


class UserViewModel: ObservableObject, Identifiable {    
    var sessionExpired: SessionExpired
    
    init() {
        sessionExpired = SessionExpired.shared
    }
    
    func logout() {
        sessionExpired.isExpried = true
    }
}
