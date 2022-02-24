//
//  MyVoucherButtonView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 27/09/2021.
//

import SwiftUI

struct MyVoucherButtonView: View {
    
    @State var isMoveToNextPage = false
    
    var body: some View {
        NavigationLink(destination: NavigationLazyView(MyVoucherView()),
                       isActive: $isMoveToNextPage,
                       label: {
            Button {
                self.isMoveToNextPage = true
                
                // Click count
                countClick()
            } label: {
                HStack(spacing: 5) {
                    Image("ic_my_voucher")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 27)
                    
                    Text("my_voucher".localized)
                        .font(.system(size: 9))
                        .frame(width: 45)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 7)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
            }
        })
    }
}

struct MyVoucherButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MyVoucherButtonView()
    }
}
