//
//  EmployeeRankingViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation
import Combine

class EmployeeRankingViewModel: ObservableObject, Identifiable {
    @Published var employeeInfor = userInfor
    @Published var employeeRank = RankingOfRecognitionData.sampleData[0]
    @Published var employeeRecognitionList = RecognitionData.sampleData
    
    @Published var employeeId: Int = 0
    @Published var fromIndex: Int = 0
    @Published var sameDateGroup = [SeparateByDateData]()
    
    // For loading, refresh controller
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var recognitionService = RecognitionService()
    private var employeeInforService = EmployeeInforService()
    
    init(employeeId: Int) {
        self.employeeId = employeeId
        
        self.loadEmployeeInfor(employeeId: employeeId)
        self.loadEmployeeRank(employeeId: employeeId)
        self.loadRecognitionData(employeeId: employeeId, fromIndex: fromIndex)
    }
    
    func loadEmployeeInfor(employeeId: Int) {
        self.isLoading = true
        
        employeeInforService.getAPI(employeeId: employeeId) { [weak self] data in
            
            DispatchQueue.main.async {
                self?.employeeInfor = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadEmployeeRank(employeeId: Int) {
        self.isLoading = true
        
        recognitionService.getEmployeeRank(employeeId: employeeId) { [weak self] data in
            DispatchQueue.main.async {
                self?.employeeRank = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadRecognitionData(employeeId: Int, fromIndex: Int) {
        self.isLoading = true
        let employeeIdString = String(employeeId)
        
        recognitionService.getListByEmployee(employeeId: employeeIdString, fromIndex: fromIndex) { [weak self] data in
            DispatchQueue.main.async {
                
                self?.employeeRecognitionList = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
        
        countData()
    }
    
    func countData() {
        
        // Convert to only time array...
        var timeArray = [String]()
        for data in self.employeeRecognitionList {
            timeArray.append(data.getDate())
        }
        
        self.sameDateGroup = FindNewsFeedHaveSameDateFirstIndex(timeArray: timeArray)
        
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.loadRecognitionData(employeeId: self.employeeId, fromIndex: self.fromIndex)
        }
    }
    
    func reloadData() {
        self.loadRecognitionData(employeeId: employeeId, fromIndex: fromIndex)
    }
    
    func isNewDate(index: Int) -> Int {
        self.sameDateGroup.firstIndex( where: { $0.head == index } ) ?? -1
    }
}
