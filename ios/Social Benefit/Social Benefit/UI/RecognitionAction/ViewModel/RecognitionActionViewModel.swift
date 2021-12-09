//
//  RecognitionActionViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 02/12/2021.
//

import Foundation

import Combine
import SwiftUI

class RecognitionActionViewModel: ObservableObject, Identifiable {
    @Published var walletInfor = WalletInforData.sampleData
    @Published var allTransfersList = UserData.sampleData
    @Published var allUserList = UserData.sampleData
    
    @Published var fromIndexTransferList = 0
    @Published var fromIndexUserList = 0
    
    // Control main screen
    @Published var companyPoint = 0
    @Published var personalPoint = 0
    
    @Published var isShowRecentTransferList = true
    @Published var wishesText: String = ""
    @Published var pointText: String = ""
    @Published var isWishesTextFocus: Bool = false
    
    @Published var allSelectedUser: [UserData] = [UserData()]
    @Published var selectedUserIndex: Int = 0
    @Published var isAddMoreClick: Bool = false
    @Published var realCount: Int = 0
    @Published var enterPoint: Int = 0
    
    // Control search bar
    @Published var isSearching: Bool = false
    @Published var searchText: String = ""
    
    // Control error
    @Published var userIsExistError: Bool = false
    @Published var carefullError: Bool = false
    @Published var serverError: Bool = false
    @Published var errorCode: String = ""
    
    // Control switching between company and personal budget
    // Only for point manager
    @Published var selectedTab: Int = 0
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    private var recentTransferService = RecentTransferService()
    private var walletInforService = WalletInforService()
    private var userService = UserService()
    private var sendRecognitionService = SendRecognitionService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addsubscribers()
        loadWalletInfor()
        loadRecentTransferData(fromIndex: 0)
        loadUserData(keyword: "", fromIndex: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.companyPoint = self.walletInfor.getCompanyPoint()
            self.personalPoint = self.walletInfor.getPersonalPoint()
            
            if !userInfor.isLeader {
                self.selectedTab = 1
            }
        }
    }
    
    func addsubscribers() {
        $pointText
            .sink(receiveValue: updatePoint(pointText:))
            .store(in: &cancellables)
        
        $searchText
            .sink(receiveValue: loadSearchText(searchText:))
            .store(in: &cancellables)
        
        $wishesText
            .sink(receiveValue: updateWishes(wishes:))
            .store(in: &cancellables)
    }
    
    func loadWalletInfor() {
        self.isLoading = true
        
        walletInforService.getAPI { [weak self] data in
            
            DispatchQueue.main.async {
                self?.walletInfor = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadRecentTransferData(fromIndex: Int) {
        self.isLoading = true
        
        recentTransferService.getAPI(fromIndex: fromIndex) { [weak self] data in
            
            DispatchQueue.main.async {
                self?.allTransfersList = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadUserData(keyword: String, fromIndex: Int) {
        self.isLoading = true
        
        userService.getAPI(keyword: keyword, fromIndex: fromIndex) { [weak self] data in
            DispatchQueue.main.async {
                self?.allUserList = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func loadSearchText(searchText: String) {
        self.loadUserData(keyword: searchText, fromIndex: 0)
    }
    
    func refresh() {
        loadRecentTransferData(fromIndex: 0)
        loadUserData(keyword: "", fromIndex: 0)
    }
    
    func reloadTransferListData() {
        self.isLoading = true
        
        recentTransferService.getAPI(fromIndex: fromIndexTransferList) { [weak self] data in
            
            DispatchQueue.main.async {
                
                for i in data {
                    self?.allTransfersList.append(i)
                }
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func reloadUserListData() {
        self.isLoading = true
        
        userService.getAPI(keyword: searchText, fromIndex: fromIndexUserList) { [weak self] data in
            DispatchQueue.main.async {
                
                for i in data {
                    self?.allUserList.append(i)
                }
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    func updatePoint(pointText: String) {
        DispatchQueue.main.async {
            if pointText.count > 15 {
                self.pointText = trimStringWithNChar(15, string: pointText)
            }
            
            self.enterPoint = Int(self.pointText) ?? 0
            
            if self.selectedTab == 0 {
                withAnimation {
                    self.companyPoint = self.walletInfor.getCompanyPoint() - self.enterPoint
                    if self.companyPoint < 0 {
                        self.carefullError = true
                    }
                }
            } else {
                withAnimation {
                    self.personalPoint = self.walletInfor.getPersonalPoint() - self.enterPoint
                    if self.personalPoint < 0 {
                        self.carefullError = true
                    }
                }
            }
        }
    }
    
    func updateWishes(wishes: String){
        if wishes.count > 200 {
            DispatchQueue.main.async {
                self.wishesText = trimStringWithNChar(200, string: wishes)
            }
        }
    }
    
    func isUserInUserList(user: UserData) -> Bool {
        return self.allSelectedUser.contains(where: { $0.getId() == user.getId() })
    }
    
    func sendButtonClick() {
//        let a = WalletInforData(companyPoint: 0, personalPoint: 0)
        let b = [PointTransactionRequestData(employeeId: 136, point: 1, message: "abc")]
        
        var pointTransaction = [PointTransactionRequestData]()
        for user in self.allSelectedUser {
//            pointTransaction.append(PointTransactionRequestData(employeeId: user.getId(), point: , message: <#T##String#>))
        }
        
        self.sendRecognitionService.getAPI(pointType: 2, walletInfor: self.walletInfor, pointTransactions: b) { walletInfor, error in
            if !error.isEmpty {
                DispatchQueue.main.async {
                    self.serverError = true
                    self.errorCode = error
                }
            }
        }
    }
}
