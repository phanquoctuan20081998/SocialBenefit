//
//  SpecialOffersView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 14/09/2021.
//

import SwiftUI

struct SpecialOffersView: View {
    
    @ObservedObject var specialOffersViewModel = SpecialOffersViewModel(searchPattern: "", fromIndex: -1, categoryid: -1)

    var body: some View {
        HStack {
            ScrollView {
                ForEach(self.specialOffersViewModel.allSpecialOffers, id: \.self) { item in
                    SpecialOfferCardView(voucherData: item)
                }
            }
        }.environmentObject(specialOffersViewModel)
    }
}

struct SpecialOfferCardView: View {
    
    var voucherData: MerchantVoucherItemData
    
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
                        .shadow(color: .black.opacity(0.2), radius: 10, x: -3, y: 7))
    }
}

extension SpecialOfferCardView {
    
    var LoveAndCartCountView: some View {
        HStack {
            HStack(spacing: 2) {
                Image(systemName: "suit.heart")
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
                
                HStack {
                    Text("\(voucherData.moneyValue) VND")
                        .strikethrough()
                        .font(.system(size: 10))
                    
                    Text("\(voucherData.discountValue)%")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 7))
                        .padding(2)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color.orange))
                }
            }
            
            Spacer()
            
            Button(action: {
                
                
            }, label: {
                Text("buy".localized)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding(3)
                    .padding(.horizontal, 5)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .shadow(color: .black.opacity(0.2), radius: 2, x: -0.5, y: 0.5))
            })
        }.padding(.horizontal, 7)
        .padding(.bottom, 10)
    }
}

struct SpecialOffersView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialOfferCardView(voucherData: MerchantVoucherItemData(id: 0, voucherCode: 0, imageURL:  "/files/4194/bee.gif", name: "Test", merchantName: "Toyota", content: "fsdfs", favoriteValue: 3, outOfDateValue: Date(), shoppingValue: 5, pointValue: 30000, moneyValue: 50000, discountValue: -10, categoryId: 1, merchantId: 1, employeeLikeThis: true))
    }
}
