//
//  PostStackView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct PostStackView: View {
    
    @StateObject var modelData: PostStackViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("All activity")
                .font(.title2)
                .padding()
            
            if modelData.posts.isEmpty {
                HStack {
                    Spacer()
                    
                    ActivityIndicator(isAnimating: true)

                    Spacer()
                }
            }
            
            ForEach(modelData.posts, id: \.self) { post in
                PostView(post: post)
            }
            .padding(.horizontal)
        }
        .onAppear {
            modelData.onAppear()
        }
        
    }
}

struct PostStackView_Previews: PreviewProvider {
    static var previews: some View {
        PostStackView(modelData: PostStackViewModel())
    }
}
