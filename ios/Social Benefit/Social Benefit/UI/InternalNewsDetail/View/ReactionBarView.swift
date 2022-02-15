//
//  ReactionView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 07/09/2021.
//

import SwiftUI
import SDWebImageSwiftUI

var reactions = ["like", "love", "laugh", "", "sad", "angry", ""]
var reactionColors = [Color.blue, Color.pink, Color.yellow, Color.gray, Color.yellow, Color.orange]

struct ReactionBarView: View {

    @Binding var isShowReactionBar: Bool
    @Binding var selectedReaction: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(reactions.indices, id: \.self) {index in
                if !reactions[index].isEmpty {
                    AnimatedImage(name: (reactions[index] + ".gif"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: (reactions[self.selectedReaction] == reactions[index]) ? 150 : 50,
                               height: (reactions[self.selectedReaction] == reactions[index]) ? 150 : 50)
                        .padding((reactions[self.selectedReaction] == reactions[index]) ? -40 : 0)
                        .offset(y: (reactions[self.selectedReaction] == reactions[index]) ? -20 : 0)
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
