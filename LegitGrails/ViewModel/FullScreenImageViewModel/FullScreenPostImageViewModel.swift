//
//  FullScreenPostImageViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

final class FullScreenPostImageViewModel: ObservableObject {
    private var coordinator: SessionManagerObject
    
    @Published var images: [String]
    @Published var openedImage: String
    @Published var imageOffset: CGSize = .zero
    @Published var uiShown = true
    
    func dismissView() {
        coordinator.dismissPostImage()
    }
    
    func hideUI() {
        withAnimation {
            uiShown.toggle()
        }
    }
    
    func onDisappear() {
        imageOffset = .zero
    }
    
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
        self.images = coordinator.postImages
        self.openedImage = coordinator.openedImage
    }
}
