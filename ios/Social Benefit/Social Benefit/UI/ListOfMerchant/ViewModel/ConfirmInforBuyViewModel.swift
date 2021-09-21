//
//  ConfirmInforBuyViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 20/09/2021.
//

import Foundation

class ConfirmInforBuyViewModel: ObservableObject, Identifiable {
    
//    @Published var buyVoucher = BuyVoucherInforData()
    
    @Published var buyVoucher = popUpDebug
    @Published var isPresentedPopup = false
    @Published var voucherId = 0
    @Published var choosedIndex = 0
    @Published var buyVoucherResponse = BuyVoucherData()
    @Published var isPresentedError = false
    
    private var confirmInforBuyService: ConfirmInforBuyService
    
    init() {
        self.confirmInforBuyService = ConfirmInforBuyService(voucherId: 0)
    }
    
    func getBuyVoucherInfor() {
        self.confirmInforBuyService.getAPI { data in
            DispatchQueue.main.async {
                self.buyVoucher = data
            }
        }
    }
    
    func loadData(voucherId: Int, choosedIndex: Int) {
        self.voucherId = voucherId
        self.choosedIndex = choosedIndex
        self.confirmInforBuyService = ConfirmInforBuyService(voucherId: voucherId)
        getBuyVoucherInfor()
    }
}

let popUpDebug = BuyVoucherInforData(remainPoint: -1, voucherPoint: 0, canUseNumber: -1, maxCanBuyNumber: 3, orderedNumber: 0, remainVoucherInStock: 199)
