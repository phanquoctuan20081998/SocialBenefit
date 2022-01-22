//
//  MerchantLoadingView.swift
//  Social Benefit
//
//  Created by Tuan Phan Quoc on 20/01/2022.
//

import SwiftUI

struct MerchantLoadingView: View {
    var merchantName: String
    
    var body: some View {
        VStack {
            Spacer()
            ActivityRep()
                .frame(width: 50, height: 50)
            Text("you_are_being_redirected".localizeWithFormat(arguments: merchantName))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            Spacer()
        }
        .frame(width: ScreenInfor().screenWidth, height: ScreenInfor().screenHeight)
        .overlay(BackgroundViewWithoutNotiAndSearch(isActive: .constant(true), title: "", isHaveLogo: false))
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MerchantLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantLoadingView(merchantName: "VUI")
    }
}
