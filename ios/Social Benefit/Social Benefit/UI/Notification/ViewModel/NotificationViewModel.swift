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
    private let recognitionService = RecognitionService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
        loadNotificationItemsData(fromIndex: 0)
    }
    
    private func addSubscribers() {
        
    }
    
    public func loadNotificationItemsData(fromIndex: Int) {
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
    
    public func isMoveToNextPage(notificationItem: NotificationItemData) -> Bool {
        let type = notificationItem.getType()
        
        if (type == Constants.NotificationLogType.NOTIFICATION_HR) ||
            (type == Constants.NotificationLogType.SYSTEM) {
            return false
        }
        
        if (type == Constants.NotificationLogType.COMMENT ||
            type == Constants.NotificationLogType.REACT_COMMENT) {
            
            let cmtType = Int(notificationItem.getContentParams()[2]) ?? 0
            
            if (cmtType != Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS &&
                cmtType != Constants.CommentContentType.COMMENT_TYPE_SURVEY &&
                cmtType != Constants.CommentContentType.COMMENT_TYPE_RECOGNITION) {
                return false
            }
        }
        
        return true
    }
    
    public func changeDesitionationView(notificationItem: NotificationItemData) {
        switch notificationItem.getType() {
        case Constants.NotificationLogType.NOTIFICATION_HR: do {
            // Not moving anywhere
        }
        case Constants.NotificationLogType.SURVEY: do {
            DispatchQueue.main.async {
                self.destinationView = AnyView(SurveyDetailView(contentId: notificationItem.getTypeId()))
            }
        }
        case Constants.NotificationLogType.COMMENT: do {
            switch Int(notificationItem.getContentParams()[2]) ?? 0 {
            case Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS: do {
                internalNewsDetailService.getAPI(internalNewsId: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                    }
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_COMMENT: do {
                internalNewsDetailService.getAPI(internalNewsId: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                    }
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_SURVEY: do {
                DispatchQueue.main.async {
                    let id = Int(notificationItem.getContentParams()[3]) ?? 0
                    self.destinationView = AnyView(SurveyDetailView.init(contentId: id))
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_RECOGNITION: do {
                recognitionService.getPostReaction(id: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(RecognitionPostView(companyData: data))
                    }
                }
            }
            default: do { }
            }
            
            //Call API
            
        }
            
        case Constants.NotificationLogType.COMMENT_RECOGNITION: do {
            recognitionService.getPostReaction(id: Int(notificationItem.getContentParams()[1]) ?? 0) { data in
                DispatchQueue.main.async {
                    self.destinationView = AnyView(RecognitionPostView(companyData: data))
                }
            }
        }
            
        case Constants.NotificationLogType.BENEFIT: do {
            
            //Call API
            checkBenefitService.getAPI(benefitId: notificationItem.getTypeId()) { error, data in
                DispatchQueue.main.async {
                    self.benefitDetailViewModel.getData(benefit: data, index: 0)
                    self.destinationView = AnyView(BenefitDetailView()
                                                    .environmentObject(self.benefitDetailViewModel)
                                                    .environmentObject(self.listOfBenefitsViewModel))
                }
            }
        }
            
        case Constants.NotificationLogType.RECOGNIZE: do {
            recognitionService.getPostReaction(id: notificationItem.getTypeId()) { data in
                DispatchQueue.main.async {
                    self.destinationView = AnyView(RecognitionPostView(companyData: data))
                }
            }
        }
            
        case Constants.NotificationLogType.SYSTEM: do {
           
        }
            
        case Constants.NotificationLogType.INTERNAL_NEWS: do {
            //Call API
            internalNewsDetailService.getAPI(internalNewsId: notificationItem.getTypeId()) { data in
                DispatchQueue.main.async {
                    self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
//                    self.isNotLazyLoading = true
                }
            }
        }
            
        case Constants.NotificationLogType.BENEFIT_REQUEST: do {
            //Call API
            checkBenefitService.getAPI(benefitId: notificationItem.getTypeId()) { error, data in
                DispatchQueue.main.async {
                    self.benefitDetailViewModel.getData(benefit: data, index: 0)
                    self.destinationView = AnyView(BenefitDetailView()
                                                    .environmentObject(self.benefitDetailViewModel)
                                                    .environmentObject(self.listOfBenefitsViewModel))
                }
            }
        }
            
        case Constants.NotificationLogType.BENEFIT_APPROVE: do {
            //Call API
            checkBenefitService.getAPI(benefitId: notificationItem.getTypeId()) { error, data in
                DispatchQueue.main.async {
                    self.benefitDetailViewModel.getData(benefit: data, index: 0)
                    self.destinationView = AnyView(BenefitDetailView()
                                                    .environmentObject(self.benefitDetailViewModel)
                                                    .environmentObject(self.listOfBenefitsViewModel))
                }
            }
        }
            
        case Constants.NotificationLogType.SURVEY_REMIND: do {
            DispatchQueue.main.async {
                self.destinationView = AnyView(SurveyDetailView(contentId: notificationItem.getTypeId()))
            }
        }
            
        case Constants.NotificationLogType.REACT_RECOGNITION: do {
            recognitionService.getPostReaction(id: Int(notificationItem.getContentParams()[1]) ?? 0) { data in
                DispatchQueue.main.async {
                    self.destinationView = AnyView(RecognitionPostView(companyData: data))
                }
            }
        }
            
        case Constants.NotificationLogType.VOUCHER_REMIND: do {
            DispatchQueue.main.async {
                self.destinationView = AnyView(MyVoucherView())
                self.isNotLazyLoading = true
            }
        }
        case Constants.NotificationLogType.VOUCHER_EXPIRED: do {
            
        }
            
        case Constants.NotificationLogType.NEW_VOUCHER: do {
           
        }
            
        case Constants.NotificationLogType.REACT_COMMENT: do {
            switch Int(notificationItem.getContentParams()[2]) ?? 0 {
            case Constants.CommentContentType.COMMENT_TYPE_INTERNAL_NEWS: do {
                internalNewsDetailService.getAPI(internalNewsId: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                    }
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_COMMENT: do {
                internalNewsDetailService.getAPI(internalNewsId: Int(notificationItem.getContentParams()[3]) ?? 0) { data in
                    DispatchQueue.main.async {
                        self.destinationView = AnyView(InternalNewsDetailView(internalNewData: data))
                    }
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_SURVEY: do {
                DispatchQueue.main.async {
                    let id = Int(notificationItem.getContentParams()[3]) ?? 0
                    self.destinationView = AnyView(SurveyDetailView.init(contentId: id))
                }
            }
            case Constants.CommentContentType.COMMENT_TYPE_RECOGNITION: do {
                
            }
            default: do {
                
            }
            }
        }
            
        default: do { }
        }
    }
}


