//
//  AppliedStoreMerchantCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import SwiftUI

struct AppliedStoreMerchantCardView: View {
    
    var appliedStore: AppliedStoreMerchantListData
    var index: Int
    
    var body: some View {
        HStack {
            URLImageView(url: appliedStore.logo)
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(10)
            
            Spacer().frame(width: 5)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(appliedStore.fullName)
                    .bold()
                    .font(.system(size: 13))
                
                Text(appliedStore.fullAddress)
                    .italic()
                    .font(.system(size: 10))
                
                Text(appliedStore.hotlines)
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
            }.padding(.trailing)
            
        }.frame(width: ScreenInfor().screenWidth * 0.9, height: 80, alignment: .leading)
        .padding(5)
        .background(RoundedRectangle(cornerRadius: 20)
                        .fill(index % 2 == 0 ? Color.white : Color(#colorLiteral(red: 0.9621762633, green: 0.9767892957, blue: 0.9980991483, alpha: 1)))
                        .shadow(color: .black.opacity(0.2), radius: 10, x: -3, y: 1))
    }
}

struct AppliedStoreMerchantCardView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AppliedStoreMerchantCardView(appliedStore: AppliedStoreMerchantListData(id: 499, logo: "", fullName: "Liên Á Hà Nội", fullAddress: "23, Pội", hotlines: "09764545354"), index: 1)
            AppliedStoreMerchantCardView(appliedStore: AppliedStoreMerchantListData(id: 499, logo: "", fullName: "Liên Á Hà Nội", fullAddress: "23, Pội", hotlines: "09764545354"), index: 0)
        }
    }
}
