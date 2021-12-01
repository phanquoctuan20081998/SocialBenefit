//
//  EmployeeRankingViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 01/12/2021.
//

import Foundation
import Combine

class EmployeeRankingViewModel: ObservableObject, Identifiable {
    @Published var employeeInfor = UserInfor(userId: "23546548489", employeeId: "", token: "", companyId: "123", name: "Bé khoẻ", avatar: "/files/558/pokemon_PNG73.png", position: "", nickname: "", email: "", phone: "", noStreet: "", ward: "", district: "", city: "", address: "", birthday: Date(), gender: "", CMND: "", passport: "", insurance: "", department: "Truyền thông", isLeader: true, companyLogo: "", citizenId: "", locationId: "")
    
    @Published var employeeRank = RankingOfRecognitionData.sampleData[0]
    
    @Published var employeeId: Int = 0
    
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
    
    func refresh() {
        
    }
}
