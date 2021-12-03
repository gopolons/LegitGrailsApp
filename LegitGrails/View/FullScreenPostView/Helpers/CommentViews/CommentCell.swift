//
//  CommentCell.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct CommentCell: View {
    
    @StateObject var modelData: CommentCellViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack {
                        Circle()
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text(modelData.comment.username)
                                .bold()
                            HStack {
                                Text(modelData.comment.date)
                                
                            }
                            .font(.footnote)
                            .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer(minLength: 0)
                }
                
                
                Text(modelData.comment.text)
                    .padding(.leading, 50)
                    .font(.footnote)
                

            }
            if !modelData.comment.comments.isEmpty {

                ForEach(modelData.comment.comments[0...(modelData.shownComments - 1)], id: \.self) { com in
                    VStack(spacing: 10) {
                        
                        VStack(alignment: .leading, spacing: 10)  {
                            HStack {
                                HStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                    VStack(alignment: .leading) {
                                        Text(com.username)
                                            .bold()
                                        HStack {
                                            Text(com.date)
                                            
                                        }
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    }
                                }
                                
                                Spacer(minLength: 0)
                            }
                            
                            
                            Text(com.text)
                                .padding(.leading, 40)
                                .font(.footnote)
                
                            

                        }

                    }
                    .padding(.leading, 50)

                }
                
                if modelData.shownComments == 2 {
                    HStack {
                        Button {
                            modelData.buttonPress()
                        } label: {
                            Text("—")
                            Text("Show all replies")
                                .bold()
                                .font(.footnote)
                                .padding(.leading, 8)

                            
                        }
                        .padding(.leading, 50)
                        .padding(.leading, 8)
                        
                        Spacer()

                    }

                }
                
            }
            
            HStack {
                Button {
                    modelData.commentPressed()
                } label: {
                    VStack {
                        HStack {
                            Circle()
                                .frame(width: 30, height: 30)
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color(.systemGray4), lineWidth: 1)
                                    )
                                HStack {
                                    Text("Comment")
                                        .padding(.leading)
                                        .foregroundColor(Color.gray)
                                    
                                    Spacer()
                                }
                            }
                            

                        }
                    }

                }
                .buttonStyle(NoFeedbackButtonStyle())
                
                Spacer()
            }
            .padding(.leading, 50)

        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(modelData.commentStackCoordinator.selectedComment == modelData.comment.ID ? Color(.systemFill) : Color(.clear))
    }
}

struct CommentCell_Previews: PreviewProvider {
    
    @State static var selectedCommentID = "1"
    
    static var previews: some View {
        CommentCell(modelData: CommentCellViewModel(comment: Comment(ID: "", userID: "", username: "gdsaj", image: "AuthenticateLink", date: "11 of Jun??", text: "fdsafj dsafdsa", comments: []), commentStackCoordinator: CommentStackViewModel(commentIDs: [], postCoordinator: FullScreenGenericPostViewModel(coordinator: SessionManagerObject()))))
    }
}
