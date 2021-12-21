//
//  BottomButtonView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 28/09/2021.
//

import SwiftUI
import MobileCoreServices

struct BottomButtonView: View {
    
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
//    @EnvironmentObject var myVoucherViewModel: MyVoucherViewModel
    
    private let generateCodeService = GenerateCodeService()
    
    var body: some View {
        HStack(spacing: 30) {
            if merchantVoucherDetailViewModel.isBuy {
                ButtonView(image: "square.and.arrow.up.on.square", text: "share/copy".localized)
                    .onTapGesture {
                        copyCodeButtonTapped()
                        
                        // Click count
                        countClick(contentId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                    }
                ButtonView(image: "qrcode", text: "qrcode".localized)
                    .onTapGesture {
                        QRButtonTapped()
                        
                        // Click count
                        countClick(contentId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                    }
            }
            
            if !merchantVoucherDetailViewModel.isOutOfStock {
                ButtonView(image: "cart.fill", text: "buy_more".localized)
                    .onTapGesture {
                        self.confirmInforBuyViewModel.loadData(voucherId: merchantVoucherDetailViewModel.merchantVoucherDetail.id)
                        self.confirmInforBuyViewModel.isPresentedPopup = true
                        
                        // Click count
                        countClick(contentId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, contentType: Constants.ViewContent.TYPE_VOUCHER)
                    }
            }
        }
    }
    
    @ViewBuilder func ButtonView(image: String, text: String) -> some View {
        VStack(spacing: 5) {
            
            Circle()
                .strokeBorder(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(Image(systemName: image)
                            .font(.system(size: 15))
                            .foregroundColor(.blue))

            Text(text)
                .foregroundColor(.blue)
                .font(.system(size: 13))
        }
    }
    
    func copyCodeButtonTapped() {
        generateCodeService.getAPI(voucherId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, voucherOrderId: -1) { data in
            DispatchQueue.main.async {
                merchantVoucherDetailViewModel.QRData = data
                UIPasteboard.general.setValue(data.voucherCode, forPasteboardType: kUTTypePlainText as String)
                self.merchantVoucherDetailViewModel.isShowCopiedPopUp = true
            }
        }
    }

    func QRButtonTapped() {
        generateCodeService.getAPI(voucherId: merchantVoucherDetailViewModel.merchantVoucherDetail.id, voucherOrderId: -1) { data in
            DispatchQueue.main.async {
                merchantVoucherDetailViewModel.QRData = data
                merchantVoucherDetailViewModel.isShowQRPopUp = true
            }
        }
    }
}

struct BottomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BottomButtonView()
    }
}
