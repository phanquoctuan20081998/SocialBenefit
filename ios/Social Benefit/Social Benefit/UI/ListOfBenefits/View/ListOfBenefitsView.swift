//
//  ListOfBenefitView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 10/08/2021.
//

import SwiftUI

struct ListOfBenefitsView: View {

    @ObservedObject var listOfBenefitsViewModel = ListOfBenefitsViewModel()
    @State var isTapDetail: Bool = false
    @State var selectedBenefit = BenefitData()
    @Binding var isPresentedTabBar: Bool
    
    let header = ["order".localized, "benefit".localized, "benefit_status".localized]
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                Spacer(minLength: 50)
                
                BenefitUpperView(isPresentedTabBar: $isPresentedTabBar, isShowTabBar: true)
                
                //Add header
                let screen = ScreenInfor()
                HStack(spacing: 0) {
                    benefitText(text: header[0], scaleRatio: 5, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                    benefitText(text: header[1],scaleRatio: 2.5, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                    benefitText(text: header[2], scaleRatio: 3, width: screen.screenWidth - 22*2, isCenter: true, isItalic: false, isBold: true)
                }.frame(width: screen.screenWidth, alignment: .center)
                .padding(.all, 7)
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
                destination: BenefitDetailView(isPresentedTabBar: $isPresentedTabBar, selectedBenefit: self.selectedBenefit).navigationBarHidden(true),
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
            
            Text("benefit_title".localized)
                .font(.bold(.headline)())
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 10)
                .foregroundColor(.blue)
        }
    }
}


struct ListOfBenefitView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfBenefitsView(isPresentedTabBar: .constant(false))
    }
}
