//
//  BuyVoucherPopUp.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 20/09/2021.
//

import SwiftUI

struct BuyVoucherPopUp: View {
    
    @EnvironmentObject var confirmInforBuyViewModel: ConfirmInforBuyViewModel
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    @EnvironmentObject var offersViewModel: MerchantVoucherListByCategoryViewModel
    
    @State var buyNumber = 1
    
    var body: some View {
        ZStack {
            if self.confirmInforBuyViewModel.isPresentedPopup {
                Color.black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.confirmInforBuyViewModel.isPresentedPopup = false
                    }
                
                if confirmInforBuyViewModel.buyVoucher.remainVoucherInStock == 0 {
                    outOfStockContent
                } else {
                    popupContent
                        
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
                Text("buy_button_notification %d".localizeWithFormat(arguments: 3))
                Text("buy_more".localized)
            }.font(.system(size: 15))
            .padding()
            
            HStack {
                Text("purchase_number".localized)
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
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    })
                }
            }
            
            Spacer()
            
            HStack {
                HStack(spacing: 20) {
                    Button(action: {
                        BuyVoucherService().getAPI(voucherId: self.confirmInforBuyViewModel.voucherId, number: self.buyNumber) { data in
                            DispatchQueue.main.async {
                                self.confirmInforBuyViewModel.buyVoucherResponse = data
                                if !data.errorCode.isEmpty {
                                    confirmInforBuyViewModel.isPresentedError = true
                                } else {
                                    let choosedIndex1 = getIndex(in: specialOffersViewModel.allSpecialOffers, value: confirmInforBuyViewModel.voucherId)
                                        
                                    self.specialOffersViewModel.allSpecialOffers[choosedIndex1].shoppingValue += self.buyNumber
                                    
                                    let choosedIndex2 = getIndex(in: offersViewModel.allOffers, value: confirmInforBuyViewModel.voucherId)
                                        
                                    self.offersViewModel.allOffers[choosedIndex2].shoppingValue += self.buyNumber
                                }
                            }
                        }
                        
                        self.confirmInforBuyViewModel.isPresentedPopup = false
                        
                                                                        
                    }, label: {
                        Text("yes".localized)
                            .foregroundColor(.black)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill((self.buyNumber < 1) ? Color(.gray).opacity(0.2) : Color(#colorLiteral(red: 0.6876488924, green: 0.7895539403, blue: 0.9556769729, alpha: 1)))
                                            .frame(width: 80))
                        
                    }).disabled(self.buyNumber < 1)
                    
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
                }.foregroundColor(.blue)
                .padding(5)
            }
        }.padding()
        .frame(width: ScreenInfor().screenWidth * 0.8, height: 200)
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
        BuyVoucherPopUp()
            .environmentObject(ConfirmInforBuyViewModel())
    }
}

