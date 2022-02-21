//
//  ReatPopUpView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation
import SwiftUI

struct ReactionPopUpView: View {
    
    @Binding var activeSheet: ReactActiveSheet?
    
    var contentType: Int
    var contentId: Int
    
    var isPopup = false
    
    @ObservedObject private var viewModel = ReactionPopUpViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        activeSheet = nil
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.leading)
                    })
                        .padding()
                    
                    Text("reacted".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                    
                    Spacer()
                }
                content
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            .if(isPopup) { view in
                view.padding(EdgeInsets.init(top: 50, leading: 20, bottom: 50, trailing: 20))
            }
            .if(isPopup) { view in
                view.shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black.opacity(0.2))
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            viewModel.request(contentType, contentId)
        }
        .onDisappear() {
            viewModel.clearData()
        }
        .errorPopup($viewModel.error)
    }
    
    var content: some View {
        VStack {
            headerTab
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .loadingView(isLoading: $viewModel.isLoading, dimBackground: false)
    }
    
    var headerTab: some View {
        VStack {
            headerTab(viewModel.countModel.list)
            listReact(viewModel.countModel.list)
            Spacer()
        }
    }
    
    @ViewBuilder
    func headerTab(_ result: [ReactCountResultModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(result.indices, id: \.self) { index in
                   
                    if result[index].reactType == -1 {
                        VStack {
                            Button(action: {
                                viewModel.currentTab = index
                            }, label: {
                                HStack {
                                    Group {
                                        Text("all".localized)
                                        Text(result[index].reactCount?.string ?? "")
                                    }
                                    .fixedSize(horizontal: true, vertical: false)
                                    .if(viewModel.currentTab != index) {
                                        $0.foregroundColor(.black)
                                    }
                                    .if(viewModel.currentTab == index) {
                                        $0.foregroundColor(.blue)
                                    }
                                }
                                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            })
                            
                            Divider()
                                .background(Color.blue)
                                .if(viewModel.currentTab != index) {
                                    $0.hidden()
                                }
                        }
                    } else if let reactType = result[index].reactType, let type = ReactionType.init(rawValue: reactType) {
                        VStack {
                            Button(action: {
                                viewModel.currentTab = index
                            }, label: {
                                HStack {
                                    Image.init(type.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .clipped()
                                    Text(result[index].reactCount?.string ?? "")
                                        .fixedSize(horizontal: true, vertical: false)
                                        .if(viewModel.currentTab != index) {
                                            $0.foregroundColor(.black)
                                        }
                                        .if(viewModel.currentTab == index) {
                                            $0.foregroundColor(type.color)
                                        }
                                }
                                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            })
                            Divider()
                                .background(type.color)
                                .if(viewModel.currentTab != index) { content in
                                    content.hidden()
                                }
                        }
                    }
                }
            }
            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            .frame(height: 50)
        }
    }
    
    @ViewBuilder
    func listReact(_ result: [ReactCountResultModel]) -> some View {
        VStack {
            if result.count > 0 {
                if #available(iOS 14.0, *) {
                    TabView(selection: $viewModel.currentTab) {
                        ForEach(result.indices, id: \.self) { index in
                            ReactListView.init(contentType: contentType, contentId: contentId, reactType: result[index].reactType).tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                } else {
                    TabView(selection: $viewModel.currentTab) {
                        ForEach(result.indices, id: \.self) { index in
                            ReactListView.init(contentType: contentType, contentId: contentId, reactType: result[index].reactType).tag(index)
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
