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
    @Published var content: String = ""
    @Published var isLoading: Bool = false
    @Published var error: AppError = .none
    
    private var faqPolicyService = FAQPolicyService()
    
    func loadData(docType: Constants.DocumentType) {
        
        self.isLoading = true
        
        faqPolicyService.request(docType: docType.rawValue, completion: { response in
            self.isLoading = false
            switch response {
            case .success(let value):
                self.content = value.result?.content ?? ""
            case .failure(let error):
                self.error = error
            }
        })
    }
    
    func getTitle(docType: Constants.DocumentType) -> String {
        if docType == Constants.DocumentType.FAQ {
            return "faq".localized
        } else {
            return "policy".localized
        }
    }
}


