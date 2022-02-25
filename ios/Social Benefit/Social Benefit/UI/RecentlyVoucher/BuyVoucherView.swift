//
//  BuyVoucherView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 22/02/2022.
//

import SwiftUI
import CryptoKit

struct BuyVoucherView: View {
    
    @Binding var buyInforModel: BuyInforVoucherResultModel?
    
    @Binding var voucherId: Int?
    
    @State var numberOfVoucher = 1
    
    @State var inforText = ""
    
    @State var isLoading = false
    
    @State var error: AppError = .none
    
    private let service = BuyVoucher2Service()
    
    var body: some View {
        
        if buyInforModel != nil {
            VStack {
                VStack(spacing: 10) {
                    
                    //title
                    if buyInforModel?.inforStatus == .outOfStock {
                        Text(buyInforModel?.popupTitle ?? "")
                    } else if buyInforModel?.inforStatus == .ownedMaxVoucher {
                        VStack(spacing: 0) {
                            Text(buyInforModel?.popupTitle ?? "")
                                .multilineTextAlignment(.center)
                            (Text("(" + "max".localized + ": ")
                            + Text(buyInforModel?.maxCanBuyNumber?.string ?? "")
                                .bold()
                                .foregroundColor(Color.blue)
                            + Text(")"))
                                .multilineTextAlignment(.center)
                        }
                        
                    } else {
                        (Text(buyInforModel?.popupTitle ?? "")
                        + Text(" ")
                        + Text(Utils.formatPointText(point: buyInforModel?.remainPoint))
                            .bold()
                            .foregroundColor(Color.blue)
                        + Text(" ")
                        + Text(Utils.pointValueText(point: buyInforModel?.remainPoint)))
                            .multilineTextAlignment(.center)
                    }
                    
                    //content
                    if buyInforModel?.inforStatus != .canBuy {
                        if buyInforModel?.inforStatus == .notEnoughRemainPoint {
                            if let canUseNumber = buyInforModel?.canUseNumber, canUseNumber > 0 {
                                notEnoughPointMore(canUseNumber)
                            } else {
                                notEnoughPoint()
                            }
                        } else {
                            youCanUse()
                        }
                    } else {
                        if let canUseNumber = buyInforModel?.canUseNumber, canUseNumber > 0 {
                            wouldYouSpendMore(canUseNumber)
                        } else {
                            wouldYouSpend()
                        }
                        
                    }
                    
                    inputNumberOfVoucher()
                    
                    buttonBar()
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .onTapGesture {
                    
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.black.opacity(0.2))
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                buyInforModel = nil
            }
            .onAppear {
                numberOfVoucher = 1
                inforText = ""
                error = .none
                isLoading = false
            }
            .inforTextView($inforText)
            .loadingView(isLoading: $isLoading)
        }
    }
    
    var pointToPayValue: Int {
        return (buyInforModel?.voucherPoint ?? 0) * numberOfVoucher
    }
    
    @ViewBuilder
    func notEnoughPointMore(_ canUseNumber: Int) -> some View {
        (Text("you_not_enough_point_more1".localized)
        + Text(" ")
        + Text(canUseNumber.string)
        + Text(" ")
        + Text("you_not_enough_point_more2".localized)
        + Text(" ")
        + Text(Utils.formatPointText(point: pointToPayValue))
            .bold()
            .foregroundColor(Color.blue)
        + Text(" ")
        + Text(Utils.pointValueText(point: pointToPayValue))
        + Text(" ")
        + Text("you_not_enough_point_more3".localized))
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func notEnoughPoint() -> some View {
        (Text("you_not_enough_point1".localized)
        + Text(" ")
        + Text(Utils.formatPointText(point: pointToPayValue))
            .bold()
            .foregroundColor(Color.blue)
        + Text(" ")
        + Text(Utils.pointValueText(point: pointToPayValue))
        + Text(" ")
        + Text("you_not_enough_point2".localized))
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func youCanUse() -> some View {
        if let canUseNumber = buyInforModel?.canUseNumber, canUseNumber > 0 {
            (Text("you_can_use1".localized)
            + Text(" ")
            + Text(canUseNumber.string)
                .bold()
                .foregroundColor(Color.blue)
            + Text(" ")
            + Text("you_can_use2".localized))
                .multilineTextAlignment(.center)
        }
    }
    
    @ViewBuilder
    func wouldYouSpendMore(_ canUseNumber: Int) -> some View {
        (Text("would_you_spend_more1".localized)
        + Text(" ")
        + Text(canUseNumber.string)
            .bold()
            .foregroundColor(Color.blue)
        + Text(" ")
        + Text("would_you_spend_more2".localized)
        + Text(" ")
        + Text(Utils.formatPointText(point: pointToPayValue))
            .bold()
            .foregroundColor(Color.blue)
        + Text(" ")
        + Text(Utils.pointValueText(point: pointToPayValue))
        + Text(" ")
        + Text("would_you_spend_more3".localized))
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func wouldYouSpend() -> some View {
        (Text("would_you_spend1".localized)
        + Text(" ")
        + Text(Utils.formatPointText(point: pointToPayValue))
            .bold()
            .foregroundColor(Color.blue)
        + Text(" ")
        + Text(Utils.pointValueText(point: pointToPayValue))
        + Text(" ")
        + Text("would_you_spend2".localized))
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func inputNumberOfVoucher() -> some View {
        let voucherPoint = buyInforModel?.voucherPoint ?? 0
        let remainPoint = buyInforModel?.remainPoint ?? 0
        if buyInforModel?.inforStatus == .notEnoughRemainPoint || !maxCanBuy(1) || buyInforModel?.inforStatus == .outOfStock || voucherPoint * 2 > remainPoint || buyInforModel?.inforStatus == .ownedMaxVoucher || !checkOrderedNumber() {
            EmptyView()
        } else {
            HStack {
                Text("purchase_number".localized + ": ")
                    .font(.system(size: 15))
                
                HStack {
                    Button(action: {
                        self.numberOfVoucher -= 1
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                    })
                        .disabled(self.numberOfVoucher <= 1)
                        .frame(width: 30, height: 44)
                   
                    Text(numberOfVoucher.string)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 4).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    
                    Button(action: {
                        self.numberOfVoucher += 1
                        if self.numberOfVoucher == buyInforModel?.maxCanBuyNumber  {
                            inforText = "limit_bought_reached".localized
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                        .disabled(!canBuyMore())
                        .frame(width: 30, height: 44)
                }
            }
        }
    }
    
    func canBuyMore() -> Bool {
        if let maxCanBuyNumber = buyInforModel?.maxCanBuyNumber, numberOfVoucher < maxCanBuyNumber {
            return true
        }
        if buyInforModel?.maxCanBuyNumber == nil {
            return true
        }
        return false
    }
    
    func maxCanBuy(_ check: Int) -> Bool {
        if let maxCanBuyNumber = buyInforModel?.maxCanBuyNumber {
            if maxCanBuyNumber <= check {
                return false
            }
        }
        return true
    }
    
    func checkOrderedNumber() -> Bool {
        if let orderedNumber = buyInforModel?.orderedNumber, let maxCanBuyNumber = buyInforModel?.maxCanBuyNumber {
            if maxCanBuyNumber - orderedNumber < 2 {
                return false
            }
        }
        return true
    }
    
    @ViewBuilder
    func buttonBar() -> some View {
        if buyInforModel?.inforStatus == .notEnoughRemainPoint || buyInforModel?.inforStatus == .outOfStock || !maxCanBuy(0) || buyInforModel?.inforStatus == .ownedMaxVoucher {
            Button(action: {
                buyInforModel = nil
            }) {
                Text("close".localized)
                    .frame(width: 80, height: 40, alignment: .center)
            }
             .background(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
             .foregroundColor(Color.black)
             .cornerRadius(5)
        } else {
            HStack(alignment: .center, spacing: 20) {
                
                Button(action: {
                       requestBuyService()
                }) {
                    Text("yes".localized)
                        .frame(width: 80, height: 40, alignment: .center)
                }
                 .background(Color(#colorLiteral(red: 0.6876488924, green: 0.7895539403, blue: 0.9556769729, alpha: 1)))
                 .foregroundColor(Color.black)
                 .cornerRadius(5)
                
                Button(action: {
                    buyInforModel = nil
                }) {
                    Text("cancel".localized)
                        .frame(width: 80, height: 40, alignment: .center)
                }
                 .background(Color(#colorLiteral(red: 0.8058461547, green: 0.8604627252, blue: 0.8724408746, alpha: 1)))
                 .foregroundColor(Color.black)
                 .cornerRadius(5)
            }
        }
    }
    
    func requestBuyService() {
        isLoading = true
        service.request(voucherId: voucherId, number: numberOfVoucher, beforeBuyVoucherOrderCount: buyInforModel?.orderedNumber) { response in
            self.isLoading = false
            switch response {
            case .success(let value):
                if let errorCode = value.result?.errorCode {
                    inforText = errorCode.localized
                } else {
                    buyInforModel = nil
                }
            case .failure(let error):
                self.error = error
            }
        }
    }
    
}
