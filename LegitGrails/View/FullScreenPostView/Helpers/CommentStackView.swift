//
//  CommentStackView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct CommentStackView: View {
    
    @StateObject var modelData: CommentStackViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            if modelData.commentsUnavailable {
                Text("No comments yet! Be the first one to share your thoughts!")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding()
                    .padding(.bottom)
            } else {
                ForEach(modelData.comments, id: \.self) { comment in
                    
                    CommentCell(modelData: CommentCellViewModel(comment: comment))
                        
                    
                    Divider()
                        .padding(.leading)

                }
            }
        }
        .onAppear {
            modelData.onAppear()
        }
    }
}

struct CommentStackView_Previews: PreviewProvider {
    static var previews: some View {
        CommentStackView(modelData: CommentStackViewModel(commentIDs: []))
    }
}
