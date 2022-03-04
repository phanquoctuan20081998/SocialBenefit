//
//  HomeViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/10/2021.
//

import Foundation

class HomeViewModel: ObservableObject, Identifiable {
    @Published var isAnimating: Bool = true
    @Published var isPresentInternalNewDetail: Bool = false
    @Published var isPresentVoucherDetail: Bool = false
    
    @Published var selectedIndex: Int? = nil
    @Published var selectedInternalNew: InternalNewsData? = nil
    @Published var selectedVoucherId: Int? = nil
    
    @Published var walletInfor = WalletInforData()
    @Published var allRecognitionPost = [RecognitionData]()
    
    private var walletInforService = WalletInforService()
    private var recognitionService = RecognitionService()
    
    private let surveyListService = HomeSurveyListService()
    
    @Published var error: AppError = .none
    
    @Published var listSurvey: [SurveyResultModel] = []
    
    init() {
        loadWalletInfor()
        loadRecognitionData()
    }
    
    func loadWalletInfor() {
        walletInforService.getAPI { data in
            DispatchQueue.main.async {
                self.walletInfor = data
            }
        }
    }
    
    func loadRecognitionData() {
        recognitionService.getListByCompany(fromIndex: 0) { [weak self] data in
            DispatchQueue.main.async {
                if data.count > 5 {
                    self?.allRecognitionPost = Array(data[0..<5])
                } else {
                    self?.allRecognitionPost = data
                }
            }
        }
    }
    
    func requestHomeSurvey() {
        if showHomeSurvey() {
            surveyListService.request { response in
                switch response {
                case .success(let value):
                    self.listSurvey = value.result ?? []
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func showHomeSurvey() -> Bool {
        if isDisplayFunction(Constants.FuctionId.SURVEY), !isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
            return true
        }
        return false
    }
}
