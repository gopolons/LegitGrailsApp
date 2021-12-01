//
//  PostViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

final class PostViewModel: ObservableObject {
    private var dataRepo: PostDataRepositoryProtocol
    private var coordinator: SessionManagerObject
    
    @Published var post: Post
    @Published var liked = false
    @Published var reposted = false
    @Published var editedText = ""
    @Published var extended = false
    @Published var lineLimit = 2
    @Published var alert = false
    @Published var alertMessage = ""
    
    func onAppear() {
        if !(post.text.count > 100) {
            extended = true
        }
        
        if post.likeIDs.contains(coordinator.userID) {
            liked = true
        }
        
        if post.repostIDs.contains(coordinator.userID) {
            reposted = true
        }
        
    }
    
    func openImage(selectedImg: String) {
        coordinator.openPostImage(selected: selectedImg, images: post.images)
    }
    
    func extendPost() {
        withAnimation {
            extended = true
            lineLimit = 50
        }
    }
    
    func likePressed() {
        if liked {
            dislike()
        } else {
            like()
        }
    }
    
    private func like() {
        liked.toggle()
        post.likeIDs.append(coordinator.userID)
        dataRepo.likePost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
                switch err {
                case .invalidRequest:
                    self.alertMessage = "Invalid request, please try again later"
                    self.alert.toggle()
                    self.post.likeIDs.remove(at: likeIndex!)
                    self.liked.toggle()
                    return
                case .noConnection:
                    self.alertMessage = "No connection, please try again later"
                    self.alert.toggle()
                    self.post.likeIDs.remove(at: likeIndex!)
                    self.liked.toggle()
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func dislike() {
        liked.toggle()
        let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
        self.post.likeIDs.remove(at: likeIndex!)
        dataRepo.likePost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.alertMessage = "Invalid request, please try again later"
                    self.alert.toggle()
                    self.post.likeIDs.append(self.coordinator.userID)
                    self.liked.toggle()
                    return
                case .noConnection:
                    self.alertMessage = "No connection, please try again later"
                    self.alert.toggle()
                    self.post.likeIDs.append(self.coordinator.userID)
                    self.liked.toggle()
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func repost() {
        reposted.toggle()
        post.repostIDs.append(coordinator.userID)
        dataRepo.repost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
                switch err {
                case .invalidRequest:
                    self.alertMessage = "Invalid request, please try again later"
                    self.alert.toggle()
                    self.post.repostIDs.remove(at: repostIndex!)
                    self.reposted.toggle()
                    return
                case .noConnection:
                    self.alertMessage = "No connection, please try again later"
                    self.alert.toggle()
                    self.post.repostIDs.remove(at: repostIndex!)
                    self.reposted.toggle()
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func unrepost() {
        reposted.toggle()
        let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
        self.post.repostIDs.remove(at: repostIndex!)
        dataRepo.unrepost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.alertMessage = "Invalid request, please try again later"
                    self.alert.toggle()
                    self.post.repostIDs.append(self.coordinator.userID)
                    self.reposted.toggle()
                    return
                case .noConnection:
                    self.alertMessage = "No connection, please try again later"
                    self.alert.toggle()
                    self.post.repostIDs.append(self.coordinator.userID)
                    self.reposted.toggle()
                    return
                case .none:
                    return
                }
            }
        }
        
    }
    
    func repostPressed() {
        if reposted {
            unrepost()
        } else {
            repost()
        }
    }
    
    init(post: Post, coordinator: SessionManagerObject) {
        self.dataRepo = PostDataRepository()
        self.post = post
        self.coordinator = coordinator
    }
}
