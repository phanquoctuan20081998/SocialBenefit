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
    @Published var readNotificationItems = [NotificationItemData]()
    @Published var fromIndex: Int = 0
    
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false {
        didSet {
            if oldValue == false && isRefreshing == true {
                self.refresh()
            }
        }
    }
    
    @Published var destinationView: AnyView = AnyView(LoadingView().navigationBarHidden(true))
    @Published var isNotLazyLoading: Bool = false
    
    private var internalNewsDetailService = InternalNewsDetailService()
    private var checkBenefitService = CheckBenefitService()
    private var notificationListService = NotificationListService()
    private let surveyGetSerivce = SurveyGetService()
    private let notificationService = NotificationService()
    
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
            print(data)
            DispatchQueue.main.async {
                self?.allNotificationItems = data
                self?.readNotificationItems = data
                
                self?.isLoading = false
                self?.isRefreshing = false
                
                self?.updateReadNotification()
            }
        }
    }
    
    public func refresh() {
        DispatchQueue.main.async {
            self.fromIndex = 0
            self.notificationListService.getAPI(nextPageIndex: self.fromIndex, pageSize: 10) { [weak self] data in
                
                DispatchQueue.main.async {
                    self?.allNotificationItems = data
                    self?.isRefreshing = false
                }
            }
        }
    }
    
    public func reloadData() {
        
        notificationListService.getAPI(nextPageIndex: fromIndex, pageSize: 10) { [weak self] data in
            DispatchQueue.main.async {
                for item in data {
                    self?.allNotificationItems.append(item)
                    self?.readNotificationItems.append(item)
                }
                self?.isRefreshing = false
                self?.updateReadNotification()
            }
        }
    }
    
    public func updateReadNotification() {
        notificationService.getAPI(items: self.readNotificationItems) {
            
        }
    }
    
    public func updateReadNotification(items: [NotificationItemData]) {

        notificationService.getAPI(items: items) {
            
        }
    }
    
    public func changeDesitionationView(notificationItem: NotificationItemData) {
        switch notificationItem.getType() {
        case Constants.NotificationLogType.NOTIFICATION_HR: do {
            
        }
        case Constants.NotificationLogType.SURVEY: do {
            self.destinationView = AnyView(SurveyDetailView(contentId: notificationItem.getTypeId()))
        }
        case Constants.NotificationLogType.COMMENT: do {
            switch Int(notificationItem.getContentParams()[2]) ?? 0 {
            case Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS: do {
                internalNewsDetailService.getAPI(internalNewsId: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                        self.isNotLazyLoading = true
                    }
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_COMMENT: do {
                internalNewsDetailService.getAPI(internalNewsId: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                        self.isNotLazyLoading = true
                    }
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_SURVEY: do {
                let id = Int(notificationItem.getContentParams()[3]) ?? 0
                self.destinationView = AnyView(SurveyDetailView.init(contentId: id))
            }
            case Constants.CommentContentType.COMMENT_TYPE_RECOGNITION: do {
                
            }
            default: do { }
            }
            
            //Call API
            
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
                    self.isNotLazyLoading = true
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
            self.destinationView = AnyView(SurveyDetailView(contentId: notificationItem.getTypeId()))
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


