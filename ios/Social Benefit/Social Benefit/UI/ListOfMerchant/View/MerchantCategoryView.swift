//
//  CategoryView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/09/2021.
//

import SwiftUI

struct MerchantCategoryItemView: View {
    @ObservedObject var merchantCategoryItemViewModel = MerchantCategoryItemViewModel()
    
    var body: some View {
        VStack {
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            
            VStack(spacing: 10) {
                if 0 < allItem.count { FirstRowItemView }
                if 5 < allItem.count { SecondRowItemView }
            }
        }
        .environmentObject(merchantCategoryItemViewModel)
    }
}

extension MerchantCategoryItemView {
    var FirstRowItemView: some View {
        HStack(spacing: 10) {
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            ForEach(0..<(allItem.count > 5 ? 5 : allItem.count)) { i in
                MerchantCategoryItemCardView(curPosition: i)
            }
        }.padding(.horizontal)
    }
    
    var SecondRowItemView: some View {
        HStack(spacing: 10) {
            
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            
            ForEach(5..<(allItem.count > 9 ? 9 : allItem.count)) { i in
                MerchantCategoryItemCardView(curPosition: i)
            }
            
            MerchantCategoryItemCardLocalView()
            
            
        }.padding(.horizontal)
    }
}

struct MerchantCategoryItemCardView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    var curPosition: Int
    
    var body: some View {
        VStack {
            URLImageView(url: self.merchantCategoryItemViewModel.allMerchantCategoryItem[self.curPosition].imgSrc)
                .frame(width: 30, height: 30)
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: -1, y: 3)
                )
            
            Text(self.merchantCategoryItemViewModel.allMerchantCategoryItem[self.curPosition].title)
                .font(.system(size: 8))
            
            Spacer().frame(height: 3)
            if self.merchantCategoryItemViewModel.selectedIndex == self.curPosition {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
            }
        }
        .frame(width: 70, height: 70, alignment: .top)
        .onTapGesture {
            withAnimation(.spring()) {
                self.merchantCategoryItemViewModel.selectedIndex = self.curPosition
            }
        }
    }
}


// For loading "Other" tab just using image from local resource...
struct MerchantCategoryItemCardLocalView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    
    var body: some View {
        VStack {
            Image("ic_others")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: -1, y: 3)
                )
            
            Text("other".localized)
                .font(.system(size: 8))
            
            Spacer().frame(height: 3)
            
            if self.merchantCategoryItemViewModel.selectedIndex == 9 {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
            }
        }
        .frame(width: 70, height: 70, alignment: .top)
        .onTapGesture {
            withAnimation(.spring()) {
                self.merchantCategoryItemViewModel.selectedIndex = 9
            }
        }
    }
}


struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantCategoryItemView()
    }
}
