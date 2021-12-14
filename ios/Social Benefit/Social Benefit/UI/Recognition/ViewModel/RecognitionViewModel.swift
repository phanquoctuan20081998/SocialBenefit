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
    @Published var allRecognitionPost = [RecognitionData]()
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
    
    // For display date
    @Published var sameDateGroup = [SeparateByDateData]()
    
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
                    self?.allRecognitionPost = data
                    
                    self?.isLoading = false
                    self?.isRefreshing = false
                }
            }
        } else {
            recognitionService.getListByEmployee(employeeId: userInfor.employeeId, fromIndex: fromIndex) { [weak self] data in
                DispatchQueue.main.async {
                    self?.allRecognitionPost = data
                    
                    self?.isLoading = false
                    self?.isRefreshing = false
                }
            }
        }
        
        countData()
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
    
    func countData() {
        
        // Convert to only time array...
        var timeArray = [String]()
        for data in self.allRecognitionPost {
            timeArray.append(data.getDate())
        }
        
        self.sameDateGroup = FindNewsFeedHaveSameDateFirstIndex(timeArray: timeArray)
        
    }
    
    func loadSelectedTab(selectedTab: Int) {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadData(fromIndex: 0)
        }
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadData(fromIndex: self.fromIndex)
            self.loadMyRank()
            self.loadTop3Recognition()
        }
    }
    
    func reloadData() {
        
        self.isLoading = true
        
        if selectedTab == 0 {
            recognitionService.getListByCompany(fromIndex: fromIndex) { [weak self] data in
                
                DispatchQueue.main.async {
                    for i in data {
                        self?.allRecognitionPost.append(i)
                    }
                    
                    self?.isLoading = false
                    self?.isRefreshing = false
                }
            }
        } else {
            recognitionService.getListByEmployee(employeeId: userInfor.employeeId, fromIndex: fromIndex) { [weak self] data in
                DispatchQueue.main.async {
                    for i in data {
                        self?.allRecognitionPost.append(i)
                    }
                    
                    self?.isLoading = false
                    self?.isRefreshing = false
                }
            }
        }
        
        loadMyRank()
        loadTop3Recognition()
    }
    
    func isNewDate(index: Int) -> Int {
        self.sameDateGroup.firstIndex( where: { $0.head == index } ) ?? -1
    }
    
}
