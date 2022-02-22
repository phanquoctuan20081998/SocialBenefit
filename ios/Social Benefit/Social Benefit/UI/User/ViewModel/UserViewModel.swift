//
//  UserViewModel.swift
//  Social Benefit
//
//  Created by Admin on 11/11/21.
//

import Foundation


class UserViewModel: ObservableObject, Identifiable {
    @Published var showFAQ = true
    @Published var showPolicy = true
    
    var sessionExpired: SessionExpired
    
    init() {
        sessionExpired = SessionExpired.shared
        isDisplayFAQ()
        isDisplayPolicy()
    }
    
    func logout() {
        sessionExpired.isExpried = true
    }
    
    func isDisplayFAQ() {
        
        FAQPolicyService().getAPI(docType: Constants.DocumentType.FAQ, lang_code: Constants.LANGUAGE_CODE[UserDefaults.standard.integer(forKey: "language")]) { data in
            
            DispatchQueue.main.async {
                guard let content = data["content"].string else {
                    self.showFAQ = false
                    return
                }
                
                if content.isEmpty {
                    self.showFAQ = false
                } else {
                    self.showFAQ = true
                }
            }
        }
    }
    
    func isDisplayPolicy() {
        
        FAQPolicyService().getAPI(docType: Constants.DocumentType.PolicyTerm, lang_code: Constants.LANGUAGE_CODE[UserDefaults.standard.integer(forKey: "language")]) { data in
            
            DispatchQueue.main.async {
                guard let content = data["content"].string else {
                    self.showPolicy = false
                    return
                }
                
                if content.isEmpty {
                    self.showPolicy = false
                } else {
                    self.showPolicy = true
                }
            }
        }
    }
}
