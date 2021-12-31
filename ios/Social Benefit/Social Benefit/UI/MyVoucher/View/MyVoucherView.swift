//
//  MyVoucherView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/09/2021.
//

import SwiftUI
import MobileCoreServices

struct MyVoucherView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    @ObservedObject var myVoucherViewModel = MyVoucherViewModel()
    
    @State var isMoveToNextPage = false
    @State var selectedIndex = -1
    
    @State var isShowCopiedPopUp = false
    
    //Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        VStack {
            Spacer().frame(height: ScreenInfor().screenHeight * 0.13)
            
            SearchView
            
            VStack {
                TabView
                VoucherListView
            }.background(Color("nissho_light_blue"))
                .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            homeScreenViewModel.isPresentedTabBar = false
        }
        .background(
            ZStack {
                if self.selectedIndex != -1 {
                    NavigationLink(destination: NavigationLazyView(MerchantVoucherDetailView(voucherId: myVoucherViewModel.allMyVoucher[self.selectedIndex].id)
                                    .environmentObject(merchantVoucherDetailViewModel)
                                    .environmentObject(confirmInforBuyViewModel)
                                    .environmentObject(homeScreenViewModel)),
                                   isActive: $isMoveToNextPage,
                                   label: { EmptyView() })
                }
            }
        )
        .background(BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "my_vouchers".localized, isHaveLogo: true))
        
        //Pop-up overlay
        .overlay(SuccessedMessageView(successedMessage: "copied_to_clipboard".localized, isPresented: $isShowCopiedPopUp))
        .overlay(VoucherQRPopUpView(isPresentedPopup: $myVoucherViewModel.isPresentedQRPopup, voucher: myVoucherViewModel.selectedVoucherCode))
        .overlay(BuyVoucherPopUp(isPresentPopUp: $myVoucherViewModel.isPresentedReBuyPopup))
        
        .environmentObject(myVoucherViewModel)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

extension MyVoucherView {
    
    var SearchView: some View {
        SearchBarView(searchText: $myVoucherViewModel.searchPattern, isSearching: $myVoucherViewModel.isSearching, placeHolder: "search_your_voucher".localized, width: ScreenInfor().screenWidth * 0.9, height: 30, fontSize: 13, isShowCancelButton: true)
            .font(.system(size: 13))
    }
    
    var TabView: some View {
        HStack(spacing: 0) {
            ForEach(Constants.MYVOUCHER_TABHEADER.indices, id:\.self) { i in
                Text(Constants.MYVOUCHER_TABHEADER[i].localized)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor((myVoucherViewModel.status == i) ? Color.blue : Color.gray)
                    .frame(width: ScreenInfor().screenWidth / CGFloat(Constants.MYVOUCHER_TABHEADER.count), height: 30)
                    .background((myVoucherViewModel.status == i) ? Color("nissho_light_blue") : Color.white)
                    .onTapGesture {
                        withAnimation {
                            myVoucherViewModel.status = i
                        }
                    }
            }
        }.frame(width: ScreenInfor().screenWidth)
            .background(Color.white)
    }
    
    var VoucherListView: some View {
        VStack {
            if myVoucherViewModel.isLoading && !myVoucherViewModel.isRefreshing {
                LoadingPageView()
            } else {
                Spacer().frame(height: 15)
                
                RefreshableScrollView(height: 70, refreshing: self.$myVoucherViewModel.isRefreshing) {
                    VStack(spacing: 15) {
                        if myVoucherViewModel.allMyVoucher.isEmpty {
                            Text("no_voucher".localized).font(.system(size: 13))
                        }
                        ForEach(myVoucherViewModel.allMyVoucher.indices, id: \.self) {i in
                            VoucherCardView(isShowCopiedPopUp: $isShowCopiedPopUp, myVoucher: myVoucherViewModel.allMyVoucher[i], selectedTab: myVoucherViewModel.status)
                                .foregroundColor(Color.black)
                                .buttonStyle(FlatLinkStyle())
                                .onTapGesture {
    
                                    self.isMoveToNextPage.toggle()
                                    self.selectedIndex = i
                                    
                                    // Click count
                                    countClick(contentId: myVoucherViewModel.allMyVoucher[i].id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                                }
                        }
                        
                        //Infinite Scroll View
                        
                        if (myVoucherViewModel.fromIndex == myVoucherViewModel.allMyVoucher.count && self.isShowProgressView) {
                            
                            ActivityIndicator(isAnimating: true)
                                .onAppear {
                                    
                                    // Because the maximum length of the result returned from the API is 10...
                                    // So if length % 10 != 0 will be the last queue...
                                    // We only send request if it have more data to load...
                                    if self.myVoucherViewModel.allMyVoucher.count % Constants.MAX_NUM_API_LOAD == 0 {
                                        self.myVoucherViewModel.reloadData()
                                    }
                                    
                                    // Otherwise just delete the ProgressView after 1 seconds...
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isShowProgressView = false
                                    }
                                    
                                }
                            
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = ScreenInfor().screenHeight / 1.3
                                
                                if !self.myVoucherViewModel.allMyVoucher.isEmpty && minY < height && myVoucherViewModel.allMyVoucher.count >= Constants.MAX_NUM_API_LOAD  {
                                    
                                    DispatchQueue.main.async {
                                        self.myVoucherViewModel.fromIndex = self.myVoucherViewModel.allMyVoucher.count
                                        self.isShowProgressView = true
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                }
                Spacer().frame(height: 15)
            }
        }
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct MyVoucherView_Previews: PreviewProvider {
    static var previews: some View {
        MyVoucherView()
            .environmentObject(HomeScreenViewModel())
            .environmentObject(MyVoucherViewModel())
            .environmentObject(InternalNewsViewModel())
//            .environmentObject(SpecialOffersViewModel())
            .environmentObject(MerchantCategoryItemViewModel())
//            .environmentObject(OffersViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
//            .environmentObject(homeScreenViewModel)
//            .environmentObject(searchViewModel)
//            .environmentObject(homeViewModel)
//        HomeScreenView(selectedTab: "tag")
    }
}
