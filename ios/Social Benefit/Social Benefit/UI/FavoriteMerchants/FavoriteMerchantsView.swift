//
//  FavoriteMerchants.swift
//  Social Benefit
//
//  Created by chu phuong dong on 15/02/2022.
//

import SwiftUI

struct FavoriteMerchantsView: View {
    
    @StateObject private var viewModel = FavoriteMerchantsViewModel()
    
    @State var selectedMerchant = FavoriteMerchantResultModel(fullName: "", id: 0, hotlines: "", logo: "", fullAddress: "")
    @State var isMoveToDetail = false
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 50)
            
            Text("your_favorite_merchant".localized.uppercased())
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.blue)
            
            SearchBarView(searchText: $viewModel.keyword, isSearching: $viewModel.isSearching, placeHolder: "search_your_favorite_merchant".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: false)
                .font(.system(size: 13))
            
            ScrollView {
                ForEach(viewModel.listMerchant.indices, id: \.self) { i in
                    let item = viewModel.listMerchant[i]
                    VStack {
                        HStack(spacing: 10) {
                            URLImageView(url: Config.baseURL + (item.logo ?? ""))
                                .frame(width: 70, height: 70)
                                .clipped()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Group {
                                    Text(item.fullName ?? "")
                                        .bold()
                                        .font(Font.system(size: 15))
                                    Text(item.fullAddress ?? "")
                                        .font(Font.system(size: 12))
                                    Text(item.hotlines ?? "")
                                        .foregroundColor(Color.blue)
                                        .font(Font.system(size: 12))
                                }
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .onTapGesture(perform: {
                            self.selectedMerchant = item
                            self.isMoveToDetail = true
                        })
                        .onAppear {
                            if item == viewModel.listMerchant.last {
                                viewModel.requestFavoriteMerchant()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .if(i % 2 == 0) {
                            $0.background(Color.white)
                        }
                        .if(i % 2 != 0) {
                            $0.background(Color.init(red: 246/255, green: 249/255, blue: 255/255))
                        }
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                
                if viewModel.isLoading {
                    UIActivityRep.init(style: .medium, color: .black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
        .background(
            ZStack {
                if self.selectedMerchant.id != 0 {
                    NavigationLink(destination: NavigationLazyView(FavoriteMerchantDetailView
                                                                    .init(merchant: self.selectedMerchant)),
                                   isActive: self.$isMoveToDetail) {
                        EmptyView()
                    }
                    NavigationLink(destination: EmptyView(), label: {})
                }
            }
        )
        .background(BackgroundViewWithoutNotiAndSearch(isActive: Binding.constant(false), title: "", isHaveLogo: true))
        .navigationBarHidden(true)
        .errorPopup($viewModel.error)
    }
}
