//
//  RecentlyVoucherViewModel.swift
//  Social Benefit
//
//  Created by chu phuong dong on 21/02/2022.
//

import Foundation

class RecentlyVoucherViewModel: ObservableObject {
    
    private let service = RecentlyViewedVoucherListService()
    private let buyInforService = BuyInforVoucherService()
    
    @Published var error: AppError = .none
    
    @Published var isLoading = false
    @Published var isLoadingBuyInfor = false
    
    @Published var list: [RecentlyVoucherResultModel] = []
    
    @Published private var canLoadMore = true
    
    @Published var buyInforModel: BuyInforVoucherResultModel?
    
    @Published var voucherBuyId: Int?
    
    init() {
        request()
    }
    
    func request() {
        if (!isLoading && canLoadMore) {
            isLoading = true
            service.request(fromIndex: list.count) { response in
                self.isLoading = false
                switch response {
                case .success(let value):
                    if let result = value.result {
                        self.list.append(contentsOf: result)
                        if (result.isEmpty || result.count < Constants.MAX_NUM_API_LOAD) {
                            self.canLoadMore = false
                        }
                    } else {
                        self.canLoadMore = false
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
    
    func requestBuyInfo(id: Int) {
        voucherBuyId = id
        isLoadingBuyInfor = true
        buyInforService.request(voucherId: id) { response in
            self.isLoadingBuyInfor = false
            switch response {
            case .success(let value):
                self.buyInforModel = value.result
            case .failure(let erorr):
                self.error = erorr
            }
        }
    }
}
