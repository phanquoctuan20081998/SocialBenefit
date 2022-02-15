//
//  BenefitDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/09/2021.
//

import Foundation
import SwiftUI

class BenefitDetailViewModel: ObservableObject, Identifiable {
    
    @Published var applyStatus = -1
    @Published var typeMember = -1
    @Published var isPresentedPopup: Bool = false
    @Published var benefit: BenefitData = benefitDataSample
    @Published var index: Int = -1
    
    // Control error
    @Published var isPresentError: Bool = false
    @Published var errorCode: String = ""
    
    @Published var isLoading: Bool = false
    
    private let checkBenefitService = CheckBenefitService()
    private var benefitDetailService = BenefitDetailService(id: 0)
    
    func getData(benefit: BenefitData, index: Int) {
        self.benefit = benefit
        self.index = index
        
        benefitDetailService = BenefitDetailService(id: benefit.id)
        
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
        
        self.isLoading = true
        
        benefitDetailService.getAPI { data in
            DispatchQueue.main.async {
                self.benefit = data
                
                self.isLoading = false
            }
        }
    }
}


let benefitDataSample = BenefitData(id: 0, title: "hsdhjsdb sds sdbfh. sdjks nsdjc  dsjbb dsbdsk. dshb dskb sdb sdbcbd sdbcbcs nn dc sdcj sdnc j dfkn", body: "dsbdsjfsdjhbfhjdsbfhs", logo: "", typeMember: 0, status: 0, mobileStatus: 0, actionTime: "02/02/2022")
