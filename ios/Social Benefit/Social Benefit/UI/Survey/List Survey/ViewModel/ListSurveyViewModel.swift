//
//  ListSurveyViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 25/11/2021.
//

import Foundation
import Combine

class ListSurveyViewModel: ObservableObject {
    
    private let service = ListSurveySerive()
    
    @Published var listSurvey = ListSurveyModel()
    @Published var isLoading = false
    @Published var keyword = ""
    
    @Published var error: AppError = .none
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isRequested = false
    
    var tabSelection = 0 {
        didSet {
            requestListSurvey()
        }
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $keyword
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] _ in
                self?.requestListSurvey()
            })
            .store(in: &cancellables)
    }
    
    func firstRequest() {
        error = .none
        if !isRequested {
            isRequested = true
            self.requestListSurvey()
        }
    }
    
    func requestListSurvey() {
        listSurvey = ListSurveyModel()
        isLoading = true
        let flag = SurveyStatus.init(rawValue: tabSelection) ?? .onGoing
        service.request(keyword: keyword, flag: flag) { response in
            switch response {
            case .success(let value):
                self.listSurvey = value
            case .failure(let error):
                self.error = error
            }
            self.isLoading = false
        }
    }
}
