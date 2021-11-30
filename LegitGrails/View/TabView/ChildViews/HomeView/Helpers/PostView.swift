//
//  PostView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI
import SPAlert

struct PostView: View {
    
    @StateObject var modelData: PostViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(modelData.post.username)
                        .bold()
                    HStack {
                        Text(modelData.post.communityName)
                        ForEach(modelData.post.tags, id: \.self) { tag in
                            Text("•")
                            Text(tag)
                        }
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
            }
            VStack(alignment: .leading, spacing: 20) {
                Text(modelData.post.title)
                    .bold()
                    .font(.footnote)
                    
                VStack(alignment: .leading) {
                    Text(modelData.post.text)
                        .font(.footnote)
                        .lineLimit(modelData.lineLimit)
                        .lineSpacing(6)
                    
                    if !modelData.extended {
                        Button {
                            modelData.extendPost()
                        } label: {
                            Text("...read more")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .lineSpacing(5)
                                .padding(.top, 1)

                                
                        }
                        .buttonStyle(PlainButtonStyle())


                    }
                }
            }
            
            HStack(spacing: 20) {
                HStack {
                    Image(systemName: "eye")
                    Text("\(modelData.post.viewCountIDs.count)")
                        .font(.caption)
                        .fixedSize(horizontal: true, vertical: false)

                    
                }
                .foregroundColor(.gray)
                
                Spacer(minLength: 0)
                
                HStack {
                    Button {
                        modelData.repostPressed()
                    } label: {
                        Text("\(modelData.post.repostIDs.count)")
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)

                        Image(systemName: "arrowshape.turn.up.forward.fill")
                    }
                    .buttonStyle(PlainButtonStyle())


                }
                .foregroundColor(modelData.reposted ? Color("AccentColor") : .gray)

                
                HStack {
                    Text("\(modelData.post.commentIDs.count)")
                        .font(.caption)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Image(systemName: "bubble.left.fill")
                        .foregroundColor(.gray)


                }
                .foregroundColor(.gray)
                
                HStack {
                    Button {
                        modelData.likePressed()
                    } label: {
                        Text("\(modelData.post.likeIDs.count)")
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Image(systemName: "heart.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(modelData.liked ? Color("AccentColor") : .gray)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray6), lineWidth: 1)
        )
        .onAppear {
            modelData.onAppear()
        }
        .spAlert(isPresent: $modelData.alert, title: "Error", message: modelData.alertMessage, duration: 1, dismissOnTap: true, preset: .error, haptic: .error, layout: .message()) {
            
        }
    }
}

struct PostView_Previews: PreviewProvider {
    
    @State static var post = Post(ID: "", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"])
    
    static var previews: some View {
        PostView(modelData: PostViewModel(post: post, coordinator: SessionManagerObject()))
    }
}
