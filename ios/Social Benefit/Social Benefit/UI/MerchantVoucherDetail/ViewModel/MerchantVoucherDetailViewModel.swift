//
//  MerchantVoucherDetailViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import Foundation

class MerchantVoucherDetailViewModel: ObservableObject, Identifiable {
    @Published var merchantVoucherDetail = MerchantVoucherDetailData()
    @Published var appliedStoreMerchantList = [AppliedStoreMerchantListData]()
    @Published var similarVouchers = [MerchantVoucherItemData]()
    
    @Published var selectedVoucherId = -1
    @Published var fromIndexAppliedStore = 0
    @Published var fromIndexSimilarVoucher = 0
    @Published var voucherId = -1
    
    // For display 3 bottom button controller...
    @Published var isBuy = false
    @Published var isOutOfStock = true
    @Published var isShowCopiedPopUp = false
    @Published var isShowQRPopUp = false
    
    // For store QR data
    @Published var QRData = VoucherCodeData(voucherCode: "", remainTime: 0)
    
    // For refreshing
    @Published var isLoading: Bool = false
    @Published var isRefreshingStoreList: Bool = false {
        didSet {
            if oldValue == false && isRefreshingStoreList == true {
                self.reloadAppliedStore()
            }
        }
    }
    
    @Published var isRefreshingSimiliarVoucher: Bool = false {
        didSet {
            if oldValue == false && isRefreshingSimiliarVoucher == true {
                self.reloadSimilarVoucher()
            }
        }
    }
    
    private let merchantVoucherDetailService = MerchantVoucherDetailService()
    private let appliedStoreMerchantListService = AppliedStoreMerchantListService()
    private let similarVoucherService = SimilarVoucherService()
    private let favoriteMerchantUpdateService = FavoriteMerchantUpdateService()
    private var confirmInforBuyService = ConfirmInforBuyService()
    
    init(voucherId: Int) {
        selectedVoucherId = voucherId
        getData()
        loadButtonController()
    }
    
    func getData() {
        self.isLoading = true

        merchantVoucherDetailService.getAPI(merchantVoucherId: selectedVoucherId) { data in
            DispatchQueue.main.async {
                self.merchantVoucherDetail = data
                
                self.appliedStoreMerchantListService.getAPI(voucherId: self.selectedVoucherId, fromIndex: self.fromIndexAppliedStore) { data in
                    DispatchQueue.main.async {
                        self.appliedStoreMerchantList = data
                        
                        self.similarVoucherService.getAPI(voucherId: self.selectedVoucherId, fromIndex: self.fromIndexSimilarVoucher) { data in
                            DispatchQueue.main.async {
                                self.similarVouchers = data
                                
                                if self.selectedVoucherId != 0 {
                                    self.isLoading = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func reloadAppliedStore() {
        appliedStoreMerchantListService.getAPI(voucherId: selectedVoucherId, fromIndex: fromIndexAppliedStore) { data in
            DispatchQueue.main.async {
                self.fromIndexAppliedStore = 0
                self.appliedStoreMerchantList = data
                self.isRefreshingStoreList = false
            }
        }
    }
    
    func reloadSimilarVoucher() {
        similarVoucherService.getAPI(voucherId: selectedVoucherId, fromIndex: fromIndexSimilarVoucher) { data in
            DispatchQueue.main.async {
                self.fromIndexSimilarVoucher = 0
                self.similarVouchers = data
                self.isRefreshingSimiliarVoucher = false
            }
        }
    }
    
    func loadMoreAppliedStore() {
        appliedStoreMerchantListService.getAPI(voucherId: selectedVoucherId, fromIndex: fromIndexAppliedStore) { data in
            DispatchQueue.main.async {
                for item in data {
                    self.appliedStoreMerchantList.append(item)
                    self.isRefreshingStoreList = false
                }
                
            }
        }
    }
    
    func loadMoreSimilarVoucher() {
        similarVoucherService.getAPI(voucherId: selectedVoucherId, fromIndex: fromIndexSimilarVoucher) { data in
            DispatchQueue.main.async {
                for item in data {
                    self.similarVouchers.append(item)
                    self.isRefreshingSimiliarVoucher = false
                }
            }
        }
    }
    
    func loadButtonController() {
        self.confirmInforBuyService.getAPI(voucherId: selectedVoucherId) { data in
            DispatchQueue.main.async {
                if data.canUseNumber ?? 0 > 0 { self.isBuy = true }
                else { self.isBuy = false }
                
                if data.remainVoucherInStock ?? 0 > 0 {self.isOutOfStock = false}
                else { self.isOutOfStock = true }
            }
        }
    }
    
    func likeMerchantButtonClick() {
        favoriteMerchantUpdateService.request(merchantId: self.merchantVoucherDetail.merchantId, likeMerchant: self.merchantVoucherDetail.employeeLikeThisMerchant)
    }
}











//let merchantVoucherDetailDebug = MerchantVoucherDetailData(id: 1841, imageURL: "", name: "Ưu đãi giá tiền taxi", merchantName: "Công ty giầy thể thao Triệu Sơn", content: "<p>123</p>", favoriteValue: 2, outOfDate: "11/10/2021", shoppingValue: 11, pointValue: 900000, moneyValue: 1000000, discountValue: -10, hotlines: "", employeeLikeThis: true)
//
//let appliedStoreMerchantListDebug = [AppliedStoreMerchantListData(id: 499, logo: "", fullName: "Liên Á Hà Nội", fullAddress: "23, Phường Bách Khoa, Quận Hai Bà Trưng, Thành phố Hà Nội", hotlines: "09764545354"),
//                                     AppliedStoreMerchantListData(id: 501, logo: "", fullName: "Cửa hàng Đệm Liên Á 170 Long Biên", fullAddress: "170, Phường Giảng Võ, Quận Ba Đình, Thành phố Hà Nội", hotlines: "08978766575"),
//                                     AppliedStoreMerchantListData(id: 500, logo: "", fullName: "Liên Á Long Biên", fullAddress: "35, Phường Phúc Đồng, Quận Long Biên, Thành phố Hà Nội", hotlines: "0917561527236"),
//                                     AppliedStoreMerchantListData(id: 499, logo: "", fullName: "Liên Á Hà Nội", fullAddress: "23, Phường Bách Khoa, Quận Hai Bà Trưng, Thành phố Hà Nội", hotlines: "09764545354"),
//                                     AppliedStoreMerchantListData(id: 501, logo: "", fullName: "Cửa hàng Đệm Liên Á 170 Long Biên", fullAddress: "170, Phường Giảng Võ, Quận Ba Đình, Thành phố Hà Nội", hotlines: "08978766575"),
//                                     AppliedStoreMerchantListData(id: 500, logo: "", fullName: "Liên Á Long Biên", fullAddress: "35, Phường Phúc Đồng, Quận Long Biên, Thành phố Hà Nội", hotlines: "0917561527236")]
