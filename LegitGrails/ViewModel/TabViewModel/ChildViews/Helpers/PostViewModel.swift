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
    @Published var likeCount = 0
    @Published var repostCount = 0
    @Published var commentCount = 0
    @Published var viewCount = 0
    
    private func updateFooter() {
        likeCount = post.likeIDs.count
        repostCount = post.repostIDs.count
        commentCount = post.commentIDs.count
        viewCount = post.viewCountIDs.count
        if post.likeIDs.contains(self.coordinator.userID) {
            self.liked = true
        } else {
            self.liked = false
        }
        
        if post.repostIDs.contains(self.coordinator.userID) {
            self.reposted = true
        } else {
            self.reposted = false
        }
    }
    
    func onAppear() {
        dataRepo.fetchPost(id: post.ID) { data, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    return
                case .noConnection:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    return
                case .none:
                    return
                }
            }
            
            self.post = data!
            
            self.updateFooter()
            
            if !(data!.text.count > 100) {
                self.extended = true
            }

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
        updateFooter()
    }
    
    func openPost() {
        coordinator.openPost(postID: post.ID)
    }
    
    private func like() {
        liked = true
        post.likeIDs.append(coordinator.userID)
        dataRepo.likePost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
                switch err {
                case .invalidRequest:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.likeIDs.remove(at: likeIndex!)
                    self.liked = false
                    return
                case .noConnection:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.likeIDs.remove(at: likeIndex!)
                    self.liked = false
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func dislike() {
        liked = false
        let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
        self.post.likeIDs.remove(at: likeIndex!)
        dataRepo.dislikePost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.likeIDs.append(self.coordinator.userID)
                    self.liked = true
                    return
                case .noConnection:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.likeIDs.append(self.coordinator.userID)
                    self.liked = true
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func repost() {
        reposted = true
        post.repostIDs.append(coordinator.userID)
        dataRepo.repost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
                switch err {
                case .invalidRequest:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.repostIDs.remove(at: repostIndex!)
                    self.reposted = false
                    return
                case .noConnection:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.repostIDs.remove(at: repostIndex!)
                    self.reposted = false
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func unrepost() {
        reposted = false
        let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
        self.post.repostIDs.remove(at: repostIndex!)
        dataRepo.unrepost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.repostIDs.append(self.coordinator.userID)
                    self.reposted = true
                    return
                case .noConnection:
                    self.alertMessage = err!.description
                    self.alert.toggle()
                    self.post.repostIDs.append(self.coordinator.userID)
                    self.reposted = true
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
        updateFooter()
    }
    
    init(post: Post, coordinator: SessionManagerObject) {
        self.dataRepo = PostDataRepository()
        self.post = post
        self.coordinator = coordinator
    }
}
