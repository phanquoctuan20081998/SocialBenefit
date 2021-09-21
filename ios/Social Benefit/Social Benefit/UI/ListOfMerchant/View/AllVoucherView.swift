//
//  SpecialOffersView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import SwiftUI

struct AllOffersView: View {
    
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    @State var isShowProgressView: Bool = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 2) {
            
                VStack(spacing: 15) {
                    ForEach(self.offersViewModel.allOffers.indices, id: \.self) { i in
                        AllOfferCardView(voucherData: self.offersViewModel.allOffers[i], choosedIndex: i)
                    }
                    
                    //Infinite Scroll View
                    
                    if (self.offersViewModel.fromIndex == self.offersViewModel.allOffers.count && self.isShowProgressView) {
                        
                        ActivityIndicator(isAnimating: true)
                            .onAppear {
                                if self.offersViewModel.allOffers.count % 10 == 0 {
                                    self.offersViewModel.reLoadData()
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowProgressView = false
                                }
                                
                            }
                        
                    } else {
                        GeometryReader { reader -> Color in
                            let minY = reader.frame(in: .global).minY
                            let height = ScreenInfor().screenHeight / 1.3
                            
                            if !self.offersViewModel.allOffers.isEmpty && minY < height {
                                
                                DispatchQueue.main.async {
                                    self.offersViewModel.fromIndex = self.offersViewModel.allOffers.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                    
                    Spacer().frame(height: 40)
                    
                }.padding()
            }
        }
    }
}

struct AllOfferCardView: View {
    
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    var voucherData: MerchantVoucherItemData
    var choosedIndex: Int
    
    var body: some View {
        HStack {
            URLImageView(url: voucherData.imageURL)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(10)
            
            Spacer().frame(width: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text("[\(voucherData.merchantName)] \(voucherData.name)")
                    .font(.system(size: 13))
                    .lineLimit(2)
                    .frame(height: 32, alignment: .topLeading)
                
                
                LoveAndCartCountView
                
                DiscountView
            }
        }
        .frame(width: ScreenInfor().screenWidth * 0.9, height: 100)
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: -3, y: 1))
    }
}

extension AllOfferCardView {
    
    var LoveAndCartCountView: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "suit.heart")
                    .foregroundColor(.red)
                    .font(.system(size: 13))
                Text("\(voucherData.favoriteValue)")
                    .font(.system(size: 13))
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
            
            
            HStack(spacing: 2) {
                Image(systemName: "cart")
                    .foregroundColor(.blue)
                    .font(.system(size: 13))
                Text("\(voucherData.shoppingValue)")
                    .font(.system(size: 13))
            }
        }
        .frame(width: 150, alignment: .leading)
    }
    
    var DiscountView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(voucherData.pointValue) VND")
                    .bold()
                    .foregroundColor(.blue)
                    .font(.system(size: 11))
                
                HStack {
                    Text("\(voucherData.moneyValue) VND")
                        .strikethrough()
                        .font(.system(size: 11))
                    
                    Text("\(voucherData.discountValue)%")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.orange))
                }
            }
            
            Spacer()
            
            Button(action: {
                self.confirmInforBuyViewModel.loadData(voucherId: voucherData.id, choosedIndex: choosedIndex)
                self.confirmInforBuyViewModel.isPresentedPopup = true
            }, label: {
                Text("buy".localized)
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: -0.5, y: 0.5))
            })
        }.padding(.trailing, 20)
    }
}

struct AllOffersView_Previews: PreviewProvider {
    static var previews: some View {
        AllOffersView()
            .environmentObject(MerchantVoucherSpecialListViewModel())
            .environmentObject(MerchantVoucherListByCategoryViewModel())
            .environmentObject(ConfirmInforBuyViewModel())
    }
}




