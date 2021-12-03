//
//  FullScreenGenericPostView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 01/12/2021.
//

//                .focusedLegacy($focusedFields, equals: .input)


import SwiftUI
import SPAlert
import Focuser

struct FullScreenGenericPostView: View {
    
    @StateObject var modelData: FullScreenGenericPostViewModel
    
    @FocusStateLegacy var focusedFields: FullScreenGenericPostViewFormField?
    
    var body: some View {
        ZStack {
            
            
            VStack(spacing: 0) {
                if modelData.post == nil {
                    
                    PostLoadingView(modelData: modelData)
                    
                } else {
                    
                    FullScreenGenericPostContentView(modelData: modelData)
                        .padding(.bottom, 60)
                    
                }
            }
            
            
            VStack(spacing: 0) {
                Spacer()
                
                Rectangle()
                    .frame(width: UIScreen.screenWidth, height: 40)
                    .foregroundColor(Color(.systemGray6))
            }
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                Spacer()
                
                VStack {
                    CommentInputField()
                }
                .background(Color(.systemGray6))

                    
            }
            
        }
        .spAlert(isPresent: $modelData.alert, title: "Error!", message: modelData.alertMessage, duration: 1, dismissOnTap: true, preset: .error, haptic: .error, layout: .message()) {
            
        }
    }
}

struct FullScreenGenericPostView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenGenericPostView(modelData: FullScreenGenericPostViewModel(coordinator: SessionManagerObject()))

    }
}
