//
//  PostFooterView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct PostFooterView: View {
    
    var pressedRepost: () -> Void
    
    var pressedLike: () -> Void
    
    @Binding var reposted: Bool
    
    @Binding var liked: Bool
    
    @Binding var likeCount: Int
    
    @Binding var viewCount: Int
    
    @Binding var repostCount: Int
    
    @Binding var commentCount: Int
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 20) {
                    HStack {
                        Image(systemName: "eye")
                        Text("\(viewCount)")
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)

                        
                    }
                    .foregroundColor(.gray)
                    
                    Spacer(minLength: 0)
                    
                    HStack {
                        Button {
                            pressedRepost()
                        } label: {
                            Text("\(repostCount)")
                                .font(.caption)
                                .fixedSize(horizontal: true, vertical: false)

                            Image(systemName: "arrowshape.turn.up.forward.fill")
                        }
                        .buttonStyle(PlainButtonStyle())


                    }
                    .foregroundColor(reposted ? Color("AccentColor") : .gray)

                    
                    HStack {
                        Text("\(commentCount)")
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Image(systemName: "bubble.left.fill")
                            .foregroundColor(.gray)


                    }
                    .foregroundColor(.gray)
                    
                    HStack {
                        Button {
                            pressedLike()
                        } label: {
                            Text("\(likeCount)")
                                .font(.caption)
                                .fixedSize(horizontal: true, vertical: false)
                            
                            Image(systemName: "heart.fill")
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .foregroundColor(liked ? Color("AccentColor") : .gray)
                }
            }
        }
    }
}

struct PostFooterView_Previews: PreviewProvider {
    
    @State static var reposted = false
    
    @State static var liked = false

    @State static var viewCount = 10
    
    @State static var likeCount = 10
    
    @State static var repostCount = 10
    
    @State static var commentCount = 10

    static var previews: some View {
        PostFooterView(pressedRepost: {}, pressedLike: {}, reposted: $reposted, liked: $liked, likeCount: $likeCount, viewCount: $viewCount, repostCount: $repostCount, commentCount: $commentCount)
    }
}
