//
//  MerchantVoucherDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import Foundation

class MerchantVoucherDetailViewModel: ObservableObject, Identifiable {
    @Published var merchantVoucherDetail = merchantVoucherDetailDebug
    @Published var appliedStoreMerchantList = [AppliedStoreMerchantListData]()
    @Published var similarVouchers = allSpecialOffersDebug
    
    @Published var selectedVoucherId = -1
    @Published var fromIndexAppliedStore = 0
    @Published var fromIndexSimilarVoucher = 0
    
    private let merchantVoucherDetailService = MerchantVoucherDetailService()
    private let appliedStoreMerchantListService = AppliedStoreMerchantListService()
    private let similarVoucherService = SimilarVoucherService()
    
    func getData(voucherId: Int) {
        self.selectedVoucherId = voucherId
        
        merchantVoucherDetailService.getAPI(merchantVoucherId: voucherId) { data in
            DispatchQueue.main.async {
                self.merchantVoucherDetail = data
            }
        }
        
        appliedStoreMerchantListService.getAPI(voucherId: voucherId, fromIndex: fromIndexAppliedStore) { data in
            DispatchQueue.main.async {
                self.appliedStoreMerchantList = data
            }
        }
        
        similarVoucherService.getAPI(voucherId: voucherId, fromIndex: fromIndexSimilarVoucher) { data in
            DispatchQueue.main.async {
                self.similarVouchers = data
            }
        }
    }
    
    func reloadAppliedStore() {
        appliedStoreMerchantListService.getAPI(voucherId: selectedVoucherId, fromIndex: fromIndexAppliedStore) { data in
            DispatchQueue.main.async {
                self.appliedStoreMerchantList = data
            }
        }
    }
    
    func reloadSimilarVoucher() {
        similarVoucherService.getAPI(voucherId: selectedVoucherId, fromIndex: fromIndexSimilarVoucher) { data in
            DispatchQueue.main.async {
                self.similarVouchers = data
            }
        }
    }
}

let merchantVoucherDetailDebug = MerchantVoucherDetailData(id: 1841, imageURL: "", name: "Ưu đãi giá tiền taxi", merchantName: "Công ty giầy thể thao Triệu Sơn", content: "<p>123</p>", favoriteValue: 2, outOfDate: "11/10/2021", shoppingValue: 11, pointValue: 900000, moneyValue: 1000000, discountValue: -10, hotlines: "", employeeLikeThis: true)

let appliedStoreMerchantListDebug = [AppliedStoreMerchantListData(id: 499, logo: "", fullName: "Liên Á Hà Nội", fullAddress: "23, Phường Bách Khoa, Quận Hai Bà Trưng, Thành phố Hà Nội", hotlines: "09764545354"),
                                     AppliedStoreMerchantListData(id: 501, logo: "", fullName: "Cửa hàng Đệm Liên Á 170 Long Biên", fullAddress: "170, Phường Giảng Võ, Quận Ba Đình, Thành phố Hà Nội", hotlines: "08978766575"),
                                     AppliedStoreMerchantListData(id: 500, logo: "", fullName: "Liên Á Long Biên", fullAddress: "35, Phường Phúc Đồng, Quận Long Biên, Thành phố Hà Nội", hotlines: "0917561527236"),
                                     AppliedStoreMerchantListData(id: 499, logo: "", fullName: "Liên Á Hà Nội", fullAddress: "23, Phường Bách Khoa, Quận Hai Bà Trưng, Thành phố Hà Nội", hotlines: "09764545354"),
                                     AppliedStoreMerchantListData(id: 501, logo: "", fullName: "Cửa hàng Đệm Liên Á 170 Long Biên", fullAddress: "170, Phường Giảng Võ, Quận Ba Đình, Thành phố Hà Nội", hotlines: "08978766575"),
                                     AppliedStoreMerchantListData(id: 500, logo: "", fullName: "Liên Á Long Biên", fullAddress: "35, Phường Phúc Đồng, Quận Long Biên, Thành phố Hà Nội", hotlines: "0917561527236")]
