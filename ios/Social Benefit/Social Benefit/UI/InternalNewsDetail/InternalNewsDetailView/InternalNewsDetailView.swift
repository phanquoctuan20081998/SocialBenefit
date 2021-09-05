//
//  InternalNewsDetailView.swift
//  Social Benefit
//
//  Created by Phan Quốc Tuấn on 30/08/2021.
//

import SwiftUI

struct InternalNewsDetailView: View {
    
    var internalNewData = InternalNewsData()
    
    @State var commnetData = comment
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            
            PostContentView(internalNewData: internalNewData)
            LikeAndCommentCount()
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            LikeAndCommentButton()
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    FirstCommentCardView()
                    SecondCommentCardView()
                    FirstCommentCardView()
                    SecondCommentCardView()
                }
            }
            Spacer()
            
            CommentBarView(commentText: .constant(""))
            
        }.background(NoSearchBackgroundView(isActive: .constant(true)))
        .if(comment.count == 0) { (view) in
            view.onAppear {
                CommentService().getAPI(index: 1) { (data) in
                    updateComment(data: data)
                    self.commnetData = data
                }
            }
        }
        
        
    }
}

struct PostContentView: View {
    var internalNewData: InternalNewsData
    
    var body: some View {
        VStack {
            Image(uiImage: (Constant.baseURL + internalNewData.cover).loadURLImage())
                .resizable()
                .scaledToFit()
                .frame(width: ScreenInfor().screenWidth*0.8, height: 150)
                .padding()
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(internalNewData.title)
                        .bold()
                        .font(.system(size: 30))
                        .lineLimit(2)
                         Text(internalNewData.shortBody)
                        .lineLimit(5)
                }
                Spacer()
            }.padding(.horizontal)
            .padding(.bottom)
        }.frame(width: ScreenInfor().screenWidth*0.9)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct FirstCommentCardView: View {
    
    var body: some View {
        HStack(alignment: .top) {
            Image("pic_user_profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(.all, 7)
                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
            
            Spacer().frame(width: 20)
            
            VStack {
                Text("AAhbcdbcdbchbdbchjsbdhcbhsbchbchhdscdbschbdshcbshjdbchbchbsdchbdshcbhjdsbchsdbchsbchjbhdjcbhdbchdbchbshcbhbcsdbcjhsdbchbsdhjcbjhsdbchjsdbchbsdhjcbsdjhbcjhsdbchjsdbchjsbdchjsbdchbsdjhcbsdjhcbhsdbcbcjhbsdcb")
                    .font(.system(size: 15))
                    .lineLimit(5)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2)))
                
                HStack() {
                    Button(action: {
                        
                    }, label: {
                        Text("Reply")
                            .bold()
                            .font(.system(size: 13))
                    })
                    
                    Text("2 hours")
                        .font(.system(size: 13))
                    
                    Spacer()
                }.foregroundColor(.black.opacity(0.6))
                .padding(.leading)
            }
        }.padding(.horizontal)
        
    }
    
}

struct SecondCommentCardView: View {
    
    var body: some View {
        HStack(alignment: .top) {
            Spacer().frame(width: 70)
            Image("pic_user_profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
                .padding(.all, 7)
                .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
            
            Spacer().frame(width: 20)
            
            VStack {
                Text("AAhbcdbcdbchbdbchjsbdhcbhsbchbchhdscdbschbdshcbshjdbchbchbsdchbdshcbhjdsbchsdbchsbchjbhdjcbhdbchdbchbshcbhbcsdbcjhsdbchbsdhjcbjhsdbchjsdbchbsdhjcbsdjhbcjhsdbchjsdbchjsbdchjsbdchbsdjhcbsdjhcbhsdbcbcjhbsdcb")
                    .font(.system(size: 15))
                    .lineLimit(5)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2)))
                
                HStack {
                    Text("2 hours")
                        .font(.system(size: 13))
                    
                    Spacer()
                }.foregroundColor(.black.opacity(0.6))
                .padding(.leading)
            }
        }.padding(.horizontal)
    }
}

struct CommentBarView: View {
    @Binding var commentText: String
    
    var body: some View {
        VStack {
            Divider().frame(width: ScreenInfor().screenWidth*0.9)
            HStack {
                Image("pic_user_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.all, 7)
                    .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 2))
                
                Spacer().frame(width: 18)
                
                TextField("Comment", text: $commentText)
                    .padding(5)
                    .padding(.leading, 10)
                    .overlay(RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.blue.opacity(0.5), lineWidth: 2))
                    .overlay(Image(systemName: "arrow.up.circle.fill")
                                .padding(.trailing, 3)
                                .foregroundColor(.blue)
                                .font(.system(size: 23)),
                             alignment: .trailing)
            }.padding(.horizontal)
        }
        
    }
}

struct LikeAndCommentCount: View {
    var body: some View {
        HStack {
            HStack {
                HStack(spacing: 4) {
                    Image("ic_fb_like")
                        .resizable()
                    Image("ic_fb_laugh")
                        .resizable()
                }.scaledToFit()
                .frame(width: 40)
                
                Text("10 người khác thích")
                    .font(.system(size: 12))
                    .bold()
            }
            
            Spacer()
            
            Text("31 bình luận")
                .font(.system(size: 12))
                .bold()
        }.padding(.horizontal)
    }
}

struct LikeAndCommentButton: View {
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "hand.thumbsup")
                Text("Like")
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "bubble.left")
                Text("Comment")
            }
        }.padding()
    }
}


struct InternalNewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InternalNewsDetailView()
    }
}
