//
//  FullScreenGenericPostView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 01/12/2021.
//

import SwiftUI
import SPAlert

struct FullScreenGenericPostView: View {
    
    @StateObject var modelData: FullScreenGenericPostViewModel
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            if modelData.post == nil {
                if modelData.connectionError {
                    VStack(spacing: 50) {
                        Text("No connection!")
                            .foregroundColor(.gray)
                            .bold()
                        
                        
                        HStack {
                            Spacer()
                            Button {
                                modelData.onAppear()
                            } label: {
                                HStack {
                                    Text("Retry")
                                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                }
                            }
                            Spacer()
                        }

                    }

                } else {
                    Text("")
                        .onAppear {
                            modelData.onAppear()
                        }
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
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
                    .padding()
                    
                    ForEach(0...3, id: \.self) { _ in
                        VStack(alignment: .leading, spacing: 10) {
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
                                
                                Spacer(minLength: 0)
                            }
                            
                            
                            Text("Fire shoes mf")
                                .padding(.leading, 50)
                                .font(.footnote)
                            
                            Button {
                                
                            } label: {
                                Text("Reply")
                                    .font(.footnote)
                            }
                            .padding(.leading, 50)



                        }
                        .padding()
                        
                    }
                }
                .onDisappear {
                    modelData.onDisappear()
                }
            }
        }
        .spAlert(isPresent: $modelData.alert, title: "Error!", message: modelData.alertMessage, duration: 1, dismissOnTap: true, preset: .error, haptic: .error, layout: .message()) {
            
        }
    }
}

//struct FullScreenGenericPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenGenericPostView(modelData: FullScreenGenericPostDebugViewModel())
//    }
//}
