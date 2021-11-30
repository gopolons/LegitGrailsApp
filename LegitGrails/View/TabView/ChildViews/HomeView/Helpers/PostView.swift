//
//  PostView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct PostView: View {
    
    @State var post: Post
    
    @State var liked = false
    
    @State var reposted = false
    
    @State var editedText = ""
    
    @State var extended = false
    
    @State var lineLimit = 2
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading) {
                    Text(post.username)
                        .bold()
                    HStack {
                        Text(post.communityName)
                        ForEach(post.tags, id: \.self) { tag in
                            Text("•")
                            Text(tag)
                        }
                    }
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
            }
            VStack(alignment: .leading, spacing: 20) {
                Text(post.title)
                    .bold()
                    .font(.footnote)
                    
                VStack(alignment: .leading) {
                    Text(post.text)
                        .font(.footnote)
                        .lineLimit(lineLimit)
                        .lineSpacing(6)
                    
                    if !extended {
                        Button {
                            withAnimation {
                                extended = true
                                lineLimit = 50
                            }
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
                    Text("\(post.viewCountIDs.count)")
                        .font(.caption)
                        .fixedSize(horizontal: true, vertical: false)

                    
                }
                .foregroundColor(.gray)
                
                Spacer(minLength: 0)
                
                HStack {
                    Button {
                        if reposted {
                            reposted = false
                            post.repostIDs.remove(at: post.repostIDs.firstIndex(of: "gg")!)
                        } else {
                            reposted = true
                            post.repostIDs.append("gg")
                        }
                    } label: {
                        Text("\(post.repostIDs.count)")
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)

                        Image(systemName: "arrowshape.turn.up.forward.fill")
                    }
                    .buttonStyle(PlainButtonStyle())


                }
                .foregroundColor(reposted ? Color("AccentColor") : .gray)

                
                HStack {
                    Text("\(post.commentIDs.count)")
                        .font(.caption)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    Image(systemName: "bubble.left.fill")
                        .foregroundColor(.gray)


                }
                .foregroundColor(.gray)
                
                HStack {
                    Button {
                        if liked {
                            liked = false
                            post.likeIDs.remove(at: post.likeIDs.firstIndex(of: "gg")!)
                        } else {
                            liked = true
                            post.likeIDs.append("gg")
                        }
                    } label: {
                        Text("\(post.likeIDs.count)")
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: false)
                        
                        Image(systemName: "heart.fill")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .foregroundColor(liked ? Color("AccentColor") : .gray)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray6), lineWidth: 1)
        )
        .onAppear {
            if !(post.text.count > 100) {
                extended = true
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    
    @State static var post = Post(ID: "", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"])
    
    static var previews: some View {
        PostView(post: post)
    }
}
