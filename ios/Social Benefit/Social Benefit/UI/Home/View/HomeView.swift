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
    
    @State private var isPresentedSurvey = false
    
    @State private var isPresentedSurveyDetail = false
    
    @State private var surveyDetailId: Int?
    
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
                        
                        surveyList()
                        
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
                homeViewModel.loadWalletInfor()
                homeViewModel.requestHomeSurvey()
            }
            .errorPopup($homeViewModel.error)
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func surveyList() -> some View {
        if homeViewModel.showHomeSurvey() {
            VStack {
                
                TopTitleView.init(title: "survey".localized) {
                    self.isPresentedSurvey = true
                }
                
                Divider().frame(width: ScreenInfor().screenWidth * 0.9)
                
                Spacer().frame(height: 15)
                
                if #available(iOS 14.0, *) {
                    let rows = [
                        GridItem(.fixed(100)),
                        GridItem(.fixed(100)),
                    ]
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 10) {
                            ForEach(homeViewModel.listSurvey, id: \.self) { item in
                                HStack {
                                    HStack(alignment: .top, spacing: 10) {
                                        Image("survey_0909")
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .scaledToFit()
                                            .clipped()
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(item.deadlineText)
                                                .bold()
                                                .font(.system(size: 14))
                                            Text(item.surveyNameText)
                                                .font(.system(size: 14))
                                        }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    .padding(10)
                                    .background(Color.white)
                                }
                                .frame(width: ScreenInfor().screenWidth - 100, height: 100, alignment: .leading)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.init("nissho_blue"), lineWidth: 1))
                                .onTapGesture {
                                    surveyDetailId = item.id
                                    isPresentedSurveyDetail = true
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                }
            }
            .background(
                ZStack {
                    NavigationLink(
                        destination: NavigationLazyView(ListSurveyView()),
                        isActive: $isPresentedSurvey,
                        label: { EmptyView() })
                    
                    if let surveyDetailId = surveyDetailId {
                        NavigationLink(
                            destination: NavigationLazyView(SurveyDetailView.init(contentId: surveyDetailId)),
                            isActive: $isPresentedSurveyDetail,
                            label: { EmptyView() })
                    }
                    
                }
            )
        }
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

extension View {
    
    @ViewBuilder
    func showFullScreen<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        if #available(iOS 14.0, *) {
            self.fullScreenCover(isPresented: isPresented, onDismiss: onDismiss, content: content)
        }
    }
}
