//
//  ReactionPopUpViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation

class ReactionPopUpViewModel: ObservableObject {
    
    private let service = ReactCountGroupService()
    private let listService = ReactListService()
    
    @Published var error: AppError = .none
    
    @Published var countModel = ReactCountModel()
    
    @Published var listModel = ReactListModel()
    
    @Published var isLoading = false
    
    @Published var currentReactType = -1
    
    func request(_ contentType: Int, _ contentId: Int) {
        isLoading = true
        service.request(contentType: contentType, contentId: contentId) { response in
            switch response {
            case .success(let value):
                self.countModel = value
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
    
    func requestReactList(contentType: Int?, contentId: Int?, reactType: Int) {
        isLoading = true
        listService.request(contentType: contentType, contentId: contentId, reactType: reactType, fromIndex: 0) { response in
            switch response {
            case .success(let value):
                self.listModel = value
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
    
    func clearData() {
        countModel = ReactCountModel()
    }
}
