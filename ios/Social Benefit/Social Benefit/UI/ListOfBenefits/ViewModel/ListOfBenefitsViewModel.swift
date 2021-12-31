//
//  ListOfBenefitsViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/09/2021.
//

import Foundation

class ListOfBenefitsViewModel: ObservableObject, Identifiable {
    
    @Published var listOfBenefits = [BenefitData]()
    
    @Published var isLoading: Bool = false
    @Published var isPresentApplyPopUp: Bool = false
    
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    var listOfBenefitsService = ListOfBenefitsService()
    
    init() {
        loadData()
    }
    
    func loadData() {
        self.isLoading = true
        listOfBenefitsService.getAPI { data in
            
            DispatchQueue.main.async {
                self.listOfBenefits = data
                self.isLoading = false
                self.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        self.loadData()
    }
    
}
