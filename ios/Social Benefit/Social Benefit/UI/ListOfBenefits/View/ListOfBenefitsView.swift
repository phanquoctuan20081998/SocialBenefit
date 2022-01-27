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
    @State var selectedBenefit: Int = 0
    @State var selectedIndex: Int = 0
    @State var reload: Bool = false
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                Spacer().frame(height: ScreenInfor().screenHeight * 0.07)
                
                BenefitUpperView(isRefreshing: $listOfBenefitsViewModel.isRefreshing, isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, text: "benefit_title".localized, isShowTabBar: true)
                
                Rectangle()
                    .frame(width: ScreenInfor().screenWidth * 0.4, height: 1)
                    .foregroundColor(Color("nissho_blue"))
                    .padding(.bottom)
                
                HeaderView
                    .padding(.bottom)
                
                if listOfBenefitsViewModel.isLoading && !listOfBenefitsViewModel.isRefreshing {
                    LoadingPageView()
        
                } else {
                    TableView
                }
                
            }
            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
            .background(Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
        }
        .background(
            NavigationLink(
                destination: NavigationLazyView(BenefitDetailView()
                    .environmentObject(benefitDetailViewModel)
                    .environmentObject(listOfBenefitsViewModel)),
                isActive: $isTapDetail,
                label: {
                    EmptyView()
                })
        )
        
        .overlay(WarningMessageView(message: self.benefitDetailViewModel.errorCode, isPresented: $benefitDetailViewModel.isPresentError))
        .overlay(ApplyPopupView(reload: $listOfBenefitsViewModel.isRefreshing, benefitId: self.selectedBenefit, index: self.selectedIndex))

        .environmentObject(listOfBenefitsViewModel)
        .environmentObject(benefitDetailViewModel)
        .navigationBarHidden(true)
    }
    
}

extension ListOfBenefitsView {
    
    var HeaderView: some View {
        let scale = [0.17, 0.45, 0.20]
        let headers = ["", "benefit".localized, "benefit_status".localized]
        
        return HStack(spacing: 0) {
            
            ForEach(headers.indices, id: \.self) { i in
                Text(headers[i])
                    .bold()
                    .font(.system(size: 15))
                    .frame(width: ScreenInfor().screenWidth * CGFloat(scale[i]), height: 20, alignment: .leading)
                    .padding(.leading, 10)
            }
        }
        .padding(.vertical, 10)
        .frame(width: ScreenInfor().screenWidth)
        .background(
            Capsule()
                .fill(Color("nissho_blue"))
                .frame(width: ScreenInfor().screenWidth + 100)
                .offset(x: 60))
    }
    
    var TableView: some View {
        RefreshableScrollView(height: 70, refreshing: self.$listOfBenefitsViewModel.isRefreshing) {
            ForEach(listOfBenefitsViewModel.listOfBenefits.indices, id: \.self) { index in
                TableCellView(isPresentedApplyPopUp: $benefitDetailViewModel.isPresentedPopup, selectedBenefit: $selectedBenefit, selectedIndex: $selectedIndex, benefitData: listOfBenefitsViewModel.listOfBenefits[index], index: index)
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
    @Binding var isRefreshing: Bool
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
                    self.isRefreshing = true
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
                .frame(height: 60)
            
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
