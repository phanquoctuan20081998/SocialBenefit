//
//  MyVoucherCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/10/2021.
//

import SwiftUI
import MobileCoreServices

struct VoucherCardView: View {
    
    @EnvironmentObject var myVoucherViewModel: MyVoucherViewModel
    @Binding var isShowCopiedPopUp: Bool
    
    var myVoucher: MyVoucherData
    var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 15) {
            
            URLImageView(url: myVoucher.cover)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(myVoucher.merchantName) | \(myVoucher.title)")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                
                Text("expriy".localized + ": " + getDate(myVoucher.expriedDate))
                    .foregroundColor(isExpried(myVoucher.expriedDate) ? .red : .green)
                    .font(.system(size: 13))
                
                Spacer(minLength: 0)
                
                if !isExpried(myVoucher.expriedDate) {
                    HStack(spacing: 15) {
                        Button(action: {
                            copyCodeButtonTapped()
                        }, label: {
                            Text("copy".localized)
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                                .padding(.vertical, 3)
                                .padding(.horizontal, 5)
                                .background(RoundedRectangle(cornerRadius: 6).fill(Color(#colorLiteral(red: 0.680760622, green: 0.7776962519, blue: 0.9396142364, alpha: 1))))
                            
                        })
                        
                        Button(action: {
                            QRButtonTapped()
                            
                        }, label: {
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .foregroundColor(.black)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        })
                    }
                }
                
            }.frame(width: ScreenInfor().screenHeight * 0.3, height: 70, alignment: .topLeading)
        }
        .frame(width: ScreenInfor().screenWidth * 0.95, height: 100)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
    }
    
    func copyCodeButtonTapped() {
        myVoucherViewModel.generateCodeService.getAPI(voucherId: myVoucher.id, voucherOrderId: myVoucher.voucherOrderId) { data in
            DispatchQueue.main.async {
                myVoucherViewModel.selectedVoucherCode = data
                UIPasteboard.general.setValue(myVoucherViewModel.selectedVoucherCode.voucherCode, forPasteboardType: kUTTypePlainText as String)
                self.isShowCopiedPopUp = true
            }
        }
    }
    
    func QRButtonTapped() {
        myVoucherViewModel.generateCodeService.getAPI(voucherId: myVoucher.id, voucherOrderId: myVoucher.voucherOrderId) { data in
            DispatchQueue.main.async {
                myVoucherViewModel.selectedVoucherCode = data
                myVoucherViewModel.isPresentedPopup = true
            }
        }
    }
    
    func getDate(_ day: Date) -> String {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: day)
        let day = components.day!
        let month = components.month!
        let year = components.year!
        
        return "\(day) \(getMonthInText(month)) \(year)"
    }
    
    func getMonthInText(_ month: Int) -> String {
        switch month {
        case 1:
            return "january".localized
        case 2:
            return "february".localized
        case 3:
            return "march".localized
        case 4:
            return "april".localized
        case 5:
            return "may".localized
        case 6:
            return "june".localized
        case 7:
            return "july".localized
        case 8:
            return "august".localized
        case 9:
            return "september".localized
        case 10:
            return "october".localized
        case 11:
            return "november".localized
        case 12:
            return "december".localized
        default:
            return ""
        }
    }
    
    func isExpried(_ day: Date) -> Bool {
        if day >= Date() {
            return false
        }
        return true
    }
}


struct MyVoucherCardView_Previews: PreviewProvider {
    static var previews: some View {
        VoucherCardView(isShowCopiedPopUp: .constant(false), myVoucher: MyVoucherData(id: 0, voucherOrderId: 0, title: "bhjbhgvgvgvgbhj", cover: "", expriedDate: Date(), merchantName: "hbsvgvgvghvgvgvghvgvvbhbhjb"), selectedTab: 2)
    }
}
