//
//  ListOfMerchantViewByCategory.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/09/2021.
//

import SwiftUI
import ScrollViewProxy

struct ListOfMerchantViewByCategory: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var proxy: AmzdScrollViewProxy? = nil
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 40)
            
            VoucherCategoryList
            
            if (specialOffersViewModel.isLoading || offersViewModel.isLoading) && !(specialOffersViewModel.isRefreshing || offersViewModel.isRefreshing) {
                LoadingPageView()
            } else {
                let binding = Binding<Bool>(
                    get: {
                        self.specialOffersViewModel.isRefreshing && self.offersViewModel.isRefreshing
                    },
                    
                    set: {
                        self.specialOffersViewModel.isRefreshing = $0
                        self.offersViewModel.isRefreshing = $0
                    })
                
                RefreshableScrollView(height: 70, refreshing: binding) {
                    SpecialOffersView()
                    FilterView()
                    AllOffersView()
                }
            }
        }
        .background(BackGround)
        .onAppear {
            self.merchantCategoryItemViewModel.isInCategoryView = true
            self.specialOffersViewModel.searchPattern = ""
            self.offersViewModel.searchPattern = ""
            self.homeScreenViewModel.isPresentedTabBar = false
        }
    }
}

extension ListOfMerchantViewByCategory {
    
    var BackGround: some View {
        VStack {
            Image("pic_background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea([.top])
                .frame(width: ScreenInfor().screenWidth)
                .overlay(
                    HStack {
                        HStack(spacing: 10) {
                            Button(action: {
                                self.merchantCategoryItemViewModel.isInCategoryView = false
                                self.presentationMode.wrappedValue.dismiss()
                                self.specialOffersViewModel.reset()
                                self.offersViewModel.reset()
                                self.homeScreenViewModel.isPresentedTabBar = true
                            }, label: {
                                Image(systemName: "arrow.backward")
                                    .font(.headline)
                            })
                            
                            Text("promotion".localized)
                                .bold()
                            
                            Spacer()
                            
                            MyVoucherButtonView()
                        }.foregroundColor(.blue)
                        .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))
                        
                        Spacer()
                    }, alignment: .top)
            
            Spacer()
        }
    }
    
    var VoucherCategoryList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            AmzdScrollViewReader { proxy in
                HStack {
                    let allItem = self.merchantCategoryItemViewModel.allMerchantCategoryItem
                    
                    ForEach(0..<allItem.count, id: \.self) { i in
                        MerchantCategoryItemCardView(data: allItem[i])
                            .scrollId(allItem[i].id)
                    }
                    let _ = self.proxy?.scrollTo(self.merchantCategoryItemViewModel.selectedId,
                                                 alignment: .center,
                                                     animated: true)
                }.onAppear { self.proxy = proxy }
            }
        }
    }
}
struct ListOfMerchantViewByCategory_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
