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
    
    @State private var listModel = ReactListModel()
    
    private let listService = ReactListService()
    
    var body: some View {
        VStack {
            List(listModel.result ?? []) { item in
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
        .onAppear() {
            requestReactList(contentType: contentType, contentId: contentId, reactType: reactType)
        }
    }
    
    func requestReactList(contentType: Int?, contentId: Int?, reactType: Int?) {
        if listModel.result == nil {
            listService.request(contentType: contentType, contentId: contentId, reactType: reactType, fromIndex: 0) { response in
                switch response {
                case .success(let value):
                    self.listModel = value
                case .failure(_ ):
                    break
                }
            }
        }
    }
}

