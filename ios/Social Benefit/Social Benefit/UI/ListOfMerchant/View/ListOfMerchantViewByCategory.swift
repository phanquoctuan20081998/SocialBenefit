//
//  ListOfMerchantViewByCategory.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 19/09/2021.
//

import SwiftUI
import ScrollViewProxy

struct ListOfMerchantViewByCategory: View {
    
    @EnvironmentObject var merchantCategoryItemViewModel: MerchantCategoryItemViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isActive: Bool
    @State private var proxy: AmzdScrollViewProxy? = nil
    
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
                            }, label: {
                                Image(systemName: "arrow.backward")
                            })
                            Text("promotion".localized)
                                .bold()
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
                        MerchantCategoryItemCardView(isActive: $isActive, data: allItem[i])
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
        ListOfMerchantView()
    }
}
