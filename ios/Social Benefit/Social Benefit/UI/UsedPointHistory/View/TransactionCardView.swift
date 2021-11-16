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
        HStack {
            Text(time)
                .font(.system(size: 14))
            
            Image("ic_fa_download")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.blue)
                .frame(width: 16, height: 16)
            
            
        }
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView(transactionType: 1, time: "10:23", sourceName: "Yuri", point: 50)
    }
}
