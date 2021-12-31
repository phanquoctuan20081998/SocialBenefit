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
    @Published var wishesText = [String]()
    @Published var pointText = [String]()
    @Published var pointInt = [Int]()
    
    @Published var allSelectedUser: [UserData] = [UserData()]
    @Published var selectedUserIndex: Int = 0
    @Published var isAddMoreClick: Bool = false
    @Published var realCount: Int = 0
    
    // Control confirm popup
    @Published var isModified = false
    @Published var isPresentConfirmPopUp = false
    
    // Control search bar
    @Published var isSearching: Bool = false
    @Published var searchText: String = ""
    
    // Control error
    @Published var isPresentError: Bool = false
    @Published var errorText: String = ""
    
    @Published var isPresentWarning: Bool = false
    @Published var warningText: String = ""
    
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
        
        self.pointText.append("")
        self.wishesText.append("")
        self.pointInt.append(0)
        
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
            .sink(receiveValue: updatePoint(pointTextArray:))
            .store(in: &cancellables)
        
        $searchText
            .sink(receiveValue: loadSearchText(searchText:))
            .store(in: &cancellables)
        
        $wishesText
            .sink(receiveValue: updateWishes(wishesTextArray:))
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
    
    func updatePoint(pointTextArray: [String]) {
        for i in 0 ..< pointTextArray.count {
            DispatchQueue.main.async {
                if pointTextArray[i].count > 5 {
                    self.pointText[i] = trimStringWithNChar(5, string: pointTextArray[i])
                }
                
                self.pointInt[i] = Int(self.pointText[i]) ?? 0
                
                if self.pointInt[i] != 0 {
                    self.isModified = true
                }
                
                if self.selectedTab == 0 {
                    withAnimation {
                        self.companyPoint = self.walletInfor.getCompanyPoint() - self.pointInt.reduce(0, +)
                        if self.companyPoint < 0 {
                            self.isPresentWarning = true
                            self.warningText = "be_careful_with_your_budget".localized
                        }
                    }
                } else {
                    withAnimation {
                        self.personalPoint = self.walletInfor.getPersonalPoint() - self.pointInt.reduce(0, +)
                        if self.personalPoint < 0 {
                            self.isPresentWarning = true
                            self.warningText = "be_careful_with_your_budget".localized
                        }
                    }
                }
            }
        }
    }
    
    func updateWishes(wishesTextArray: [String]){
        for i in 0 ..< wishesTextArray.count {
            if wishesTextArray[i].count > 500 {
                DispatchQueue.main.async {
                    self.wishesText[i] = trimStringWithNChar(500, string: wishesTextArray[i])
                }
            }
            
            if !wishesTextArray[i].isEmpty {
                DispatchQueue.main.async {
                    self.isModified = true
                }
            }
        }
    }
    
    func isUserInUserList(user: UserData) -> Bool {
        return self.allSelectedUser.contains(where: { $0.getId() == user.getId() })
    }
    
    func sendButtonClick() {
        //        let a = WalletInforData(companyPoint: 0, personalPoint: 0)
        //        let b = [PointTransactionRequestData(employeeId: 136, point: 1, message: "abc")]
        
        let pointType = selectedTab == 0 ? 1: 2
        var pointTransaction = [PointTransactionRequestData]()
        
        for i in 0..<self.allSelectedUser.count {
            
            if allSelectedUser[i].getId() != -1 {
                if wishesText[i].isEmpty {
                    self.isPresentError = true
                    self.errorText = "need_to_fill_wish"
                    
                    return
                }
                
                pointTransaction.append(PointTransactionRequestData(employeeId: allSelectedUser[i].getId(), point: pointInt[i], message: wishesText[i]))
            }
        }
        
        
        
        self.sendRecognitionService.getAPI(pointType: pointType, walletInfor: walletInfor, pointTransactions: pointTransaction) { walletInfor, error in
            if !error.isEmpty {
                DispatchQueue.main.async {
                    self.isPresentError = true
                    self.errorText = error
                }
            }
        }
    }
    
    func addTextControl() {
        self.wishesText.append("")
        self.pointText.append("")
        self.pointInt.append(0)
    }
    
    func removeTextControl(index: Int) {
        self.wishesText[index] = ""
        self.pointText[index] = ""
        self.pointInt[index] = 0
    }
    
    func resetViewModel() {
        DispatchQueue.main.async {
            for i in 0..<self.allSelectedUser.count {
                self.wishesText[i] = ""
                self.pointText[i] = ""
                self.pointInt[i] = 0
                
                self.allSelectedUser[i] = UserData()
                self.selectedUserIndex = 0
                self.isAddMoreClick = false
                self.realCount = 0
                
                self.isModified = false
            }
            
        }
    }
}
