//
//  TransactionCardView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 15/11/2021.
//

import SwiftUI

struct TransactionCardView: View {
    
    var transactionType: Int
    var time: String
    var sourceName: String
    var point: Int
    
    
    var body: some View {
        HStack(spacing: 0) {

            Text(time).frame(width: 50)
                
            HStack {
                if transactionType == Constants.UsedPointsHistory.FROMBENEFIT || transactionType == Constants.UsedPointsHistory.FROMCOMPLIMENT {
                    Image("ic_fa_download")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                        .frame(width: 16, height: 16)
                } else {
                    Image("ic_fa_upload")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .frame(width: 16, height: 16)
                }
            }
            .frame(width: 50)
            
            
            TransactionContentView
//                .frame(width: 170, alignment: .leading)
            
            Spacer()
            
            Text(String(point))
                .bold()
                .foregroundColor(point > 0 ? Color.blue : Color.gray)
                .frame(width: 50)
            
        }
        .font(.system(size: 14))
        .frame(width: ScreenInfor().screenWidth * 0.8, alignment: .leading)
    }
    
    var TransactionContentView: some View {
        HStack {
            if transactionType == Constants.UsedPointsHistory.FROMCOMPLIMENT {
                TextContentView(text: "compliments_from".localized)
            } else if transactionType == Constants.UsedPointsHistory.TOCOMPLIMENT {
                TextContentView(text: "compliments_to".localized)
            } else if transactionType == Constants.UsedPointsHistory.FROMBENEFIT {
                TextContentView(text: "benefits_from".localized)
            } else if transactionType == Constants.UsedPointsHistory.TOVOUCHER {
                TextContentView(text: "voucher_at".localized)
            }
        }
    }
    
    @ViewBuilder
    func TextContentView(text: String) -> some View {
        HStack(spacing: 0) {
            Text("\(text.localized) **\(sourceName)**")
        }
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
        TransactionCardView(transactionType: 1, time: "10:23", sourceName: "i", point: 50)
        TransactionCardView(transactionType: 0, time: "10:23", sourceName: "Yudcdvvggvgvgvgscri", point: -500)
        }
    }
}
