//
//  FAQPolicyViewModel.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 27/01/2022.
//

import Foundation
import SwiftUI

class FAQPolicyViewModel: ObservableObject, Identifiable {
    
    @Published var isPresentError: Bool = false
    @Published var error: String = ""
    @Published var content: String = ""
    @Published var isLoading: Bool = false
    
    private var faqPolicyService = FAQPolicyService()
    private let currentLang = Constants.LANGUAGE_CODE[UserDefaults.standard.integer(forKey: "language")]
    
    func loadData(docType: Int) {
        
        self.isLoading = true
        
        FAQPolicyService().getAPI(docType: docType, lang_code: currentLang) { data in
            DispatchQueue.main.async {
                let errors = data["errors"].string ?? ""
                
                if !errors.isEmpty {
                    self.error = errors
                    self.isPresentError = true
                } else {
                    self.content = data["content"].string ?? ""
                }
                
                self.isLoading = false
            }
        }
    }
    
    func getTitle(docType: Int) -> String {
        if docType == Constants.DocumentType.FAQ {
            return "raq".localized
        } else {
            return "policy".localized
        }
    }
}


