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
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    VStack(spacing: 20) {
                        HStack {
                            HStack {
                                Circle()
                                    .frame(width: 40, height: 40)
                                VStack(alignment: .leading) {
                                    Text(modelData.post.username)
                                        .bold()
                                    HStack {
                                        Text("1 Sep at 1:36 PM")
                                        
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                        }
                        HStack {
                            ForEach(modelData.post.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.footnote)
                                    .foregroundColor(Color("AccentColor"))
                            }
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text(modelData.post.title)
                                    .bold()
                                    .font(.footnote)
                                    
                                Spacer()
                            }
                            
                        }
                        VStack {
                            HStack {
                                Text(modelData.post.text)
                                    .font(.footnote)
                                    .lineSpacing(6)
                                
                                Spacer()
                            }
                        }
                        if !modelData.post.images.isEmpty {
                            HStack {
                                Spacer(minLength: 0)
                                TabView {
                                    ForEach(modelData.post.images, id: \.self) { img in
                                        Button {
                                            modelData.showImages(img)
                                        } label: {
                                            Image(img)
                                                .resizable()
                                                .scaledToFill()
                                                .clipped()
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                Spacer(minLength: 0)
                            }
                            .frame(height: 400)
                        }
                    }
                    .padding([.top, .leading, .trailing], 30)

                    VStack {
                        HStack {
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
                                        modelData.pressedRepost()
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
                                        modelData.pressedLike()
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
                    }
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
                    
                    CommentStackView(modelData: modelData.commentStackVM)

                }
            }
    //                    .padding(.bottom, 70)
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
