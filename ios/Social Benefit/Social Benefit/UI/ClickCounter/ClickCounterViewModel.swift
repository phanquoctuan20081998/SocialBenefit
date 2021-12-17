//
//  ClickCounter.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/12/2021.
//

import Foundation

class ClickCounter: ObservableObject, Identifiable {
    
    private var items = [ViewClickItemData]()
    private var viewClickService = ViewClickService()
    
    func add(contentId: Int, contentType: Int) {
        items.append(ViewClickItemData(contentId: contentId, contentType: contentType))
    }
    
    func summitAPI() {
        if !items.isEmpty {
            viewClickService.updateAPI(items: items)
            items = []
        }
    }
}

// Global variable
var clickCounter = ClickCounter()

func countClick() {
    clickCounter.add(contentId: 0, contentType: Constants.ViewContent.TYPE_OTHER)
}

func countClick(contentId: Int, contentType: Int) {
    clickCounter.add(contentId: contentId, contentType: contentType)
}
