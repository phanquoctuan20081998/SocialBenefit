//
//  ReactListView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 21/01/2022.
//

import SwiftUI

struct ReactListView: View {
    
    var contentType: Int
    var contentId: Int
    
    var reactType: Int?
    
    @State private var model = ReactListModel()
    
    @State private var isLoading = false
    
    private let listService = ReactListService()
    
    @State private var list: [ReactListResultModel] = []
    
    @State private var error: AppError = .none
    
    @State private var canLoadMore = true
    
    var body: some View {
        List {
            ForEach(list, id: \.self) { item in
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
                }.onAppear {
                    if item == list.last {
                        requestReactList(contentType: contentType, contentId: contentId, reactType: reactType, onAppear: false)
                    }
                }
            }
//            if isLoading {
//                UIActivityRep.init(style: .medium, color: .black)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            }
        }
        .onAppear() {
            requestReactList(contentType: contentType, contentId: contentId, reactType: reactType, onAppear: true)
        }
        .errorPopup($error)
    }
    
    func requestReactList(contentType: Int?, contentId: Int?, reactType: Int?, onAppear: Bool) {
        if onAppear {
            if list.isEmpty {
                request(contentType: contentType, contentId: contentId, reactType: reactType)
            }
        } else {
            request(contentType: contentType, contentId: contentId, reactType: reactType)
        }
    }
    
    func request(contentType: Int?, contentId: Int?, reactType: Int?) {
        if !isLoading, canLoadMore {
            isLoading = true
            listService.request(contentType: contentType, contentId: contentId, reactType: reactType, fromIndex: list.count) { response in
                self.isLoading = false
                switch response {
                case .success(let value):
                    self.list.append(contentsOf: value.result ?? [])
                    if (value.result ?? []).isEmpty {
                        self.canLoadMore = false
                    }
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}

