//
//  VoucherQRPopUpView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI

struct VoucherQRPopUpView: View {
    
    @EnvironmentObject var myVoucherViewModel: MyVoucherViewModel
    @State private var timeRemaining = 0
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if myVoucherViewModel.isPresentedPopup {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        myVoucherViewModel.isPresentedPopup = false
                    }
                PopUpContentView
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .foregroundColor(.black)
    }
}

extension VoucherQRPopUpView {
    
    var PopUpContentView: some View {
        VStack(spacing: 15) {
            QRCodeView(code: myVoucherViewModel.selectedVoucherCode.voucherCode)
            
            VStack(spacing: 8) {
                Text(myVoucherViewModel.selectedVoucherCode.voucherCode)
                    .font(.system(size: 20))
                Text("the_code_will_be_expried_after".localized + " \(timeRemaining) " + "(s)".localized)
            }.foregroundColor(.gray)
            
            Text("thank_you_for_using_our_service".localized)
                .bold()
        }.font(.system(size: 13))
        .frame(width: ScreenInfor().screenWidth * 0.7, height: 260)
        .background(
            RoundedRectangle(cornerRadius: 20)
               .fill(Color.white)
        )
        .onAppear {
            self.timeRemaining = myVoucherViewModel.selectedVoucherCode.remainTime
        }
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                myVoucherViewModel.isPresentedPopup = false
            }
        }
        
    }
}

struct VoucherQRPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherQRPopUpView()
            .environmentObject(MyVoucherViewModel())
    }
}
