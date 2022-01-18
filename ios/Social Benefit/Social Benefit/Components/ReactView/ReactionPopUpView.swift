//
//  ReatPopUpView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 14/01/2022.
//

import Foundation
import SwiftUI

struct ReactionPopUpView: View {
    
    @Binding var isPresented: Bool
    
    var contentType: Int
    var contentId: Int
    
    @ObservedObject private var viewModel = ReactionPopUpViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        isPresented = false
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
            .padding(EdgeInsets.init(top: 50, leading: 20, bottom: 50, trailing: 20))
            .shadow(color: .black.opacity(0.2), radius: 8, x: -3, y: 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black.opacity(0.2))
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            viewModel.request(contentType, contentId)
            viewModel.requestReactList(contentType: contentType, contentId: contentId, reactType: -1)
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
            if let result = viewModel.countModel.result {
                headerTab(result)
                listReact
                Spacer()
            } else {
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    func headerTab(_ result: [ReactCountResultModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(result.indices) { index in
                   
                    if result[index].reactType == -1 {
                        VStack {
                            Button(action: {
                                viewModel.requestReactList(contentType: contentType, contentId: contentId, reactType: -1)
                                viewModel.currentReactType = result[index].reactType ?? -1
                            }, label: {
                                HStack {
                                    Text("all".localized)
                                        .if(viewModel.currentReactType != -1) {
                                            $0.foregroundColor(.black)
                                        }
                                        .if(viewModel.currentReactType == -1) {
                                            $0.foregroundColor(.blue)
                                        }
                                    Text(result[index].reactCount?.string ?? "")
                                        .if(viewModel.currentReactType != -1) {
                                            $0.foregroundColor(.black)
                                        }
                                        .if(viewModel.currentReactType == -1) {
                                            $0.foregroundColor(.blue)
                                        }
                                }
                                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            })
                            
                            Divider()
                                .background(Color.blue)
                                .if(viewModel.currentReactType != -1) {
                                    $0.hidden()
                                }
                        }
                    } else if let reactType = result[index].reactType, let type = ReactionType.init(rawValue: reactType) {
                        VStack {
                            Button(action: {
                                viewModel.requestReactList(contentType: contentType, contentId: contentId, reactType: reactType)
                                viewModel.currentReactType = reactType
                            }, label: {
                                HStack {
                                    Image.init(type.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .clipped()
                                    Text(result[index].reactCount?.string ?? "")
                                        .if(viewModel.currentReactType != reactType) {
                                            $0.foregroundColor(.black)
                                        }
                                        .if(viewModel.currentReactType == reactType) {
                                            $0.foregroundColor(type.color)
                                        }
                                }
                                .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                            })
                            Divider()
                                .background(type.color)
                                .if(viewModel.currentReactType != reactType) { content in
                                    content.hidden()
                                }
                        }
                    }
                }
            }
            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
    
    var listReact: some View {
        List(viewModel.listModel.result ?? []) { item in
            HStack(spacing: 20) {
                ZStack(alignment: .bottomTrailing) {
                    URLImageView(url: Config.baseURL + (item.avatar ?? ""))
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                    if let type = ReactionType.init(rawValue: item.reactType) {
                        Image.init(type.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .clipped()
                    }
                }
                Text(item.employeeName ?? "")
            }
        }
    }
}

extension View {
    func reactionPopUpView(isPresented: Binding<Bool>, contentType: Int, contentId: Int) -> some View {
        return self.popup(isPresented: isPresented, alignment: .center) {
            ReactionPopUpView(isPresented: isPresented, contentType: contentType, contentId: contentId)
        }
    }
}
