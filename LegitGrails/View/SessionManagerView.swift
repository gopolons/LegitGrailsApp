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
                AppTabView(modelData: coordinator.appTabVM)
                    .zIndex(1)

                if coordinator.postImagesView {
                    FullScreenPostImageView(modelData: coordinator.fullScreenPostImgVM)
                        .zIndex(2)
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
