//
//  BenefitDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/09/2021.
//

import Foundation

class BenefitDetailViewModel: ObservableObject, Identifiable {
    
    @Published var applyStatus = -1
    @Published var typeMember = -1
    @Published var isPresentedPopup: Bool = false
    @Published var benefit: BenefitData = BenefitData()
    @Published var index: Int = -1
    
    
    // Control error
    @Published var isPresentError: Bool = false
    @Published var errorCode: String = ""
    
    private let checkBenefitService = CheckBenefitService()
    
    func getData(benefit: BenefitData, index: Int) {
        self.benefit = benefit
        self.index = index
        initApplyStatus()
    }
    
    func initApplyStatus() {
        checkBenefitService.getAPI(benefitId: benefit.id) { error, data  in
            DispatchQueue.main.async {
                if error.isEmpty {
                    self.applyStatus = data.status
                    self.typeMember = data.typeMember
                } else if error == MessageID.C00189_E {
                    self.applyStatus = 4 // Assign button to pending
                } else {
                    self.isPresentError = true
                    self.errorCode = error
                }
            }
        }
    }
}

