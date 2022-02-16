//
//  FavoriteMerchants.swift
//  Social Benefit
//
//  Created by chu phuong dong on 15/02/2022.
//

import SwiftUI

struct FavoriteMerchantsView: View {
    
    @ObservedObject private var viewModel = FavoriteMerchantsViewModel()
    @State var selectedId = 0
    
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
            
            List(viewModel.listMerchant) { item in
                
                HStack(spacing: 10) {
                    URLImageView(url: Config.baseURL + (item.logo ?? ""))
                        .frame(width: 70, height: 70)
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
                    self.selectedId = item.id
                })
                .onAppear {
                    if item == viewModel.listMerchant.last {
                        viewModel.requestFavoriteMerchant()
                    }
                }
            }
            
            .loadingView(isLoading: $viewModel.isLoading, dimBackground: false)
        }
        .background(
            ZStack {
                NavigationLink.init(destination: FavoriteMerchantDetailView.init(merchantId: self.selectedId)) {
                    EmptyView()
                }
                NavigationLink(destination: EmptyView(), label: {})
            }
        )
        .background(BackgroundViewWithoutNotiAndSearch(isActive: Binding.constant(false), title: "", isHaveLogo: true))
        .navigationBarHidden(true)
        .errorPopup($viewModel.error)
    }
}

