//
//  OnboardingViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/03/2022.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    private let service = OnboardingService()
    
    private let serviceVN = OnboardingVNService()
    
    @Published var currentPage = 0
    
    @Published var list: [OnboardingResultModel] = []
    
    @Published var error: AppError = .none
    
    init() {
        request()
    }
    
    func request() {
        if UserDefaults.getAppLanguage() == .vi {
            serviceVN.request { response in
                switch response {
                case .success(let value):
                    self.list = value.result ?? []
                    self.list = self.list.sorted { model1, model2 in
                        return model1.sortOrder < model2.sortOrder
                    }
                    if self.list.isEmpty {
                        Utils.setLoginIsRoot()
                    }
                    self.error = .none
                case .failure(let error):
                    self.error = error
                }
            }
        } else {
            service.request { response in
                switch response {
                case .success(let value):
                    self.list = value.result ?? []
                    self.list = self.list.sorted { model1, model2 in
                        return model1.sortOrder < model2.sortOrder
                    }
                    if self.list.isEmpty {
                        Utils.setLoginIsRoot()
                    }
                    self.error = .none
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
}
