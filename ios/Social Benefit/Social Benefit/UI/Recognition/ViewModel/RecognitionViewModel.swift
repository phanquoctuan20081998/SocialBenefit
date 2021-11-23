//
//  RecognitionViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/11/2021.
//

import Foundation
import Combine

class RecognitionViewModel: ObservableObject, Identifiable {
    @Published var fromIndex: Int = 0
    @Published var allCompanyList = RecognitionData.sampleData
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var recognitionService = RecognitionService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData(fromIndex: self.fromIndex)
    }
    
    func loadData(fromIndex: Int) {
        self.isLoading = true
        recognitionService.getListCompany(fromIndex: fromIndex) { [weak self] data in
            DispatchQueue.main.async {
                self?.allCompanyList = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        
    }
}
