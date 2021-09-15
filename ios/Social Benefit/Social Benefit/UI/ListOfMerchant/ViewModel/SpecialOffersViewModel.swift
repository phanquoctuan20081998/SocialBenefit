//
//  SpecialOffersViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/09/2021.
//

import Foundation

class SpecialOffersViewModel: ObservableObject, Identifiable {
//    @Published var allSpecialOffers = [MerchantVoucherItemData]()
    
    @Published var allSpecialOffers: [MerchantVoucherItemData] = [
        MerchantVoucherItemData(id: 1839, voucherCode: 0, imageURL: "", name: "Bảo dưỡng xe máy", merchantName: "Toyota", content: "<h1><strong>Bảo dưỡng xe máy</strong></h1><p><strong><em>Thay dầu nhớt</em></strong></p><p><strong><em>Kiểm tra đèn xe</em></strong></p><p><strong><em>Chỉnh phanh</em></strong></p><p><br></p><p>Đến ngay đi!!!</p>", favoriteValue: 0, outOfDateTime: Date(), shoppingValue: 0, pointValue: 250000, moneyValue: 300000, discountValue: -16, categoryId: -1, merchantId: -1, employeeLikeThis: false),
        MerchantVoucherItemData(id: 1841, voucherCode: 0, imageURL: "", name: "Ưu đãi giá tiền taxi", merchantName: "Công ty giầy thể thao Triệu Sơn", content: "<p>123</p>", favoriteValue: 2, outOfDateTime: Date(), shoppingValue: 1, pointValue: 900000, moneyValue: 1000000, discountValue: -10, categoryId: -1, merchantId: -1, employeeLikeThis: true),
                                                                  
        MerchantVoucherItemData(id: 1830, voucherCode: 0, imageURL: "", name: "Giảm giá áo thu đông 2021", merchantName: "Đệm Liên Á", content: "<p>chào đón thu đông 2021</p>", favoriteValue: 0, outOfDateTime: Date(), shoppingValue: 1, pointValue: 900000, moneyValue: 1000000, discountValue: -10, categoryId: -1, merchantId: -1, employeeLikeThis: false),
                                                                  
        MerchantVoucherItemData(id: 1767, voucherCode: 0, imageURL: "/files/4180/images - Copy.png", name: "Voucher_16082021_3", merchantName: "Mỹ phầm Coco", content: "<p>Voucher_16082021_3</p>", favoriteValue: 1, outOfDateTime: Date(), shoppingValue: 1, pointValue: 900000, moneyValue: 1000000, discountValue: -10, categoryId: -1, merchantId: -1, employeeLikeThis: false),
                                                                  
        MerchantVoucherItemData(id: 1807, voucherCode: 0, imageURL: "", name: "Chào hè ưu đãi khủng", merchantName: "Đệm Liên Á", content: "<p>giảm nhanh khóa học </p>", favoriteValue: 0, outOfDateTime: Date(), shoppingValue: 2, pointValue: 3300000, moneyValue: 3500000, discountValue: -5, categoryId: -1, merchantId: -1, employeeLikeThis: false),
                                                                  
        MerchantVoucherItemData(id: 1854, voucherCode: 0, imageURL: "", name: "test 01", merchantName: "Đệm Liên Á", content: "<p>hgfhf</p>", favoriteValue: 0, outOfDateTime: Date(), shoppingValue: 0, pointValue: 290000, moneyValue: 300000, discountValue: -3, categoryId: -1, merchantId: -1, employeeLikeThis: false),
                                                                  
        MerchantVoucherItemData(id: 1836, voucherCode: 0, imageURL: "", name: "Test cửa hàng", merchantName: "Be", content: "<p>123</p>", favoriteValue: 0, outOfDateTime: Date(), shoppingValue: 0, pointValue: 999977, moneyValue: 1000000, discountValue: 0, categoryId: -1, merchantId: -1, employeeLikeThis: false),
                                                                  
        MerchantVoucherItemData(id: 1838, voucherCode: 0, imageURL: "", name: "Ưu đãi thẻ điện thoại", merchantName: "Công ty giầy thể thao Triệu Sơn", content: "<p>Mua thẻ điện thoại từ 50k trở lên giảm 5 % </p>", favoriteValue: 1, outOfDateTime: Date(), shoppingValue: 0, pointValue: 999977, moneyValue: 1000000, discountValue: 0, categoryId: -1, merchantId: -1, employeeLikeThis: false),
                                                                  
        MerchantVoucherItemData(id: 1840, voucherCode: 0, imageURL: "", name: "Test1", merchantName: "Công ty giầy thể thao Triệu Sơn", content: "<p>123</p>", favoriteValue: 0, outOfDateTime: Date(), shoppingValue: 1, pointValue: 999977, moneyValue: 1000000, discountValue: 0, categoryId: -1, merchantId: -1, employeeLikeThis: false)]
    
    @Published var searchPattern: String = ""
    @Published var fromIndex: Int = -1
    @Published var category: Int = -1
    
    private let specialOffersService = SpecialOffersService()
    
    init(searchPattern: String, fromIndex: Int, categoryid: Int) {
        specialOffersService.getAPI(searchPattern: searchPattern, fromIndex: fromIndex, categoryId: categoryid) { data in
            DispatchQueue.main.async {
                self.allSpecialOffers = data
                print(data)
            }
        }
    }
}
