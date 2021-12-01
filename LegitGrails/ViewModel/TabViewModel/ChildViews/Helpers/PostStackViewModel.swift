//
//  PostStackViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI
import SPAlert

final class PostStackViewModel: ObservableObject {
    private var coordinator: SessionManagerObject
    private var dataRepo: PostDataRepositoryProtocol
    
    @Published var posts: [Post] = []
    @Published var alert = false
    @Published var alertMessage = ""
    @Published var alertPreset: SPAlertIconPreset = .error
    @Published var alertHaptic: SPAlertHaptic = .none
    @Published var error = false
    
    private func fetchPosts() {
        dataRepo.fetchPosts { post, err in
            guard err == nil else {
                switch err {
                case .noConnection:
                    self.alertMessage = err!.description
                    self.alertPreset = .error
                    self.alertHaptic = .error
                    self.alert.toggle()
                    self.error = true
                    return
                case .invalidRequest:
                    self.alertMessage = err!.description
                    self.alertPreset = .error
                    self.alertHaptic = .error
                    self.alert.toggle()
                    self.error = true
                    return
                case .none:
                    return
                }
            }
            withAnimation {
                if !self.posts.contains(post!) {
                    self.posts.append(post!)
                }
            }
        }
    }
    
    func onAppear() {
        error = false
        fetchPosts()
    }
    
    func getCoordinator() -> SessionManagerObject {
        return self.coordinator
    }
    
    init(coordinator: SessionManagerObject) {
        self.dataRepo = PostDataRepository()
        self.coordinator = coordinator
    }
}
