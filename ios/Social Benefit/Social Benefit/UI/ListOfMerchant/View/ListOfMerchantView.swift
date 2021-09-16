//
//  ListOfMerchantView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/09/2021.
//

import SwiftUI

struct ListOfMerchantView: View {
    
    @ObservedObject var specialOffersViewModel = SpecialOffersViewModel(searchPattern: "", fromIndex: 0, categoryId: -1)
    
    var body: some View {
        ScrollView {
            VStack {
                MerchantCategoryItemView()
                SpecialOffersView()
                FilterView()
                AllOffersView()
            }
            .environmentObject(specialOffersViewModel)
        }
    }
}

struct ListOfMerchantView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
    }
}
