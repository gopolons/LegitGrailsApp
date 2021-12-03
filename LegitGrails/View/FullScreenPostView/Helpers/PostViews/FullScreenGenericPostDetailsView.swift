//
//  FullScreenGenericPostDetailsView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct FullScreenGenericPostDetailsView: View {
    
    @ObservedObject var modelData: FullScreenGenericPostViewModel
    
    var body: some View {
        if !(modelData.post == nil) {
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
        }
    }
}

struct FullScreenPostGenericPostDetails_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenGenericPostDetailsView(modelData: FullScreenGenericPostViewModel(coordinator: SessionManagerObject()))
    }
}
