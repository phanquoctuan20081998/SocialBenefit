//
//  CategoryView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 13/09/2021.
//

import SwiftUI

struct MerchantCategoryItemView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    //    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            
            VStack(alignment: .leading, spacing: 10) {
                if 0 < allItem.count { FirstRowItemView }
                if 5 < allItem.count { SecondRowItemView }
            }
        }
        .background(
            NavigationLink(destination: NavigationLazyView(ListOfMerchantViewByCategory()),
                           isActive: $merchantCategoryItemViewModel.selection,
                           label: { EmptyView() })
        )
    }
}

extension MerchantCategoryItemView {
    var FirstRowItemView: some View {
        HStack(spacing: 10) {
            
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            
            ForEach(0..<(allItem.count > 5 ? 5 : allItem.count)) { i in
                MerchantCategoryItemCardView(data: merchantCategoryItemViewModel.allMerchantCategoryItem[i])
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var SecondRowItemView: some View {
        HStack(spacing: 10) {
            
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            
            ForEach(5..<(allItem.count > 9 ? 9 : allItem.count)) { i in
                MerchantCategoryItemCardView(data: merchantCategoryItemViewModel.allMerchantCategoryItem[i])
            }
            
            MerchantCategoryItemCardLocalView()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MerchantCategoryItemCardView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    
    //    @Binding var isActive: Bool
    
    var data: MerchantCategoryItemData
    
    var body: some View {
        VStack {
            URLImageView(url: self.data.imgSrc)
                .frame(width: 30, height: 30)
                .padding(7)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: -1, y: 3)
                )
            
            Text(self.data.title)
                .font(.system(size: 8))
            
            Spacer().frame(height: 3)
            
            if self.merchantCategoryItemViewModel.selectedId == self.data.id && self.merchantCategoryItemViewModel.isInCategoryView {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
            }
        }
        .frame(width: 70, height: 70, alignment: .top)
        .onTapGesture {
            DispatchQueue.main.async {
                self.merchantCategoryItemViewModel.selectedId = self.data.id
                self.merchantCategoryItemViewModel.selection = true
                self.merchantCategoryItemViewModel.isPresentPopUp = false
                
                self.specialOffersViewModel.categoryId = self.data.id
                self.offersViewModel.categoryId = self.data.id
                self.specialOffersViewModel.searchPattern = ""
                self.offersViewModel.searchPattern = ""
            }
            
            // Click count
            countClick()
        }
    }
}


// For loading "Other" tab just using image from local resource...
struct MerchantCategoryItemCardLocalView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
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
                .foregroundColor(.black)
            
            Spacer().frame(height: 3)
            
            if self.merchantCategoryItemViewModel.selectedId == -1 && self.merchantCategoryItemViewModel.isInCategoryView {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 2)
            }
        }
        .frame(width: 70, height: 70, alignment: .top)
        
        .onTapGesture {
            withAnimation {
                self.merchantCategoryItemViewModel.selectedId = -1
                self.merchantCategoryItemViewModel.isPresentPopUp = true
                self.homeScreenViewModel.isPresentedTabBar = false
            }
            
            // Click count
            countClick()
        }
    }
}

struct OtherPopUpView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if merchantCategoryItemViewModel.isPresentPopUp {
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture {
                        merchantCategoryItemViewModel.isPresentPopUp = false
                        self.homeScreenViewModel.isPresentedTabBar = true
                    }
                ContentView
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(.black)
            .edgesIgnoringSafeArea(.bottom)
    }
    
    var ContentView: some View {
        VStack(spacing: 15) {
            
            HStack {
                Text("all_categories".localized)
                Spacer()
                Button(action: {
                    merchantCategoryItemViewModel.isPresentPopUp = false
                    self.homeScreenViewModel.isPresentedTabBar = true
                }, label: {
                    Image(systemName: "xmark")
                })
            }.padding()
            
            Spacer().frame(height: 5)
            
            ScrollView {
                UIGrid(columns: 5, list: merchantCategoryItemViewModel.allMerchantCategoryItem) { item in
                    MerchantCategoryItemCardView(data: item)
                }.edgesIgnoringSafeArea(.all)
                
                Spacer().frame(height: 30)
            }
            
            
        }.padding(.vertical, 5)
            .background(Color.white)
            .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
