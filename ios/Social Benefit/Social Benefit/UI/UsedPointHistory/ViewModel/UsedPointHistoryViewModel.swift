//
//  UsedPointHistoryViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/11/2021.
//

import Foundation
import Combine

class UsedPointHistoryViewModel: ObservableObject, Identifiable {
    @Published var searchText = ""
    @Published var isSearch = false
    @Published var selectedTab = 0
    @Published var fromIndex: Int = 0
    @Published var usedPointsHistoryData = UsedPointsHistoryData(id: 1, mDate: "3rd March 2021", mTime: "20:23", mAction: 0, mDestination: "AAA", mPoint: 100)
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var usedPointsHistoryService = UsedPointHistoryService()
    private var cancellables = Set<AnyCancellable>()
    
    func loadData() {
        self.isLoading = true
        usedPointsHistoryService.getAPI(pointActionType: self.selectedTab, searchPattern: self.searchText, fromIndex: self.fromIndex) { [weak self] data in
            DispatchQueue.main.async {
                self?.usedPointsHistoryData = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData()
        }
    }
}
