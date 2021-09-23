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
            
            ScrollView {
                SpecialOffersView()
                FilterView()
                AllOffersView()
            }
        }
        .background(BackGround)
        .onAppear {
            self.merchantCategoryItemViewModel.isInCategoryView = true
            self.specialOffersViewModel.searchPattern = ""
            self.offersViewModel.searchPattern = ""
        }
        .background(
            NavigationLink(
                destination: MyVoucherView(),
                isActive: $isActive,
                label: {
                    EmptyView()
                })
        )
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
                            
                            HStack() {
                                Image("ic_my_voucher")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 27)
                                
                                Text("my_voucher".localized)
                                    .font(.system(size: 9))
                                    .frame(width: 40)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal, 7)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                            .onTapGesture {
                                self.isActive = true
                            }
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
        ListOfMerchantViewByCategory()
            .environmentObject(HomeScreenViewModel())
            .environmentObject(InternalNewsViewModel())
            .environmentObject(MerchantVoucherSpecialListViewModel())
            .environmentObject(MerchantCategoryItemViewModel())
            .environmentObject(MerchantVoucherListByCategoryViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
    }
}
