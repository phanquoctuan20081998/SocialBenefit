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
    @Published var allUsedPointsHistoryData = [UsedPointsHistoryData]()

    var sameDateGroup = [SeparateByDateData]() // Store the first index of transaction  of each date group
    
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
    
    init() {
        loadData(selectedTab: self.selectedTab, searchPattern: self.searchText, fromIndex: self.fromIndex)
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .sink(receiveValue: loadSearchData(searchText:))
            .store(in: &cancellables)
        
        $selectedTab
            .sink(receiveValue: loadSelectedTab(selectedTab:))
            .store(in: &cancellables)
    }
    
    func loadData(selectedTab: Int, searchPattern: String, fromIndex: Int) {
        self.isLoading = true
        usedPointsHistoryService.getAPI(pointActionType: selectedTab, searchPattern: searchText, fromIndex: fromIndex) { [weak self] data in
            DispatchQueue.main.async {
                self?.allUsedPointsHistoryData = data
                self?.countData()
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func countData() {
        
        // Convert to only time array...
        var timeArray = [String]()
        for data in self.allUsedPointsHistoryData {
            timeArray.append(data.mDate)
        }
        
        self.sameDateGroup = FindNewsFeedHaveSameDateFirstIndex(timeArray: timeArray)
        
    }
    
    func loadSearchData(searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            self.loadData(selectedTab: self.selectedTab, searchPattern: self.searchText, fromIndex: self.fromIndex)
        }
    }
    
    func loadSelectedTab(selectedTab: Int) {
        self.loadData(selectedTab: selectedTab, searchPattern: searchText, fromIndex: fromIndex)
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData(selectedTab: self.selectedTab, searchPattern: self.searchText, fromIndex: self.fromIndex)
        }
    }
    
    func reload() {
        usedPointsHistoryService.getAPI(pointActionType: selectedTab, searchPattern: searchText, fromIndex: fromIndex) { [weak self] data in
            DispatchQueue.main.async {
                for i in data {
                    self?.allUsedPointsHistoryData.append(i)
                }
                self?.countData()
            }
        }
    }
    
    func reset() {
        self.allUsedPointsHistoryData = []
        self.sameDateGroup = []
    }
}
