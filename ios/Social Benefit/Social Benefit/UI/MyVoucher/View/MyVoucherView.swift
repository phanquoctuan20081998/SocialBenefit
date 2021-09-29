//
//  MyVoucherView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 22/09/2021.
//

import SwiftUI
import MobileCoreServices

struct VOUCHER_TAB {
    var ALL = 0
    var ACTIVE = 1
    var USED = 2
    var EXPIRED = 3
}


struct MyVoucherView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @ObservedObject var myVoucherViewModel = MyVoucherViewModel()
    
    @State var isShowCopiedPopUp = false
    
    //Infinite ScrollView controller
    @State var isShowProgressView: Bool = false
    
    
    var body: some View {
        VStack {
            Spacer().frame(height: 40)
            
            SearchView
            
            VStack {
                TabView
                VoucherListView
            }.background(Color(#colorLiteral(red: 0.8864943981, green: 0.9303048253, blue: 0.9857663512, alpha: 1)))
            .edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            homeScreenViewModel.isPresentedTabBar = false
        }
        .background(BackgroundViewWithoutNotiAndSearch(isActive: $homeScreenViewModel.isPresentedTabBar, title: "my_vouchers".localized, isHaveLogo: true))
        
        //Pop-up overlay
        .overlay(SuccessedMessageView(successedMessage: "copied_to_clipboard".localized, isPresented: $isShowCopiedPopUp))
        .overlay(VoucherQRPopUpView(isPresentedPopup: $myVoucherViewModel.isPresentedPopup, voucher: myVoucherViewModel.selectedVoucherCode))
        
        .environmentObject(myVoucherViewModel)
    }
}

extension MyVoucherView {
    
    var SearchView: some View {
        SearchBarView(searchText: $myVoucherViewModel.searchPattern, isSearching: $myVoucherViewModel.isSearching, placeHolder: "search_your_voucher".localized, width: ScreenInfor().screenWidth * 0.9, height: 50, fontSize: 13, isShowCancelButton: true)
            .font(.system(size: 13))
    }
    
    var TabView: some View {
        HStack(spacing: 0) {
            ForEach(Constants.TABHEADER.indices, id:\.self) { i in
                Text(Constants.TABHEADER[i].localized)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor((myVoucherViewModel.status == i) ? Color(#colorLiteral(red: 0.2199586034, green: 0.4942095876, blue: 0.9028041363, alpha: 1)) : Color(#colorLiteral(red: 0.5607333779, green: 0.5608169436, blue: 0.5607150793, alpha: 1)))
                    .frame(width: ScreenInfor().screenWidth / CGFloat(Constants.TABHEADER.count), height: 30)
                    .background((myVoucherViewModel.status == i) ? Color(#colorLiteral(red: 0.8864943981, green: 0.9303048253, blue: 0.9857663512, alpha: 1)) : Color(#colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)))
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
        VStack {
            Spacer().frame(height: 15)
            ScrollView {
                VStack(spacing: 15) {
                    if myVoucherViewModel.allMyVoucher.isEmpty {
                        Text("no_voucher".localized).font(.system(size: 13))
                    }
                    ForEach(myVoucherViewModel.allMyVoucher.indices, id: \.self) {i in
                        NavigationLink(
                            destination: MerchantVoucherDetailView(voucherId: myVoucherViewModel.allMyVoucher[i].id),
                            label: {
                                VoucherCardView(isShowCopiedPopUp: $isShowCopiedPopUp, myVoucher: myVoucherViewModel.allMyVoucher[i], selectedTab: myVoucherViewModel.status)
                                    .foregroundColor(Color.black)
                            })
                    }
                    
                    //Infinite Scroll View

                    if (myVoucherViewModel.fromIndex == myVoucherViewModel.allMyVoucher.count && self.isShowProgressView) {

                        ActivityIndicator(isAnimating: true)
                            .onAppear {

                                // Because the maximum length of the result returned from the API is 10...
                                // So if length % 10 != 0 will be the last queue...
                                // We only send request if it have more data to load...
                                if self.myVoucherViewModel.allMyVoucher.count % Constants.MAX_NUM_API_LOAD == 0 {
                                    self.myVoucherViewModel.reloadData()
                                }

                                // Otherwise just delete the ProgressView after 1 seconds...

                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowProgressView = false
                                }

                            }

                    } else {
                        GeometryReader { reader -> Color in
                            let minY = reader.frame(in: .global).minY
                            let height = ScreenInfor().screenHeight / 1.3

                            if !self.myVoucherViewModel.allMyVoucher.isEmpty && minY < height && myVoucherViewModel.allMyVoucher.count >= Constants.MAX_NUM_API_LOAD  {

                                DispatchQueue.main.async {
                                    self.myVoucherViewModel.fromIndex = self.myVoucherViewModel.allMyVoucher.count
                                    self.isShowProgressView = true
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                }
            }
            Spacer().frame(height: 15)
        }
    }
}

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

struct MyVoucherView_Previews: PreviewProvider {
    static var previews: some View {
        MyVoucherView()
            .environmentObject(HomeScreenViewModel())
            .environmentObject(MyVoucherViewModel())
    }
}
