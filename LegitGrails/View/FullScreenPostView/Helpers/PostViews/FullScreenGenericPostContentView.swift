//
//  FullScreenGenericPostContentView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct FullScreenGenericPostContentView: View {
    
    @ObservedObject var modelData: FullScreenGenericPostViewModel
    
    var body: some View {
        if !(modelData.post == nil) {
            
            ScrollView {
                FullScreenGenericPostDetailsView(modelData: modelData)
                
                PostFooterView(pressedRepost: {
                    modelData.pressedRepost()
                }, pressedLike: {
                    modelData.pressedLike()
                }, reposted: $modelData.reposted, liked: $modelData.liked, likeCount: $modelData.likeCount, viewCount: $modelData.viewCount, repostCount: $modelData.repostCount, commentCount: $modelData.commentCount)
                    .padding()
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Comments")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                    }
                }
                .padding([.horizontal, .top])
                
                CommentStackView(commentStackModelData: modelData.commentStackVM)

            
            }
            
            .onDisappear {
                modelData.onDisappear()
            }

        }

    }
}

struct FullScreenGenericPostContentView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenGenericPostContentView(modelData: FullScreenGenericPostViewModel(coordinator: SessionManagerObject()))
    }
}
