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
    
    private let checkBenefitService: CheckBenefitService
    
    init(benefit: BenefitData) {
        self.checkBenefitService = CheckBenefitService(benefitId: benefit.id)
        self.benefit = benefit
        initApplyStatus()
    }
    
    func initApplyStatus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.applyStatus = self.checkBenefitService.status
        }
    }
}

