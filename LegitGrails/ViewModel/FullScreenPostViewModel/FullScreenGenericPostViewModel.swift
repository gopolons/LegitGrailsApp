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
//    MARK: CHANGE COMMENTS FOR PRODUCTION
    @Published var post: Post!

    @Published var alert = false
    @Published var alertMessage = ""
    @Published var connectionError = false
    @Published var selectedCommentID = ""
    @Published var likeCount = 0
    @Published var repostCount = 0
    @Published var commentCount = 0
    @Published var viewCount = 0
    
    private var coordinator: SessionManagerObject
    private var dataRepo: PostDataRepositoryProtocol
    private var _commentStackVM: CommentStackViewModel!
    var commentStackVM: CommentStackViewModel {
        return _commentStackVM
    }
    
    private func updateFooter() {
        likeCount = post.likeIDs.count
        repostCount = post.repostIDs.count
        commentCount = post.commentIDs.count
        viewCount = post.viewCountIDs.count
    }
    
    func showImages(_ img: String) {
        coordinator.openPostImage(selected: img, images: post.images)
    }
    
    func pressedLike() {
        liked ? dislike() : like()
        updateFooter()
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
        updateFooter()
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
        //  MARK: UNCOMMENT FOR PRODUCTION
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

            self._commentStackVM = CommentStackViewModel(commentIDs: post!.commentIDs, postCoordinator: self)

            if post!.likeIDs.contains(self.coordinator.userID) {
                self.liked = true
            }

            if post!.repostIDs.contains(self.coordinator.userID) {
                self.reposted = true
            }


            withAnimation {
                self.post = post!
            }
            
            self.updateFooter()

        }

    }
    
    func changeSelectedComment(_ id: String) {
        withAnimation {
            self.selectedCommentID = id
        }
    }
    
    init(coordinator: SessionManagerObject, dataRepo: PostDataRepositoryProtocol = PostDataRepository()) {
        self.coordinator = coordinator
        self.dataRepo = dataRepo
        self._commentStackVM = CommentStackViewModel(commentIDs: [], postCoordinator: self)
    }
}
