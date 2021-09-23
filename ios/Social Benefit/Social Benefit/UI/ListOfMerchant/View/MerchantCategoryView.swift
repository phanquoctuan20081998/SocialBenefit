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
            
            VStack(spacing: 10) {
                if 0 < allItem.count { FirstRowItemView }
                if 5 < allItem.count { SecondRowItemView }
            }
        }
    }
}

extension MerchantCategoryItemView {
    var FirstRowItemView: some View {
        HStack(spacing: 10) {
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            ForEach(0..<(allItem.count > 5 ? 5 : allItem.count)) { i in
                MerchantCategoryItemCardView(data: merchantCategoryItemViewModel.allMerchantCategoryItem[i])
            }
        }.padding(.horizontal)
    }
    
    var SecondRowItemView: some View {
        HStack(spacing: 10) {
            
            let allItem = merchantCategoryItemViewModel.allMerchantCategoryItem
            
            ForEach(5..<(allItem.count > 9 ? 9 : allItem.count)) { i in
                MerchantCategoryItemCardView(data: merchantCategoryItemViewModel.allMerchantCategoryItem[i])
            }
            
            MerchantCategoryItemCardLocalView()
            
        }.padding(.horizontal)
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
            self.merchantCategoryItemViewModel.selectedId = self.data.id
            self.specialOffersViewModel.categoryId = self.data.id
            self.offersViewModel.categoryId = self.data.id
//            self.isActive = true
            self.merchantCategoryItemViewModel.selection = 1
            self.merchantCategoryItemViewModel.isPresentPopUp = false
            self.homeScreenViewModel.isPresentedTabBar = false
        }
    }
}


// For loading "Other" tab just using image from local resource...
struct MerchantCategoryItemCardLocalView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    
    var body: some View {
        NavigationLink(destination: ListOfMerchantViewByCategory().navigationBarHidden(true),
                       tag: 1,
                       selection: $merchantCategoryItemViewModel.selection,
                       label: {
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
                            }
                        }
                       })
    }
}

struct OtherPopUpView: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if merchantCategoryItemViewModel.isPresentPopUp {
                Color.black
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.top)
                    .onTapGesture {
                        merchantCategoryItemViewModel.isPresentPopUp = false
                    }
                ContentView
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
        .padding(.bottom, 20)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var ContentView: some View {
        VStack(spacing: 15) {
            
            HStack {
                Text("all_categories".localized)
                Spacer()
                Button(action: {
                    merchantCategoryItemViewModel.isPresentPopUp = false
                }, label: {
                    Image(systemName: "xmark")
                })
            }.padding()
            
            ScrollView {
                UIGrid(columns: 5, list: merchantCategoryItemViewModel.allMerchantCategoryItem) { item in
                    MerchantCategoryItemCardView(data: item)
                }
            }
        }.padding(.vertical, 5)
        .frame(height: 420)
        .background(Color.white)
        .cornerRadius(radius: 30, corners: [.topLeft, .topRight])
//        .padding(.horizontal)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantCategoryItemView()
//        OtherPopUpView()
            .environmentObject(MerchantCategoryItemViewModel())
    }
}
