//
//  Test.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 23/09/2021.
//

import SwiftUI

struct Test: View {
    
    @ObservedObject var specialOffersViewModel = MerchantVoucherSpecialListViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 50) {
                        ForEach(self.specialOffersViewModel.allSpecialOffers.indices, id: \.self) { i in
                            NavigationLink(destination: Test2()
//                                            .navigationBarHidden(true)
                                            .environmentObject(specialOffersViewModel)) {
                                    SpecialOfferCardView(voucherData: self.specialOffersViewModel.allSpecialOffers[0], choosedIndex: 0)
                                        
//                                VStack {
//                                    Text("sbdkadabd")
//                                    Rectangle()
//                                }.background(RoundedRectangle(cornerRadius: 30)
//                                                    .fill(Color.gray)
//                                                    .frame(width: 100, height: 100))
                                }
                        }
                    }
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Button")
                })
                
            }.navigationBarHidden(true)
            .environmentObject(specialOffersViewModel)
        }
    }
}

struct Test2: View {
    
    @EnvironmentObject var specialOffersViewModel: MerchantVoucherSpecialListViewModel
    
    var body: some View {
        NavigationView {
            HStack {
                Text("lslsls")
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 20) {
//                        ForEach(self.specialOffersViewModel.allSpecialOffers.indices, id: \.self) { i in
                            NavigationLink(destination: Test().navigationBarHidden(true)) {
                                    SpecialOfferCardView(voucherData: self.specialOffersViewModel.allSpecialOffers[0], choosedIndex: 0)
                                }
//                        }
//                    }
//                }
            }.navigationBarHidden(true)
        }
    }
}
struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
