//
//  ConfirmInforBuyViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 20/09/2021.
//

import Foundation

class ConfirmInforBuyViewModel: ObservableObject, Identifiable {
    
    @Published var buyVoucher = popUpDebug
    @Published var walletInfor = WalletInforData(companyPoint: 0, personalPoint: 0)
    
    @Published var isPresentedPopup = false
    @Published var voucherId = 0
    @Published var buyVoucherResponse = BuyVoucherData()
    @Published var isPresentedError = false
    
    private var confirmInforBuyService: ConfirmInforBuyService
    private var walletInforService = WalletInforService()
    
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
    
    func getWallInfor() {
        self.walletInforService.getAPI { data in
            DispatchQueue.main.async {
                self.walletInfor = data
            }
        }
    }
    
    func loadData(voucherId: Int) {
        self.voucherId = voucherId
        self.confirmInforBuyService = ConfirmInforBuyService(voucherId: voucherId)
        getBuyVoucherInfor()
        getWallInfor()
    }
}

let popUpDebug = BuyVoucherInforData(remainPoint: -1, voucherPoint: 0, canUseNumber: -1, maxCanBuyNumber: 3, orderedNumber: 0, remainVoucherInStock: 199)
