//
//  FullScreenGenericPostDebugViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 01/12/2021.
//

import SwiftUI

final class FullScreenGenericPostDebugViewModel: ObservableObject {
    @Published var postID = ""
    @Published var liked = false
    @Published var reposted = false
    @Published var post = Post(ID: "1", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa", "test"], viewCountIDs: ["fd", "fds", "fdsa"])
    @Published var alert = false
    @Published var alertMessage = ""
    @Published var connectionError = false
    
    func showImages(_ img: String) {
        
    }
    
    func pressedLike() {
        liked ? dislike() : like()
    }
    
    private func dislike() {
        liked = false
    }
    
    private func like() {
        liked = true
    }
    
    func pressedRepost() {
        reposted ? unrepost() : repost()
    }
    
    private func unrepost() {
        reposted = false
    }
    
    private func repost() {
        reposted = true
    }
    
    func onDisappear() {
        
    }
    
    private func showAlert(_ err: NetError) {

    }
    
    func onAppear() {

    }
}
