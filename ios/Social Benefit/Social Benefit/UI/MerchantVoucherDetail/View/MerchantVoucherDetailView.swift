//
//  VoucherDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 24/09/2021.
//

import SwiftUI

struct MerchantVoucherDetailView: View {
    
    @EnvironmentObject var merchantVoucherDetailViewModel: MerchantVoucherDetailViewModel
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            VoucherHeadline
            InformationBar
            Rectangle().fill(Color.gray).frame(width: ScreenInfor().screenWidth * 0.9, height: 1)
            ScrollableTabView
        }
    }
}

extension MerchantVoucherDetailView {
    
    var VoucherHeadline: some View {
        
        let voucherDetail = merchantVoucherDetailViewModel.merchantVoucherDetail
        
        return VStack {
            
            Spacer().frame(height: 50)
            
            URLImageView(url: voucherDetail.imageURL)
                .frame(width: ScreenInfor().screenWidth * 0.9, height: 150)
                .padding(.bottom, 20)
            
            Text("[\(voucherDetail.merchantName)] \(voucherDetail.name)")
                .bold()
                .font(.system(size: 15))
                .frame(width: ScreenInfor().screenWidth * 0.9, alignment: .leading)
        }
        
    }
    
    var InformationBar: some View {
        
        let voucherDetail = merchantVoucherDetailViewModel.merchantVoucherDetail
        
        return HStack {
            HStack(spacing: 5) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "heart\(voucherDetail.employeeLikeThis ? ".fill" : "")")
                        .foregroundColor(.red)
                })
                Text(String(voucherDetail.favoriteValue))
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
            
            Spacer()
            
            HStack(spacing: 5) {
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                Text(voucherDetail.outOfDate)
            }
            
            Spacer()
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 2, height: 10)
                .padding(.horizontal, 5)
            
            HStack(spacing: 5) {
                Image(systemName: "dollarsign.circle")
                    .foregroundColor(.yellow)
                Text("\(voucherDetail.pointValue)")
            }
        }.font(.system(size: 13))
        .frame(width: ScreenInfor().screenWidth * 0.9)
    }
    
    var ScrollableTabView: some View {
        VStack {
            ScrollableTabBarView(offset: $offset)
 
            GeometryReader { proxy in
                ScrollableTabBar(tabs: Constants.VOUCHER_DETAIL_TAB, rect: proxy.frame(in: .global), offset: $offset) {
                    HStack(spacing: 0 ){
                        AppliedStoreView
                        AppliedStoreView
                        AppliedStoreView
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
    
    var InformationTabView: some View {
        let voucherDetail = merchantVoucherDetailViewModel.merchantVoucherDetail
        
        return ZStack(alignment: .topLeading) {
            HTMLText(html: voucherDetail.content)
                .font(.system(size: 20))
                .padding(30)
        }.frame(width: ScreenInfor().screenWidth * 0.9)
    }
    
    var AppliedStoreView: some View {
        
        let appliedStores = merchantVoucherDetailViewModel.appliedStoreMerchantList
        
        return VStack {
            ScrollView {
                Spacer().frame(height: 20)
                VStack(spacing: 10) {
                    ForEach(appliedStores.indices, id: \.self) { i in
                        AppliedStoreMerchantCardView(appliedStore: appliedStores[i], index: i)
                            .padding(.horizontal)
                    }
                }
                Spacer().frame(height: 20)
            }
        }
        .frame(width: ScreenInfor().screenWidth)
    }
}

struct ScrollableTabBarView: View {
    
    @Binding var offset: CGFloat
    @State var width: CGFloat = 0
    
    var body: some View {
        
        let equalWidth = (ScreenInfor().screenWidth * 0.9) / CGFloat(Constants.VOUCHER_DETAIL_TAB.count)
        
        DispatchQueue.main.async {
            self.width = equalWidth
        }
        
        return ZStack(alignment: .bottomLeading) {
            Capsule()
                .fill(Color.gray)
                .frame(width: equalWidth - 15, height: 1)
                .offset(x: getOffset() + 7, y: 4)
            
            HStack(spacing: 0) {
                ForEach(Constants.VOUCHER_DETAIL_TAB.indices, id: \.self) { index in
                    Text(Constants.VOUCHER_DETAIL_TAB[index])
                        .font(.system(size: 13))
                        .frame(width: equalWidth, height: 40)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                offset = ScreenInfor().screenWidth * CGFloat(index)
                            }
                        }
                }
            }.frame(width: ScreenInfor().screenWidth * 0.9)
        }
    }
    
    func getOffset() -> CGFloat {
        let progress = offset / ScreenInfor().screenWidth
        return progress * width
    }
}



struct VoucherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantVoucherDetailView()
            .environmentObject(MerchantVoucherDetailViewModel())
    }
}
