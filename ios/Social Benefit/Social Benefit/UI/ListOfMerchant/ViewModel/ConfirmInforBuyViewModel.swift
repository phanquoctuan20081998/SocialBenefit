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
    @Published var maxVoucher: Int = 199
    @Published var isPresentedPopup = false
    @Published var errorMes = ""
    
    private var voucherId = 0
    private var confirmInforBuyService: ConfirmInforBuyService
    
    init() {
        self.confirmInforBuyService = ConfirmInforBuyService(voucherId: voucherId)
    }
    
    func getBuyVoucherInfor() {
        self.confirmInforBuyService.getAPI { data in
            DispatchQueue.main.async {
                self.buyVoucher = data
                
                if data.maxCanBuyNumber == -1 {
                    if data.remainVoucherInStock == -1 {
                        self.maxVoucher = 0
                        self.errorMes = "cannot_buy_this_voucher".localized
                    }
                    else {
                        self.maxVoucher = data.remainVoucherInStock!
                        self.errorMes = "number_of_voucher_is_not_enough".localized
                    }
                } else if data.remainVoucherInStock == -1 {
                    self.maxVoucher = data.maxCanBuyNumber!
                    self.errorMes = "you_can_buy_only %d".localizeWithFormat(arguments: self.maxVoucher)
                } else {
                    if (data.maxCanBuyNumber! > data.remainVoucherInStock!) {
                        self.maxVoucher = data.remainVoucherInStock!
                        self.errorMes = "number_of_voucher_is_not_enough".localized
                    } else {
                        self.maxVoucher = data.maxCanBuyNumber!
                        self.errorMes = "you_can_buy_only %d".localizeWithFormat(arguments: self.maxVoucher)
                    }
                    
                }
            }
        }
    }
    
    func loadData(voucherId: Int) {
        self.voucherId = voucherId
        self.confirmInforBuyService = ConfirmInforBuyService(voucherId: voucherId)
        getBuyVoucherInfor()
    }
}

let popUpDebug = BuyVoucherInforData(remainPoint: -1, voucherPoint: 0, canUseNumber: -1, maxCanBuyNumber: 3, orderedNumber: 0, remainVoucherInStock: 199)
