//
//  VoucherQRPopUpView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI

let QRTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

struct VoucherQRPopUpView: View {
    
    @Binding var isPresentedPopup: Bool
    @State private var timeRemaining = 0
    var voucher: VoucherCodeData
    
    var body: some View {
        ZStack {
            if isPresentedPopup {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresentedPopup = false
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
            QRCodeView(code: voucher.voucherCode)
            
            VStack(spacing: 8) {
                Text(voucher.voucherCode)
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
            self.timeRemaining = voucher.remainTime
        }
        .onReceive(QRTimer) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                isPresentedPopup = false
            }
        }
        
    }
}

struct VoucherQRPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherQRPopUpView(isPresentedPopup: .constant(true), voucher: VoucherCodeData(voucherCode: "QTSGSJ", remainTime: 176))

            .environmentObject(MyVoucherViewModel())
    }
}
