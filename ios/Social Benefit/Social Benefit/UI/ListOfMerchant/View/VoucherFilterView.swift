//
//  FilterView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/09/2021.
//

import SwiftUI
import ScrollViewProxy

let filterType = ["nearest_deadline", "farthest_deadline", "lowest_pice", "highest_price", "a-z", "z-a", "most_discounts", "bestseller", "best_reviews"]

struct FilterView: View {
    
    @State var selectedFilterIndex: Int = 0
    @State private var proxy: AmzdScrollViewProxy? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("all_offer".localized.uppercased())
                .font(.system(size: 18, weight: .heavy, design: .default))
                .padding(.leading)
                .foregroundColor(.orange)
            
            FilterSlideView
            
        }.padding(.horizontal)
    }
}

extension FilterView {
    var FilterSlideView: some View {
        HStack(spacing: 15) {
            HStack {
                Text("filter".localized)
                    .padding(5)
            }.background(RoundedRectangle(cornerRadius: 10).fill(Color(#colorLiteral(red: 0.971601069, green: 0.9766867757, blue: 0.9764313102, alpha: 1))))
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                AmzdScrollViewReader { proxy in
                    HStack {
                        ForEach(0..<filterType.count, id: \.self) { i in
                            if self.selectedFilterIndex == i  {
                                Text(filterType[i])
                                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color.blue))
                                    .onTapGesture {
                                        self.selectedFilterIndex = i
                                        self.proxy?.scrollTo(self.selectedFilterIndex,
                                                             alignment: .top,
                                                               animated: true)
                                    }
                                    .scrollId(i)
                            }
                            
                            else {
                                Text(filterType[i])
                                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(Color(#colorLiteral(red: 0.977273643, green: 0.9723979831, blue: 0.9766659141, alpha: 1))))
                                    .onTapGesture {
                                        self.selectedFilterIndex = i
                                        self.proxy?.scrollTo(self.selectedFilterIndex,
                                                             alignment: .leading,
                                                               animated: true)
                                    }
                                    .scrollId(i)
                            }
                        }
                        Spacer().frame(width: 30)
                    }
                    .onAppear { self.proxy = proxy }
                }
            }
        }
    }
}

struct FilterPopUp: View {
    var body: some View {
        Text("")
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMerchantView()
    }
}
