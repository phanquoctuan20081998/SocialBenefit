//
//  BenefitDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/09/2021.
//

import Foundation

class BenefitDetailViewModel: ObservableObject, Identifiable {
    
    @Published var applyStatus = -1
    @Published var isPresentedPopup: Bool = false
    @Published var benefit: BenefitData
    
    private let checkBenefitService = CheckBenefitService()
    
    init(benefit: BenefitData) {
        self.benefit = benefit
        initApplyStatus()
    }
    
    func initApplyStatus() {
        checkBenefitService.getAPI(benefitId: benefit.id) { data in
            DispatchQueue.main.async {
                self.applyStatus = data
            }
        }
    }
}

