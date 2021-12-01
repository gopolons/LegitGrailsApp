//
//  SessionManagerView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

// MARK: AppState
enum AppState {
    case login
    case tabView
}

struct SessionManagerView: View {
    
    @ObservedObject var coordinator: SessionManagerObject
    
    var body: some View {
        switch coordinator.appState {
        case .login:
            SignUpView(modelData: coordinator.signUpVM)
        case .tabView:
            
            ZStack {
                NavigationView {
                    ZStack {
                        AppTabView(modelData: coordinator.appTabVM)
                        
                        NavigationLink(isActive: $coordinator.postView) {
                            FullScreenGenericPostView(modelData: coordinator.fullScreenPostVM)
                                .navigationTitle("")
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    ToolbarItem(placement: .principal) {
                                        Image("LegitGrails")
                                            .resizable()
                                            .frame(width: 50, height: 40)
                                    }
                                }
                        } label: {
                            Text("")
                                .hidden()
                        }
                        .zIndex(1)
                        .navigationTitle("")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image("LegitGrails")
                                    .resizable()
                                    .frame(width: 50, height: 40)
                            }
                        }
                    }
                }
                if coordinator.postImagesView {
                    FullScreenPostImageView(modelData: coordinator.fullScreenPostImgVM)
                        .zIndex(100)
                }
            }
        }
    }
}

struct SessionManagerView_Previews: PreviewProvider {
    static var previews: some View {
        SessionManagerView(coordinator: SessionManagerObject())
    }
}
