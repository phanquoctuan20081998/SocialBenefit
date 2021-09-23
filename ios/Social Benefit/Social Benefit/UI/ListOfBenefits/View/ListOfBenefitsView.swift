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
    @State var isTapDetail: Bool = false
    @State var selectedBenefit = BenefitData()
    
    let headers = ["order".localized, "benefit".localized, "benefit_status".localized]
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                Spacer(minLength: 50)
                
                BenefitUpperView(isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar, text: "benefit_title".localized, isShowTabBar: true)
                
                //Add header
                let scale = [0.17, 0.6, 0.2]
                
                HStack(spacing: 0) {
                    
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
                
                //Add tabble view
                ScrollView {
                    ForEach(listOfBenefitsViewModel.listOfBenefits, id: \.self) { item in
                        TableCellView(benefitData: item)
                            .background(Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)))
                            .padding(.top, 7)
                            .onTapGesture {
                                self.isTapDetail = true
                                self.selectedBenefit = item
                            }
                        Divider()
                    }
                }
            }.navigationBarHidden(true)
            .background(Color(#colorLiteral(red: 0.8640524745, green: 0.9024624825, blue: 0.979608953, alpha: 1)))
            .edgesIgnoringSafeArea(.all)
        }
        .background(
            NavigationLink(
                destination: BenefitDetailView(isPresentedTabBar: $homeScreenViewModel.isPresentedTabBar,
                                               benefitDetailViewModel: BenefitDetailViewModel(benefit: self.selectedBenefit)).navigationBarHidden(true),
                isActive: $isTapDetail,
                label: {
                    EmptyView()
                })
        )
        .environmentObject(listOfBenefitsViewModel)
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
                .padding(.leading, -140)
                
                
                //Add logo
                URLImageView(url: userInfor.companyLogo)
                    .frame(height: 50)
                    .padding()
            }
            //Add title
            
            Text(text)
                .font(.bold(.headline)())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 15)
                .foregroundColor(.blue)
        }
    }
}


struct ListOfBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfBenefitsView()
    }
}
