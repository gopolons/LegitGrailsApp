//
//  CommentStackView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct CommentStackView: View {
    
    @StateObject var commentStackModelData: CommentStackViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if commentStackModelData.commentsUnavailable {
                Text("No comments yet! Be the first one to share your thoughts!")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding()
                    .padding(.bottom)
            } else {
                ForEach(commentStackModelData.comments, id: \.self) { comment in
                    
                    CommentCell(modelData: CommentCellViewModel(comment: comment, commentStackCoordinator: commentStackModelData))
                        
                    
                    Divider()
                        .padding(.leading)

                }
            }
        }
        .onAppear {
            commentStackModelData.onAppear()
        }
    }
}

struct CommentStackView_Previews: PreviewProvider {
    static var previews: some View {
        CommentStackView(commentStackModelData: CommentStackViewModel(commentIDs: [], postCoordinator: FullScreenGenericPostViewModel(coordinator: SessionManagerObject())))
    }
}
