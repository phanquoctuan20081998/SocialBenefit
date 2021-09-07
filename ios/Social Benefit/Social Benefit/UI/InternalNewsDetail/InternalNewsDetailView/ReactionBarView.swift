//
//  ReactionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/09/2021.
//

import SwiftUI
import SDWebImageSwiftUI

var reactions = ["like.gif", "love.gif", "laugh.gif", "", "sad.gif", "angry.gif", ""]

struct ReactionBarView: View {

    @Binding var isShowReactionBar: Bool
    @Binding var selectedReaction: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(reactions, id: \.self) {reaction in
                if !reaction.isEmpty {
                    AnimatedImage(name: reaction)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: (reactions[self.selectedReaction] == reaction) ? 150 : 50,
                               height: (reactions[self.selectedReaction] == reaction) ? 150 : 50)
                        .padding((reactions[self.selectedReaction] == reaction) ? -40 : 0)
                        .offset(y: (reactions[self.selectedReaction] == reaction) ? -20 : 0)
                }
            }
        }.padding(.horizontal, 10)
        .background(Color.white.clipShape(Capsule()))
        .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: 5)
    }
}

struct ReactionView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionBarView(isShowReactionBar: .constant(true), selectedReaction: .constant(1))
    }
}
