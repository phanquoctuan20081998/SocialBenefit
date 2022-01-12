//
//  NotificationCardViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 29/12/2021.
//

import Foundation
import Combine
import SwiftUI

class NotificationCardViewModel: ObservableObject, Identifiable {
    
    @Published var notificationItem = NotificationItemData()
    
    @Published var image: String = ""
    @Published var notiTypeName: String = ""
    @Published var content: String = ""
    @Published var date: String = ""
    @Published var time: String = ""
    @Published var point: String = ""
    
    init(notificationItemData: NotificationItemData) {
        DispatchQueue.main.async {
            self.notificationItem = notificationItemData
        }
        
        loadData()
    }
    
    func loadData() {
        DispatchQueue.main.async {
            self.convertDateTime()
            self.classifyNoti()
            self.getContent()
            self.getPoint()
        }
    }
    
    func convertDateTime() {
        
        let componentDate = getDateElementSince1970(notificationItem.getCreatedTime())
        
        self.date = "\(String(format: "%02d", componentDate.day ?? 0))/\(String(format: "%02d", componentDate.month ?? 0))/\(componentDate.year ?? 0)"
        self.date = getDateSinceToday(time: self.date).localized
        
        self.time = "\(String(format: "%02d", componentDate.hour ?? 0)):\(String(format: "%02d", componentDate.minute ?? 0))"
    }
    
    func getContent() {
        if self.notificationItem.getContentParams().isEmpty {
            self.content = "<b>\(self.notiTypeName)</b>: \(self.notificationItem.getContent())"
        } else if self.notificationItem.getContentParams().count == 1 {
            self.content = "<b>\(self.notiTypeName)</b>: \(self.notificationItem.getContent().localizeWithFormat(arguments: self.notificationItem.getContentParams()[0]))"
        } else {
            self.content = "<b>\(self.notiTypeName)</b>: \(self.notificationItem.getContent().localizeWithFormat(arguments: self.notificationItem.getContentParams()[0], self.notificationItem.getContentParams()[1]))"
        }
    }
    
    func getPoint() {
        if self.notificationItem.getPoint() > 0 {
            self.point = "+" + String(notificationItem.getPoint())
        } else if self.notificationItem.getPoint() < 0 {
            self.point = String(notificationItem.getPoint())
        }
    }
    
    func classifyNoti() {
        switch notificationItem.getType() {
        case Constants.NotificationLogType.NOTIFICATION_HR: do {
            self.image = "notify_hr"
            self.notiTypeName = "annoucement".localized
        }
        case Constants.NotificationLogType.SURVEY: do {
            self.image = "notify_survey"
            self.notiTypeName = "survey".localized
        }
        case Constants.NotificationLogType.COMMENT: do {
            self.image = Config.baseURL + self.notificationItem.getImgURL()
            self.notiTypeName = "annoucement".localized
        }
        case Constants.NotificationLogType.COMMENT_RECOGNITION: do {
            self.image = "notify_hr"
            self.notiTypeName = "annoucement".localized
        }
        case Constants.NotificationLogType.BENEFIT: do {
            self.image = "notify_benefit"
            self.notiTypeName = "benefit".localized
        }
        case Constants.NotificationLogType.RECOGNIZE: do {
            self.image = "notify_avatar"
            self.notiTypeName = "recognition".localized
        }
        case Constants.NotificationLogType.SYSTEM: do {
            self.image = "notify_system"
            self.notiTypeName = "system".localized
        }
        case Constants.NotificationLogType.INTERNAL_NEWS: do {
            self.image = "notify_hr"
            self.notiTypeName = "internal_news".localized
        }
        case Constants.NotificationLogType.BENEFIT_REQUEST: do {
            self.image = "notify_benefit"
            self.notiTypeName = "benefit".localized
        }
        case Constants.NotificationLogType.BENEFIT_APPROVE: do {
            self.image = "notify_benefit"
            self.notiTypeName = "new_benefit".localized
        }
        case Constants.NotificationLogType.SURVEY_REMIND: do {
            self.image = "notify_survey"
            self.notiTypeName = "survey".localized
        }
        case Constants.NotificationLogType.REACT_RECOGNITION: do {
            self.image = "notify_hr"
            self.notiTypeName = "react".localized
        }
        case Constants.NotificationLogType.VOUCHER_REMIND: do {
            self.image = "notify_hr"
            self.notiTypeName = "voucher".localized
        }
        case Constants.NotificationLogType.VOUCHER_EXPIRED: do {
            self.image = "notify_hr"
            self.notiTypeName = "voucher".localized
        }
        case Constants.NotificationLogType.NEW_VOUCHER: do {
            self.image = "notify_hr"
            self.notiTypeName = "voucher".localized
        }
            
        default: do { }
        }
    }
}
        
