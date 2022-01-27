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
    @Published var isLoading: Bool = true
    @Published var docType: Int = 0
    
    private var faqPolicyService = FAQPolicyService()
    private let currentLang = Constants.LANGUAGE_CODE[UserDefaults.standard.integer(forKey: "language")]
    
    init(docType: Int) {
        self.docType = docType
        loadData()
    }
    
    func loadData() {
        
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
    
    func getTitle() -> String {
        if docType == Constants.DocumentType.FAQ {
            return "faq".localized
        } else {
            return "policy".localized
        }
    }
}


