//
//  HomeScreenViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import Foundation

class HomeScreenViewModel: ObservableObject, Identifiable {
    @Published var selectedTab = "house"
    @Published var isPresentedError = false
    @Published var isPresentedTabBar = true
    @Published var isPresentedSearchView = false
    @Published var isPresentOtherPopUp = false
    
    private let faqService = FAQPolicyService()
    private let policyService = FAQPolicyService()
    
    init() {
        requestFaqPolicy()
    }
    
    func requestFaqPolicy() {
        faqService.request(docType: Constants.DocumentType.FAQ.rawValue) { response in
            switch response {
            case .success(let value):
                Constants.showFAQ = value.hasContent
            case .failure(_):
                break
            }
        }
        
        policyService.request(docType: Constants.DocumentType.PolicyTerm.rawValue) { response in
            switch response {
            case .success(let value):
                Constants.showPolicy = value.hasContent
            case .failure(_):
                break
            }
        }
    }
    
}
