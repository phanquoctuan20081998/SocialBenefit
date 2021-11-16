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
    
    var sameDateGroup = [Int]() // Count number of transaction in the same day
    var dateHistoryName = [String]() // Store date history name
    
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
        loadData()
    }
    
    func loadData() {
        self.isLoading = true
        usedPointsHistoryService.getAPI(pointActionType: self.selectedTab, searchPattern: self.searchText, fromIndex: self.fromIndex) { [weak self] data in
            print(data)
            DispatchQueue.main.async {
                self?.allUsedPointsHistoryData = data
                self?.countData()
                self?.getDateHistoryName()
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func countData() {
        
        if self.allUsedPointsHistoryData.count == 1 {
            self.sameDateGroup.append(1)
        } else {
            
            self.sameDateGroup.append(0)
            
            for i in 1..<self.allUsedPointsHistoryData.count {
                if self.allUsedPointsHistoryData[i].mDate != self.allUsedPointsHistoryData[i - 1].mDate {
                    self.sameDateGroup.append(i)
                }
            }
        }
    }
    
    func getDateHistoryName() {
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let yesterday = Calendar.current.dateComponents([.year, .month, .day], from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        
        let todayEnglishFormat = convertToEnglishFormat(day: today.day, month: today.month, year: today.year)
        let yesterdayEnglishFormat = convertToEnglishFormat(day: yesterday.day, month: yesterday.month, year: yesterday.year)
        
        var index = 0
        for i in 0 ..< self.sameDateGroup.count {
            if self.allUsedPointsHistoryData[index].mDate == todayEnglishFormat {
                self.dateHistoryName.append("today")
            } else if self.allUsedPointsHistoryData[index].mDate == yesterdayEnglishFormat {
                self.dateHistoryName.append("yesterday")
            } else {
                self.dateHistoryName.append(self.allUsedPointsHistoryData[index].mDate)
            }
            index = self.sameDateGroup[i]
        }
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData()
        }
    }
}
