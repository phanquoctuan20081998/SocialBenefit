//
//  ListOfBenefitsViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import Foundation

class ListOfBenefitsViewModel: ObservableObject, Identifiable {
    
    @Published var listOfBenefits = [BenefitData]()
    
    var listOfBenefitsService = ListOfBenefitsService()
    
    init() {
        listOfBenefitsService.getAPI { data in
            DispatchQueue.main.async {
                self.listOfBenefits = data
            }
        }
    }
    
    
}
