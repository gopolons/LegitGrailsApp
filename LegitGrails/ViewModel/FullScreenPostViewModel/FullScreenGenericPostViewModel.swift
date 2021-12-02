//
//  FullScreenGenericPostViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 01/12/2021.
//

import SwiftUI

final class FullScreenGenericPostViewModel: ObservableObject {
    @Published var postID = ""
    @Published var liked = false
    @Published var reposted = false
//    MARK: UNCOMMENT FOR PRODUCTION
    @Published var post: Post!
//    @Published var post: Post! = Post(ID: "1", tags: ["DEBUG POST"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: ["HowItWorksLink", "AuthenticateLink", "PracticeLink"], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa", "test"], viewCountIDs: ["fd", "fds", "fdsa"])

    @Published var alert = false
    @Published var alertMessage = ""
    @Published var connectionError = false
    @Published var selectedCommentID = ""
    
    private var coordinator: SessionManagerObject
    private var dataRepo: PostDataRepositoryProtocol
    var commentStackVM = CommentStackViewModel(commentIDs: [])
    
    func showImages(_ img: String) {
        coordinator.openPostImage(selected: img, images: post.images)
    }
    
    func pressedLike() {
        liked ? dislike() : like()
    }
    
    private func dislike() {
        let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
        self.post.likeIDs.remove(at: likeIndex!)
        liked = false
        dataRepo.dislikePost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.showAlert(err!)
                    self.post.likeIDs.append(self.coordinator.userID)
                    self.liked = true
                    return
                case .noConnection:
                    self.showAlert(err!)
                    self.post.likeIDs.append(self.coordinator.userID)
                    self.liked = true
                    return
                case .none:
                    return
                }
            }
            
        }
    }
    
    private func like() {
        post.likeIDs.append(coordinator.userID)
        liked = true
        dataRepo.likePost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.showAlert(err!)
                    let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
                    self.post.likeIDs.remove(at: likeIndex!)
                    self.liked = false
                    return
                case .noConnection:
                    self.showAlert(err!)
                    let likeIndex = self.post.likeIDs.firstIndex(of: self.coordinator.userID)
                    self.post.likeIDs.remove(at: likeIndex!)
                    self.liked = false
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    func pressedRepost() {
        reposted ? unrepost() : repost()
    }
    
    private func unrepost() {
        let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
        self.post.repostIDs.remove(at: repostIndex!)
        reposted = false
        dataRepo.unrepost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.showAlert(err!)
                    self.post.repostIDs.append(self.coordinator.userID)
                    self.reposted = true
                    return
                case .noConnection:
                    self.showAlert(err!)
                    self.post.repostIDs.append(self.coordinator.userID)
                    self.reposted = true
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func repost() {
        post.repostIDs.append(coordinator.userID)
        reposted = true
        dataRepo.repost(id: post.ID, userID: coordinator.userID) { response, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.showAlert(err!)
                    let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
                    self.post.repostIDs.remove(at: repostIndex!)
                    self.reposted = false
                    return
                case .noConnection:
                    self.showAlert(err!)
                    let repostIndex = self.post.repostIDs.firstIndex(of: self.coordinator.userID)
                    self.post.repostIDs.remove(at: repostIndex!)
                    self.reposted = false
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    func onDisappear() {
        self.post = nil
        self.postID.removeAll()
        self.liked = false
        self.reposted = false
    }
    
    private func showAlert(_ err: NetError) {
        self.alertMessage = err.description
        self.alert = true
    }
    
    func onAppear() {
//  MARK: UNCOMMENT FOR PRODUCTION
        dataRepo.fetchPost(id: postID) { post, err in
            guard err == nil else {
                switch err {
                case .invalidRequest:
                    self.connectionError.toggle()
                    return
                case .noConnection:
                    self.connectionError.toggle()
                    return
                case .none:
                    return
                }
            }
            
            self.commentStackVM = CommentStackViewModel(commentIDs: post!.commentIDs)

            if post!.likeIDs.contains(self.coordinator.userID) {
                self.liked = true
            }

            if post!.repostIDs.contains(self.coordinator.userID) {
                self.reposted = true
            }
        

            withAnimation {
                self.post = post!
            }
        }
    }
    
    init(coordinator: SessionManagerObject, dataRepo: PostDataRepositoryProtocol = PostDataRepository()) {
        self.coordinator = coordinator
        self.dataRepo = dataRepo
    }
}
