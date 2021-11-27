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
    @Published var allCompanyList = [RecognitionData]()
    //    @Published var allCompanyList = RecognitionData.sampleData
    @Published var top3Recognition = [UserInfor]()
    @Published var myRank: Int = 0
    @Published var selectedTab: Int = 0
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    var header = ["all", "your_history"]
    
    private var recognitionService = RecognitionService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMyRank()
        loadTop3Recognition()
        loadData(fromIndex: self.fromIndex)
        addsubscribers()
    }
    
    func addsubscribers() {
        $selectedTab
            .sink(receiveValue: loadSelectedTab(selectedTab:))
            .store(in: &cancellables)
    }
    
    func loadData(fromIndex: Int) {
        self.isLoading = true
        
        if selectedTab == 0 {
            recognitionService.getListByCompany(fromIndex: fromIndex) { [weak self] data in
                DispatchQueue.main.async {
                    self?.allCompanyList = data
                    
                    self?.isLoading = false
                    self?.isRefreshing = false
                }
            }
        } else {
            recognitionService.getListByEmployee(fromIndex: fromIndex) { [weak self] data in
                DispatchQueue.main.async {
                    self?.allCompanyList = data
                    
                    self?.isLoading = false
                    self?.isRefreshing = false
                }
            }
        }
    }
    
    func loadTop3Recognition() {
        self.isLoading = true
        recognitionService.getTop3Recognition { [weak self] data in
            DispatchQueue.main.async {
                self?.top3Recognition = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadMyRank() {
        self.isLoading = true
        recognitionService.getMyRank { [weak self] myRank in
            DispatchQueue.main.async {
                self?.myRank = myRank
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadSelectedTab(selectedTab: Int) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadData(fromIndex: 0)
        }
    }
    
    func refresh() {
        loadData(fromIndex: 0)
        loadMyRank()
        loadTop3Recognition()
    }
    
    func reloadData() {
        loadData(fromIndex: fromIndex)
        loadMyRank()
        loadTop3Recognition()
    }
}
