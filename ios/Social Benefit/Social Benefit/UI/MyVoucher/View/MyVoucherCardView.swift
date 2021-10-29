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
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(myVoucher.merchantName) | \(myVoucher.title)")
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                if myVoucher.status == 1 {
                    activeVoucherCardView
                } else if myVoucher.status == 2 {
                    usedVoucherCardView
                } else if myVoucher.status == 3 {
                    expriedVoucherCardView
                }
                
                
            }.frame(width: ScreenInfor().screenHeight * 0.3, height: 80, alignment: .topLeading)
        }
        .padding(.leading)
        .frame(width: ScreenInfor().screenWidth * 0.95, height: 100, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
    }
    
    // Active Voucher Card View...
    var activeVoucherCardView: some View {
        VStack(alignment: .leading) {
            Text("expriy".localized + ": " + getDate(myVoucher.expriedDate))
                .foregroundColor(.green)
                .font(.system(size: 13))
            
            Spacer(minLength: 5)
            
            HStack(spacing: 15) {
                Button(action: {
                    copyCodeButtonTapped()
                }, label: {
                    Text("copy".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 5)
                        .background(RoundedRectangle(cornerRadius: 6).fill(Color("nissho_blue")))
                    
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
    }
    
    // Used Voucher Card View...
    var usedVoucherCardView: some View {
        VStack(alignment: .leading) {
            Text("expriy".localized + ": " + getDate(myVoucher.expriedDate))
                .foregroundColor(.gray)
                .font(.system(size: 13))
            
            Spacer(minLength: 5)
            
            HStack(spacing: 15) {
                
                let isExpried = isExpried(myVoucher.expriedDate)
                
                Text("used".localized)
                    .font(.system(size: 13))
                
                Button(action: {
                    reBuyButtonTapped()
                }, label: {
                    Text("rebuy".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .padding(.vertical, 3)
                        .padding(.horizontal, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(isExpried ? Color.gray : Color("nissho_blue"))
                        )
                })
                //                .disabled(isExpried)
                
            }
        }
    }
    
    // Expried Voucher Card View...
    var expriedVoucherCardView: some View {
        VStack(alignment: .leading) {
            Text("expriy".localized + ": " + getDate(myVoucher.expriedDate))
                .foregroundColor(.red)
                .font(.system(size: 13))
            
            Spacer(minLength: 0)
        }
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
                myVoucherViewModel.isPresentedQRPopup = true
            }
        }
    }
    
    func reBuyButtonTapped() {
        myVoucherViewModel.isPresentedReBuyPopup = true
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
        ScrollView {
            VoucherCardView(isShowCopiedPopUp: .constant(false), myVoucher: MyVoucherData(id: 0, status: 2, voucherOrderId: 0, title: "bhjbhgdcdscsdcsdcsddcsdcsdsdcsdcscsdcscdvgvgvgbhj", cover: "", expriedDate: Date(), merchantName: "hbsvgvgvghvgvgbhjb"), selectedTab: 2)
            VoucherCardView(isShowCopiedPopUp: .constant(false), myVoucher: MyVoucherData(id: 0, status: 1, voucherOrderId: 0, title: "bhjbhgvgvgvgbhj", cover: "", expriedDate: Date(), merchantName: "hbsvgvgvghvgvgccxzczxczxczczxczxcbhjb"), selectedTab: 2)
            VoucherCardView(isShowCopiedPopUp: .constant(false), myVoucher: MyVoucherData(id: 0, status: 3, voucherOrderId: 0, title: "bhjbhgvgvgvgbhj", cover: "", expriedDate: Date(), merchantName: "hbsvgvgvghvgvgbhjb"), selectedTab: 2)
        }.background(Color.blue)
    }
}
