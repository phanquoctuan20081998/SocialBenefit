//
//  ListOfBenefitView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import SwiftUI

struct ListOfBenefitsView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    @ObservedObject var listOfBenefitsViewModel = ListOfBenefitsViewModel()
    @ObservedObject var benefitDetailViewModel = BenefitDetailViewModel()
    @State var isTapDetail: Bool = false 
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                Spacer().frame(height: ScreenInfor().screenHeight * 0.07)
                
                BenefitUpperView(isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, text: "benefit_title".localized, isShowTabBar: true)
                
                HeaderView
                
                if listOfBenefitsViewModel.isLoading && !listOfBenefitsViewModel.isRefreshing {
                    LoadingPageView()
        
                } else {
                    TableView
                }
                
            }.navigationBarHidden(true)
                .background(Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)))
                .edgesIgnoringSafeArea(.all)
        }
        .background(
            NavigationLink(
                destination: BenefitDetailView().navigationBarHidden(true)
                    .environmentObject(benefitDetailViewModel)
                    .environmentObject(listOfBenefitsViewModel),
                isActive: $isTapDetail,
                label: {
                    EmptyView()
                })
        )
        
        .overlay(WarningMessageView(message: self.benefitDetailViewModel.errorCode, isPresented: $benefitDetailViewModel.isPresentError))
        .overlay(ApplyPopupView())

        .environmentObject(listOfBenefitsViewModel)
        .environmentObject(benefitDetailViewModel)
    }
    
}

extension ListOfBenefitsView {
    
    var HeaderView: some View {
        let scale = [0.17, 0.6, 0.2]
        let headers = ["order".localized, "benefit".localized, "benefit_status".localized]
        
        return HStack(spacing: 0) {
            
            ForEach(headers.indices, id: \.self) { i in
                Text(headers[i])
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: ScreenInfor().screenWidth * CGFloat(scale[i]), height: 20)
            }
        }
        .padding(.vertical, 10)
        .frame(width: ScreenInfor().screenWidth)
        .background(Color(#colorLiteral(red: 0.6202182174, green: 0.7264552712, blue: 0.9265476465, alpha: 1)))
    }
    
    var TableView: some View {
        RefreshableScrollView(height: 70, refreshing: self.$listOfBenefitsViewModel.isRefreshing) {
            ForEach(listOfBenefitsViewModel.listOfBenefits.indices, id: \.self) { index in
                TableCellView(isPresentedApplyPopUp: $benefitDetailViewModel.isPresentedPopup, benefitData: listOfBenefitsViewModel.listOfBenefits[index])
                    .background(Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)))
                    .padding(.top, 7)
                    .onTapGesture {
                        self.benefitDetailViewModel.getData(benefit: listOfBenefitsViewModel.listOfBenefits[index], index: index)
                        self.isTapDetail = true
                        
                        // Click count
                        countClick(contentId: listOfBenefitsViewModel.listOfBenefits[index].id, contentType: Constants.ViewContent.TYPE_BENEFIT)
                    }
                Divider()
            }
        }
    }
}

struct BenefitUpperView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var isPresentedTabBar: Bool
    var text: String
    
    //Because 2 screen sharing this function...
    //But diffirent tabbar show status...
    var isShowTabBar: Bool
    
    var body: some View {
        VStack {
            HStack {
                //Add back button
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.isPresentedTabBar = isShowTabBar
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.leading, 20)
                })
            }.frame(width: ScreenInfor().screenWidth, height: 20, alignment: .leading)
            
            //Add title
            URLImageView(url: userInfor.companyLogo)
                .scaledToFit()
                .frame(height: 50)
            
            Text(text)
                .font(.bold(.headline)())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 15)
                .foregroundColor(.blue)
        }
    }
}


struct ListOfBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfBenefitsView()
            .environmentObject(ListOfBenefitsViewModel())
            .environmentObject(BenefitDetailViewModel())
            .environmentObject(HomeScreenViewModel())
    }
}
