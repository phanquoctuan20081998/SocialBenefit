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
    @Published var walletInfor = WalletInforData()
    @Published var allTransfersList = [UserData]()
    @Published var allUserList = [UserData]()
    
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
    @Published var isPresentSendConfirmPopUp = false
    @Published var isSendPointSuccess = false
    
    // Control search bar
    @Published var isSearching: Bool = false
    @Published var searchText: String = ""
    
    // Control error
    @Published var isPresentError: Bool = false
    @Published var errorText: String = ""
    
    @Published var isPresentWarning: Bool = false
    @Published var warningText: String = ""
    
    @Published var isUserEmpty: Bool = false
    @Published var isPointEmpty: Bool = false
    @Published var isWishEmpty: Bool = false
    
    // Control switching between company and personal budget
    // Only for point manager
    @Published var selectedTab: Int = 0
    @Published var pointTransaction = [PointTransactionRequestData]()
    
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
            if !userInfor.isLeader {
                self.selectedTab = 1
            }
        }
    }
    
    struct Tab {
        static let COMPANY = 0
        static let PERSONAL = 1
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
        
        $selectedTab
            .sink(receiveValue: updateSelectedTab(selectedTab:))
            .store(in: &cancellables)
    }
    
    func loadWalletInfor() {
        self.isLoading = true
        
        walletInforService.getAPI { [weak self] data in
            
            DispatchQueue.main.async {
                self?.walletInfor = data
                
                self?.companyPoint = data.getCompanyPoint()
                self?.personalPoint = data.getPersonalPoint()
                
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
                
                if self.selectedTab == Tab.COMPANY {
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
    
    func reversePoint(selectedTab: Int) {
        let point = pointInt.reduce(0, +)
        
        DispatchQueue.main.async {
            if selectedTab == Tab.COMPANY {
                self.personalPoint += point
            } else {
                self.companyPoint += point
            }
        }
    }
    
    func updateSelectedTab(selectedTab: Int) {
        self.updatePoint(pointTextArray: pointText)
        self.reversePoint(selectedTab: selectedTab)
    }
    
    func isUserInUserList(user: UserData) -> Bool {
        return self.allSelectedUser.contains(where: { $0.getId() == user.getId() })
    }
    
    func sendButtonClick() {
        var pointTransaction = [PointTransactionRequestData]()
        
        for i in 0..<self.allSelectedUser.count {
            
            if allSelectedUser[i].getId() == -1 || wishesText[i].isEmpty || pointText[i].isEmpty {
                if allSelectedUser[i].getId() == -1 { self.isUserEmpty = true }
                if wishesText[i].isEmpty { self.isWishEmpty = true }
                if pointText[i].isEmpty { self.isPointEmpty = true }
                
                return
            }
            
            pointTransaction.append(PointTransactionRequestData(employeeId: allSelectedUser[i].getId(), point: pointInt[i], message: wishesText[i]))
            
        }
        
        Utils.dismissKeyboard()
        self.pointTransaction = pointTransaction
        self.isPresentSendConfirmPopUp = true
    }
    
    func sendPoint() {
        let pointType = selectedTab == Tab.COMPANY ? 1: 2
        
        self.sendRecognitionService.getAPI(pointType: pointType, walletInfor: walletInfor, pointTransactions: pointTransaction) { point, error in
            DispatchQueue.main.async {
                if !error.isEmpty {
                    self.isPresentError = true
                    self.errorText = error
                } else {
                    self.loadWalletInfor()
                    self.isSendPointSuccess = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.resetViewModel()
                    }
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
                self.removeTextControl(index: i)
                
                self.allSelectedUser[i] = UserData()
                self.selectedUserIndex = 0
                self.isAddMoreClick = false
                self.realCount = 0
                
                self.isModified = false
            }
        }
    }
    
    func resetError() {
        self.isUserEmpty = false
        self.isPointEmpty = false
        self.isWishEmpty = false
    }
}
