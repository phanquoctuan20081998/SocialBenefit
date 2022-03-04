//
//  FilterView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 16/09/2021.
//

import SwiftUI
import ScrollViewProxy

struct SortView: View {
    
    @EnvironmentObject var offersViewModel: FavoriteMerchantOfferViewModel
    
    @State var selectedFilterIndex: Int = 0
    @State private var proxy: AmzdScrollViewProxy? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            FilterSlideView
        }
    }
}

extension SortView {
    
    var FilterSlideView: some View {
        HStack(spacing: 15) {
            HStack(spacing: 10)  {
                Text("sort".localized)
                    .font(.system(size: 13))
                Image(systemName: "line.horizontal.3.decrease")
                    .resizable()
                    .frame(width: 10, height: 10)
            }
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color("nissho_blue").opacity(0.5), lineWidth: 2))
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                AmzdScrollViewReader { proxy in
                    HStack {
                        ForEach(0..<Constants.FilterAndSortType.count, id: \.self) { i in
                            
                            Text(Constants.FilterAndSortType[i].localized)
                                .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                                .background(RoundedRectangle(cornerRadius: 30).fill((self.selectedFilterIndex == i) ? Color("nissho_blue") : Color.gray.opacity(0.2)))
                                .onTapGesture {
                                    
                                    if self.selectedFilterIndex == i {
                                        self.selectedFilterIndex = 0
                                        
                                        DispatchQueue.main.async {
                                            self.offersViewModel.filterConditionItems = "[]"
                                        }
                                        
                                    } else {
                                        self.selectedFilterIndex = i
                                        
                                        DispatchQueue.main.async {
                                            self.offersViewModel.filterConditionItems = "[{\"filterType\":\"\(Constants.FilterAndSortType[i])\",\"sortType\":\"\(Constants.SortDirectionType[0])\"}]"
                                        }
                    
                                    }
                                    
                                    self.proxy?.scrollTo(self.selectedFilterIndex,
                                                         alignment: .leading,
                                                           animated: true)
                                    
                                    // Click count
                                    countClick()
                                }
                                .scrollId(i)
                        }
                        Spacer().frame(width: 30)
                    }
                    .onAppear { self.proxy = proxy }
                }
            }
        }
    }
}

