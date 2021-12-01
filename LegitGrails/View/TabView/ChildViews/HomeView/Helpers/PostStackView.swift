//
//  PostStackView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI
import SPAlert

struct PostStackView: View {
    
    @StateObject var modelData: PostStackViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("All activity")
                .font(.title2)
                .padding()
            
            if modelData.posts.isEmpty && !modelData.error {
                HStack {
                    Spacer()
                    
                    ActivityIndicator(isAnimating: true)

                    Spacer()
                }
            }
            
            if modelData.error && modelData.posts.isEmpty {
                HStack {
                    Spacer()
                    Button {
                        modelData.onAppear()
                    } label: {
                        Text("Retry")
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    }
                    Spacer()
                }
            }
            
            ForEach(modelData.posts, id: \.self) { post in
                PostView(modelData: PostViewModel(post: post, coordinator: modelData.getCoordinator()))
            }
            .padding(.horizontal)
        }
        .onAppear {
            modelData.onAppear()
        }
        .spAlert(isPresent: $modelData.alert, title: "Error", message: modelData.alertMessage, duration: 1, dismissOnTap: true, preset: modelData.alertPreset, haptic: modelData.alertHaptic, layout: .message()) {
            
        }
        
    }
}

struct PostStackView_Previews: PreviewProvider {
    static var previews: some View {
        PostStackView(modelData: PostStackViewModel(coordinator: SessionManagerObject()))
    }
}
