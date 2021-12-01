//
//  SessionManagerObject.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SessionManagerObject: ObservableObject {
    @Published var postImages: [String] = []
    @Published var openedImage = ""
    @Published var authToken = "test"
    @Published var userID = "test"
    @Published var screenHeight: Double
    @Published var appState: AppState
    @Published var postImagesView = false
    @Published var displayedPostID = ""
    @Published var postView = false
    
    private var _fullScreenPostVM: FullScreenGenericPostViewModel!
    var fullScreenPostVM: FullScreenGenericPostViewModel {
        return _fullScreenPostVM
    }
    
    private var _signUpVM: SignUpViewModel!
    var signUpVM: SignUpViewModel {
        return _signUpVM
    }
    private var _appTabVM: AppTabViewModel!
    var appTabVM: AppTabViewModel {
        return _appTabVM
    }
    
    private var _fullScreenPostImgVM: FullScreenPostImageViewModel!
    var fullScreenPostImgVM: FullScreenPostImageViewModel {
        return _fullScreenPostImgVM
    }
    
    private func passPostImages() {
        fullScreenPostImgVM.images = postImages
        fullScreenPostImgVM.openedImage = openedImage
    }
    
    func openPostImage(selected: String, images: [String]) {
        withAnimation {
            postImagesView.toggle()
            postImages = images
            openedImage = selected
            passPostImages()
        }
    }
    
    func dismissPostImage() {
        withAnimation {
            postImagesView.toggle()
            postImages = []
            openedImage = ""
        }
    }
    
    private func passPostData() {
        fullScreenPostVM.postID = displayedPostID
    }
    
    func openPost(postID: String) {
        postView.toggle()
        displayedPostID = postID
        passPostData()
    }
    
    
    init() {
        self.screenHeight = UIScreen.screenHeight
        self.appState = AppState.tabView
        self._signUpVM = SignUpViewModel(coordinator: self)
        self._appTabVM = AppTabViewModel(coordinator: self)
        self._fullScreenPostImgVM = FullScreenPostImageViewModel(coordinator: self)
        self._fullScreenPostVM = FullScreenGenericPostViewModel(coordinator: self)
    }
}
