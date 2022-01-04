//
//  NotificationViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/12/2021.
//

import Combine
import SwiftUI

class NotificationViewModel: ObservableObject, Identifiable {
    
    @ObservedObject var benefitDetailViewModel = BenefitDetailViewModel()
    @ObservedObject var listOfBenefitsViewModel = ListOfBenefitsViewModel()
    
    @Published var allNotificationItems = [NotificationItemData]()
    @Published var fromIndex: Int = 0
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    @Published var destinationView: AnyView = AnyView(EmptyView())
    
    private var internalNewsDetailService = InternalNewsDetailService()
    private var checkBenefitService = CheckBenefitService()
    private var notificationListService = NotificationListService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        loadNotificationItemsData(fromIndex: 0)
    }
    
    private func addSubscribers() {
        
    }
    
    private func loadNotificationItemsData(fromIndex: Int) {
        self.isLoading = true
        
        notificationListService.getAPI(nextPageIndex: fromIndex, pageSize: 10) { [weak self] data in
            
            DispatchQueue.main.async {
                self?.allNotificationItems = data
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    
    public func refresh() {
        DispatchQueue.main.async {
            self.notificationListService.getAPI(nextPageIndex: self.fromIndex, pageSize: 10) { [weak self] data in
                
                DispatchQueue.main.async {
                    self?.allNotificationItems = data
                    self?.isRefreshing = false
                }
            }
        }
    }
    
    public func reloadData() {
        self.isLoading = true
        
        notificationListService.getAPI(nextPageIndex: fromIndex, pageSize: 10) { [weak self] data in
            DispatchQueue.main.async {
                for item in data {
                    self?.allNotificationItems.append(item)
                }
                
                self?.isLoading = false
                self?.isRefreshing = false
            }
        }
    }
    

    
    func changeDesitionationView(notificationItem: NotificationItemData) {
        switch notificationItem.getType() {
        case Constants.NotificationLogType.NOTIFICATION_HR: do {
            
        }
        case Constants.NotificationLogType.SURVEY: do {
            
        }
        case Constants.NotificationLogType.COMMENT: do {
            //Call API
            internalNewsDetailService.getAPI(internalNewsId: notificationItem.getTypeId()) { data in
                DispatchQueue.main.async {
                    self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                }
            }
        }
        case Constants.NotificationLogType.COMMENT_RECOGNITION: do {
            
        }
        case Constants.NotificationLogType.BENEFIT: do {
            
            //Call API
            checkBenefitService.getAPI(benefitId: notificationItem.getTypeId()) { error, data in
                self.benefitDetailViewModel.getData(benefit: data, index: 0)
                self.destinationView = AnyView(BenefitDetailView()
                                                .environmentObject(self.benefitDetailViewModel)
                                                .environmentObject(self.listOfBenefitsViewModel))
            }
        }
        case Constants.NotificationLogType.RECOGNIZE: do {
            
        }
        case Constants.NotificationLogType.SYSTEM: do {
           
        }
        case Constants.NotificationLogType.INTERNAL_NEWS: do {
            //Call API
            internalNewsDetailService.getAPI(internalNewsId: notificationItem.getTypeId()) { data in
                DispatchQueue.main.async {
                    self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                }
            }
        }
        case Constants.NotificationLogType.BENEFIT_REQUEST: do {
            //Call API
            checkBenefitService.getAPI(benefitId: notificationItem.getTypeId()) { error, data in
                self.benefitDetailViewModel.getData(benefit: data, index: 0)
                self.destinationView = AnyView(BenefitDetailView()
                                                .environmentObject(self.benefitDetailViewModel)
                                                .environmentObject(self.listOfBenefitsViewModel))
            }
        }
        case Constants.NotificationLogType.BENEFIT_APPROVE: do {
            //Call API
            checkBenefitService.getAPI(benefitId: notificationItem.getTypeId()) { error, data in
                self.benefitDetailViewModel.getData(benefit: data, index: 0)
                self.destinationView = AnyView(BenefitDetailView()
                                                .environmentObject(self.benefitDetailViewModel)
                                                .environmentObject(self.listOfBenefitsViewModel))
            }
        }
        case Constants.NotificationLogType.SURVEY_REMIND: do {
            
        }
        case Constants.NotificationLogType.REACT_RECOGNITION: do {
            
        }
        case Constants.NotificationLogType.VOUCHER_REMIND: do {
            
        }
        case Constants.NotificationLogType.VOUCHER_EXPIRED: do {
            
        }
        case Constants.NotificationLogType.NEW_VOUCHER: do {
           
        }
            
        default: do { }
        }
    }
}


