//
//  MerchantCategoryItemViewModel.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/09/2021.
//

import Foundation

class MerchantCategoryItemViewModel: ObservableObject, Identifiable {
//    @Published var allMerchantCategoryItem = [MerchantCategoryItemData]()
    
    @Published var allMerchantCategoryItem = [MerchantCategoryItemData(id: 1, imgSrc: "https://i.imgur.com/YGMw0La.png", title: "Coffee"),
                                              MerchantCategoryItemData(id: 2, imgSrc: "https://i.imgur.com/JRu15X8.png", title: "Education"),
                                              MerchantCategoryItemData(id: 3, imgSrc: "https://i.imgur.com/DiZ02tO.png", title: "Restaurant1_Gộp"),
                                              MerchantCategoryItemData(id: 4, imgSrc: "https://i.imgur.com/gimwvgS.png", title: "Entertainment"),
                                              MerchantCategoryItemData(id: 5, imgSrc: "https://i.imgur.com/29AW2Ei.png", title: "Healthcare"),
                                              MerchantCategoryItemData(id: 6, imgSrc: "https://i.imgur.com/rzsHaY9.png", title: "Travel"),
                                              MerchantCategoryItemData(id: 8, imgSrc: "https://i.imgur.com/rMRRYgy.png", title: "Taxi"),
                                              MerchantCategoryItemData(id: 9, imgSrc: "https://i.imgur.com/FLbmjCC.png", title: "Fashion"),
                                              MerchantCategoryItemData(id: 10, imgSrc: "https://i.imgur.com/DOPVLwL.png", title: "Hotel"),
                                              MerchantCategoryItemData(id: 79, imgSrc: "/files/4198/bee.gif", title: "Experimental"),
                                              MerchantCategoryItemData(id: 80, imgSrc: "/files/4199/bee.gif", title: "Giảm tiền điện 20k"),
                                              MerchantCategoryItemData(id: 81, imgSrc: "/files/3798/ca27fb2f0273cb7923e011ad236cba76874def1d4db943cda927e22bcac9caa5_200.jfif", title: "Family Mart"),
                                              MerchantCategoryItemData(id: 82, imgSrc: "", title: "16"),
                                              MerchantCategoryItemData(id: 83, imgSrc: "/files/4197/bee.gif", title: "Milktea"), MerchantCategoryItemData(id: 84, imgSrc: "", title: "14"),
                                              MerchantCategoryItemData(id: 85, imgSrc: "", title: "15"),
                                              MerchantCategoryItemData(id: 86, imgSrc: "", title: "17"),
                                              MerchantCategoryItemData(id: 87, imgSrc: "", title: "18"),
                                              MerchantCategoryItemData(id: 88, imgSrc: "", title: "19"),
                                              MerchantCategoryItemData(id: 89, imgSrc: "", title: "20"),
                                              MerchantCategoryItemData(id: 90, imgSrc: "", title: "21"),
                                              MerchantCategoryItemData(id: 91, imgSrc: "", title: "tuantt"),
                                              MerchantCategoryItemData(id: 92, imgSrc: "", title: "111"),
                                              MerchantCategoryItemData(id: 93, imgSrc: "", title: "112"),
                                              MerchantCategoryItemData(id: 94, imgSrc: "", title: "113"),
                                              MerchantCategoryItemData(id: 95, imgSrc: "", title: "114"),
                                              MerchantCategoryItemData(id: 96, imgSrc: "", title: "115"),
                                              MerchantCategoryItemData(id: 97, imgSrc: "", title: "11111111111111111111"),
                                              MerchantCategoryItemData(id: 98, imgSrc: "", title: "22222222222222222222"),
                                              MerchantCategoryItemData(id: 99, imgSrc: "", title: "11111111111133333333"),
                                              MerchantCategoryItemData(id: 100, imgSrc: "", title: "33333333333333333333"),
                                              MerchantCategoryItemData(id: 101, imgSrc: "/files/4109/PHUS7968-Edi.jpg", title: "Hoa shopping 24h"),
                                              MerchantCategoryItemData(id: 102, imgSrc: "", title: "Thẻ điện thoại"),
                                              MerchantCategoryItemData(id: 103, imgSrc: "", title: "           avav"),
                                              MerchantCategoryItemData(id: 104, imgSrc: "", title: "anufbb    asdjfaiofjef"),
                                              MerchantCategoryItemData(id: 105, imgSrc: "", title: "jufuvfu shudfhoahdf"),
                                              MerchantCategoryItemData(id: 106, imgSrc: "", title: "aaaaaaaaaaaaa       nbbbb      bbbb")]
    @Published var selectedIndex: Int = 0
    
    private let merchantCategoryItemService = MerchantCategoryItemService()
    
    init() {
        merchantCategoryItemService.getAPI { data in
            DispatchQueue.main.async {
                self.allMerchantCategoryItem = data
            }
        }
    }
    
    
}
