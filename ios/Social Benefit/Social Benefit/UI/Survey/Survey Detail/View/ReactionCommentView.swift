//
//  ReactionCommentView.swift
//  Social Benefit
//
//  Created by chu phuong dong on 02/12/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

enum ReactionType: Int, CaseIterable {
    case none = -1
    case like = 0
    case love = 1
    case laugh = 2
//    case surprise = 3
    case sad = 4
    case angry = 5
    
    var name: String {
        switch self {
        case .like:
            return "like"
        case .love:
            return "love"
        case .laugh:
            return "laugh"
        case .sad:
            return "sad"
        case .angry:
            return "angry"
        case .none:
            return ""
        }
    }
    
    var text: String {
        return self.name.localized
    }
    
    var gif: String {
        return self.name + ".gif"
    }
    
    var imageName: String {
        switch self {
        case .like:
            return "ic_fb_like"
        case .love:
            return "ic_fb_love"
        case .laugh:
            return "ic_fb_laugh"
        case .sad:
            return "ic_fb_sad"
        case .angry:
            return "ic_fb_angry"
        case .none:
            return ""
        }
    }
    
    var color: Color {
        switch self {
        case .like:
            return .blue
        case .love:
            return .pink
        case .laugh:
            return .orange
        case .sad:
            return .orange
        case .angry:
            return .red
        case .none:
            return .accentColor
        }
    }
}

struct ReactionCommentView: View {

    @Binding var isShowReactionBar: Bool
    @Binding var selectedReaction: ReactionType
    
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(ReactionType.allCases, id: \.self) { type in
                if type != .none {
                    Button.init {
                        isShowReactionBar.toggle()
                        selectedReaction = type
                        action?()
                    } label: {
                        AnimatedImage(name: type.gif)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .background(type == selectedReaction ? Color.gray.opacity(0.2) : Color.clear)
                    .cornerRadius(4)
                    .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }
        }
        .padding(.horizontal, 10)
        .background(Color.white.clipShape(Capsule()))
        .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: 5)
    }
}
