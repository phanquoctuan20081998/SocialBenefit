//
//  SpecialOffersView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import SwiftUI

struct SpecialOffersView: View {
    
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    
    @State var isShowProgressView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("special_offer".localized.uppercased())
                .font(.system(size: 18, weight: .heavy, design: .default))
                .padding(.leading)
                .foregroundColor(.orange)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(self.specialOffersViewModel.allSpecialOffers.indices, id: \.self) { i in
                        NavigationLink(
                            destination: MerchantVoucherDetailView(voucherId: self.specialOffersViewModel.allSpecialOffers[i].id),
                            label: {
                                SpecialOfferCardView(voucherData: self.specialOffersViewModel.allSpecialOffers[i], choosedIndex: i)
                                    .foregroundColor(.black)
                            })
                    }

                    //Infinite Scroll View

                    if (self.specialOffersViewModel.fromIndex == self.specialOffersViewModel.allSpecialOffers.count && self.isShowProgressView) {

                        ActivityIndicator(isAnimating: true)
                            .onAppear {

                                // Because the maximum length of the result returned from the API is 10...
                                // So if length % 10 != 0 will be the last queue...
                                // We only send request if it have more data to load...
                                if self.specialOffersViewModel.allSpecialOffers.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.specialOffersViewModel.reLoadData()
                                }

                                // Otherwise just delete the ProgressView after 1 seconds...

                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowProgressView = false
                                }

                            }

                    } else {
                        GeometryReader { reader -> Color in
                            let minX = reader.frame(in: .global).maxX
                            let width = ScreenInfor().screenWidth / 1.3

                            if !self.specialOffersViewModel.allSpecialOffers.isEmpty && minX < width && specialOffersViewModel.allSpecialOffers.count >= Constants.MAX_NUM_API_LOAD {

                                DispatchQueue.main.async {
                                    self.specialOffersViewModel.fromIndex = self.specialOffersViewModel.allSpecialOffers.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                }.padding()
            }
            Spacer()
        }
        .padding(.top)
        .frame(height: 260)
    }
}

struct SpecialOfferCardView: View {
    
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    var voucherData: MerchantVoucherItemData
    var choosedIndex: Int
    
    var body: some View {
        VStack {
            URLImageView(url: voucherData.imageURL)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(height: 110)
                
            Spacer().frame(height: 5)
            
            Text("[\(voucherData.merchantName)] \(voucherData.name)")
                .font(.system(size: 10))
                .lineLimit(2)
                .padding(.horizontal, 7)
                .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            LoveAndCartCountView
            
            DiscountView
        }
        .frame(width: 150, height: 200)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: -3, y: 1))
    }
}

extension SpecialOfferCardView {
    
    var LoveAndCartCountView: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "suit.heart\(self.voucherData.employeeLikeThis ? ".fill" : "")")
                    .foregroundColor(.red)
                    .font(.system(size: 10))
                Text("\(voucherData.favoriteValue)")
                    .font(.system(size: 10))
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
                
            
            HStack(spacing: 2) {
                Image(systemName: "cart")
                    .foregroundColor(.blue)
                    .font(.system(size: 10))
                Text("\(voucherData.shoppingValue)")
                    .font(.system(size: 10))
            }
        }.padding(.horizontal, 7)
        .frame(width: 150, alignment: .leading)
    }
    
    var DiscountView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(voucherData.pointValue) VND")
                    .bold()
                    .foregroundColor(.blue)
                    .font(.system(size: 10))
                
                HStack(spacing: 3) {
                    Text("\(voucherData.moneyValue) VND")
                        .strikethrough()
                        .font(.system(size: 10))
                    
                    Text("\(voucherData.discountValue)%")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 7))
                        .padding(.init(top: 2, leading: 1, bottom: 2, trailing: 1))
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.orange))
                }
            }
            
            Spacer()
            
            Button(action: {
                self.confirmInforBuyViewModel.loadData(voucherId: voucherData.id)
                self.confirmInforBuyViewModel.isPresentedPopup = true
                
            }, label: {
                Text("buy".localized)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding(3)
                    .padding(.horizontal, 5)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.blue)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: -0.5, y: 0.5))
            })
        }.padding(.horizontal, 7)
        .padding(.bottom, 10)
    }
}

struct SpecialOffersView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialOffersView()
            .environmentObject(MerchantVoucherDetailViewModel())
            .environmentObject(MerchantVoucherSpecialListViewModel())
            
    }
}
