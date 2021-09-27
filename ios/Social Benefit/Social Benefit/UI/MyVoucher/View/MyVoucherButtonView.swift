//
//  MyVoucherButtonView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 27/09/2021.
//

import SwiftUI

struct MyVoucherButtonView: View {
    var body: some View {
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
    }
}

struct MyVoucherButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MyVoucherButtonView()
    }
}
