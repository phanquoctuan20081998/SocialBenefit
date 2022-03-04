//
//  UserViewModel.swift
//  Social Benefit
//
//  Created by Admin on 11/11/21.
//

import Foundation

class UserViewModel: ObservableObject, Identifiable {
    @Published var showFAQ = Constants.showFAQ
    @Published var showPolicy = Constants.showPolicy
    
    var sessionExpired: SessionExpired
    
    init() {
        sessionExpired = SessionExpired.shared
    }
    
    func logout() {
        sessionExpired.isExpried = true
    }
    
    func isDisplayFAQ() {
        FAQPolicyService().request(docType: Constants.DocumentType.FAQ.rawValue) { response in
            switch response {
            case .success(let value):
                self.showFAQ = value.hasContent
                Constants.showFAQ = value.hasContent
            case .failure(_):
                break
            }
        }
    }
    
    func isDisplayPolicy() {
        
        FAQPolicyService().request(docType: Constants.DocumentType.PolicyTerm.rawValue) { response in
            switch response {
            case .success(let value):
                self.showPolicy = value.hasContent
                Constants.showPolicy = value.hasContent
            case .failure(_):
                break
            }
        }
    }
}
