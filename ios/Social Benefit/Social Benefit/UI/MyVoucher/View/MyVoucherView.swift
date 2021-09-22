//
//  MyVoucherView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/09/2021.
//

import SwiftUI

struct VOUCHER_TAB {
    var ALL = 0
    var ACTIVE = 1
    var USED = 2
    var EXPIRED = 3
}

let TABHEADER = ["all", "active", "used", "expried"]

struct MyVoucherView: View {
    
    @ObservedObject var myVoucherViewModel = MyVoucherViewModel()
    
    var body: some View {
        VStack {
            TabView
            VoucherListView
            
        }.environmentObject(myVoucherViewModel)
    }
}

extension MyVoucherView {
    
    var TabView: some View {
        HStack(spacing: 0) {
            ForEach(TABHEADER.indices, id:\.self) { i in
                Text(TABHEADER[i].localized)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor((myVoucherViewModel.status == i) ? Color(#colorLiteral(red: 0.5607333779, green: 0.5608169436, blue: 0.5607150793, alpha: 1)) : Color(#colorLiteral(red: 0.2199586034, green: 0.4942095876, blue: 0.9028041363, alpha: 1)))
                    .frame(width: ScreenInfor().screenWidth / CGFloat(TABHEADER.count), height: 30)
                    .background((myVoucherViewModel.status == i) ? Color(#colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)) : Color(#colorLiteral(red: 0.8864943981, green: 0.9303048253, blue: 0.9857663512, alpha: 1)))
                    .onTapGesture {
                        withAnimation {
                            myVoucherViewModel.status = i
                        }
                    }
            }
        }.frame(width: ScreenInfor().screenWidth)
        .background(Color.white)
    }
    
    var VoucherListView: some View {
        VStack(spacing: 20) {
            ScrollView {
                ForEach(myVoucherViewModel.allMyVoucher.indices, id: \.self) {i in
                    VoucherCardView(myVoucher: myVoucherViewModel.allMyVoucher[i], selectedTab: myVoucherViewModel.status)
                }
            }
        }
    }
}

struct VoucherCardView: View {
    
    var myVoucher: MyVoucherData
    var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 15) {
            URLImageView(url: myVoucher.cover)
            
            VStack(spacing: 15) {
                Text("\(myVoucher.merchantName) | \(myVoucher.title)")
                
                Text("expriy %s".localizeWithFormat(arguments: getDate(myVoucher.expriedDate)))
                    .foregroundColor(isExpried(myVoucher.expriedDate) ? .red : .green)
                
                if selectedTab == VOUCHER_TAB().ACTIVE {
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Text("copy".localized)
                        })
                    }
                }
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
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return ""
        }
    }
    
    func isExpried(_ day: Date) -> Bool {
        return Calendar.current.isDateInToday(day)
    }
}

struct MyVoucherView_Previews: PreviewProvider {
    static var previews: some View {
        MyVoucherView()
            .environmentObject(MyVoucherViewModel())
    }
}
