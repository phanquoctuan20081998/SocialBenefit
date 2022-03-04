//
//  OnboardView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 01/03/2022.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        if viewModel.error == .none {
            
            VStack {
                if #available(iOS 14.0, *) {
                    TabView(selection: $viewModel.currentPage) {
                        ForEach(viewModel.list.indices, id: \.self) { index in
                            subPageView(item: viewModel.list[index])
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .id(viewModel.list.count)
                } else {
                    TabView(selection: $viewModel.currentPage) {
                        ForEach(viewModel.list) { item in
                            subPageView(item: item)
                        }
                    }
                    .background(Color.white)
                }
                
                HStack(alignment: .center, spacing: 20) {
                    UIPageControlRep.init(currentPage: $viewModel.currentPage, numberOfPages: viewModel.list.count)
                        .fixedSize()
                    Spacer()
                    if viewModel.currentPage == viewModel.list.count - 1 {
                        Button.init {
                            UserDefaults.setShowOnboarding(value: true)
                            Utils.setLoginIsRoot()
                        } label: {
                            Text("start".localized)
                                .font(Font.system(size: 14))
                                .padding(10)
                                .background(Color.init("nissho_blue"))
                        }
                    } else {
                        Button.init {
                            withAnimation {
                                viewModel.currentPage += 1
                            }
                        } label: {
                            Text("skip".localized)
                                .font(Font.system(size: 14))
                                .padding(10)
                        }
                    }

                }
                .padding(20)
                .frame(height: 70)
            }
            .background(Color.white)
            
        } else {
            VStack(spacing: 20) {
                Text(viewModel.error.text)
                Button.init {
                    viewModel.request()
                } label: {
                    Image.init(systemName: "arrow.clockwise")
                        .font(Font.system(size: 30))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
        }
    }
    
    @ViewBuilder
    func subPageView(item: OnboardingResultModel) -> some View {
        VStack(spacing: 20) {
            URLImageView.init(url: Config.webAdminURL + (item.image_url ?? ""))
                .scaledToFit()
            
            Text(item.title ?? "")
                .bold()
                .font(Font.system(size: 18))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            Text(item.body ?? "")
                .font(Font.system(size: 16))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
        }
        .padding(20)
    }
}

