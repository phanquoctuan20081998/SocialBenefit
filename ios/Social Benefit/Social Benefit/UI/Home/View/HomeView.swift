//
//  HomeView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 09/10/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @EnvironmentObject var internalNewsViewModel: InternalNewsViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: ScreenInfor().screenHeight * 0.1)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        MainCardView(personalPoint: homeViewModel.walletInfor.getPersonalPoint())
                            .padding()
                        
                        if isDisplayFunction(Constants.FuctionId.INTERNAL_NEWS) {
                            InternalNewsBannerView()
                        }
                        
                        if isDisplayFunction(Constants.FuctionId.COMPANY_BUDGET_POINT) {
                            RecognitionsBannerView()
                            PromotionsBannerView()
                        }
                    }.background(ScrollViewConfigurator {
                        $0?.bounces = false               // << here !!
                    })
                    Spacer()
                        .frame(height: 100)
                }
            }
            .background(BackgroundViewWithNotiAndSearch())
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                homeScreenViewModel.isPresentedTabBar = true
            }
        }
        .navigationBarHidden(true)
    }
}

struct ScrollViewConfigurator: UIViewRepresentable {
    let configure: (UIScrollView?) -> ()
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            configure(view.enclosingScrollView())
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

extension UIView {
    func enclosingScrollView() -> UIScrollView? {
        var next: UIView? = self
        repeat {
            next = next?.superview
            if let scrollview = next as? UIScrollView {
                return scrollview
            }
        } while next != nil
        return nil
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(selectedTab: "house")
    }
}
