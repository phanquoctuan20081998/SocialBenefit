//
//  BuyVoucherPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 20/09/2021.
//

import SwiftUI

struct BuyVoucherPopUp: View {
    
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    
    @State var buyNumber = 1
    
    @Binding var isPresentPopUp: Bool
    @Binding var isReloadSpecialVoucher: Bool
    @Binding var isReloadAllVoucher: Bool
    
    
    var body: some View {
        ZStack {
            if self.confirmInforBuyViewModel.isPresentedPopup {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.confirmInforBuyViewModel.isPresentedPopup = false
                        self.buyNumber = 1
                    }
                
                if self.confirmInforBuyViewModel.isLoading {
                    VStack {
                        Spacer()
                        LoadingPageView()
                        Spacer()
                    }
                    .frame(width: ScreenInfor().screenWidth * 0.7, height: 120)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                    
                } else {
                    if confirmInforBuyViewModel.buyVoucher.remainVoucherInStock == 0 {
                        outOfStockContent
                    } else {
                        popupContent
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .foregroundColor(.black)
    }
}

extension BuyVoucherPopUp {
    
    var outOfStockContent: some View {
        VStack(spacing: 20) {
            Text("voucher_is_out_of_stock".localized)
            
            Button(action: {
                self.confirmInforBuyViewModel.isPresentedPopup = false
            }, label: {
                Text("cancel".localized)
                    .foregroundColor(.black)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
                                    .frame(width: 80))
            })
        }
        .frame(width: ScreenInfor().screenWidth * 0.7, height: 120)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
        )
    }
    
    var popupContent: some View {
        VStack() {
            VStack(spacing: 2) {
                
                HStack {
                    Text("you_are_having".localized)
                    + Text(" \(confirmInforBuyViewModel.walletInfor.getPersonalPoint()) ")
                        .bold()
                        .foregroundColor(.blue)
                    + Text(getPointStringOnly(point: confirmInforBuyViewModel.walletInfor.getPersonalPoint()))
                }.multilineTextAlignment(.center)
                
                HStack {
                    Text("\("would_like_to_spend".localized)")
                    + Text(" \(confirmInforBuyViewModel.buyVoucher.voucherPoint ?? 0) ")
                        .bold()
                        .foregroundColor(.blue)
                    + Text(getPointStringOnly(point: confirmInforBuyViewModel.walletInfor.getPersonalPoint()))
                    + Text(" ")
                    + Text("to_buy_this_voucher".localized)
                    + Text("?")
                }
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                
            }.font(.system(size: 15))
                .padding()
            
            let checkMax = (confirmInforBuyViewModel.buyVoucher.maxCanBuyNumber == -1) ? false : (self.buyNumber >= confirmInforBuyViewModel.buyVoucher.maxCanBuyNumber!)
            
            HStack {
                Text("purchase_number".localized + ": ")
                    .font(.system(size: 15))
                
                HStack {
                    Button(action: {
                        self.buyNumber -= 1
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor((self.buyNumber <= 1) ? .gray : .blue)
                    }).disabled(self.buyNumber <= 1)
                    
                    
                    TextField("", text: Binding (
                        get: { String(buyNumber) },
                        set: { buyNumber = Int($0) ?? 0 }
                    )).keyboardType(.numberPad)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 20)
                    
                    
                    Button(action: {
                        self.buyNumber += 1
                    }, label: {
                        // Check if buy number is larger than maximun voucher can buy
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(checkMax ? .gray : .blue)
                    }).disabled(checkMax)
                }
            }
            
            if checkMax {
                Text("reach_maximum".localized)
                    .font(.system(size: 10))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .frame(width: ScreenInfor().screenWidth * 0.5, height: 30)
            }
            
            Spacer()
            
            HStack {
                HStack(spacing: 50) {
                    Button(action: {
                        BuyVoucherService().getAPI(voucherId: self.confirmInforBuyViewModel.voucherId, number: self.buyNumber, beforeBuyVoucherOrderCount: confirmInforBuyViewModel.buyVoucher.orderedNumber ?? 0) { data in
                            DispatchQueue.main.async {
                                self.confirmInforBuyViewModel.buyVoucherResponse = data
                                if !data.errorCode.isEmpty {
                                    confirmInforBuyViewModel.isPresentedError = true
                                } else {
                                    self.isReloadSpecialVoucher = true
                                    self.isReloadAllVoucher = true
                                }
                            }
                        }
                        
                        //                        self.confirmInforBuyViewModel.isPresentedPopup = false
                        self.isPresentPopUp = false
                        self.buyNumber = 1
                        
                    }, label: {
                        Text("yes".localized)
                            .foregroundColor(.black)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill((self.buyNumber < 1) ? Color(.gray).opacity(0.2) : Color(#colorLiteral(red: 0.6876488924, green: 0.7895539403, blue: 0.9556769729, alpha: 1)))
                                            .frame(width: 80))
                        
                    }).disabled(self.buyNumber < 1)
                    
                    
                    Button(action: {
                        //                        self.confirmInforBuyViewModel.isPresentedPopup = false
                        self.isPresentPopUp = false
                        self.buyNumber = 1
                    }, label: {
                        Text("cancel".localized)
                            .foregroundColor(.black)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
                                            .frame(width: 80))
                    })
                }.foregroundColor(.blue)
                    .padding(5)
            }
        }.padding()
            .frame(width: ScreenInfor().screenWidth * 0.8, height: 205)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
            )
    }
    
    func getIndex(in array: [MerchantVoucherItemData], value: Int) -> Int {
        if let index = array.firstIndex(where: { $0.id == value }) {
            return index
        }
        
        return -1
    }
}

struct BuyVoucherPopUp_Previews: PreviewProvider {
    static var previews: some View {
        BuyVoucherPopUp(isPresentPopUp: .constant(true), isReloadSpecialVoucher: .constant(true), isReloadAllVoucher: .constant(true))
            .environmentObject(ConfirmInforBuyViewModel())
            .environmentObject(MerchantVoucherSpecialListViewModel())
            .environmentObject(MerchantVoucherListByCategoryViewModel())
    }
}

