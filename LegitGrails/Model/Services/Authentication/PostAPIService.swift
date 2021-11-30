//
//  PostAPIService.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol PostAPIServiceProtocol {
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void)
}

final class PostApiService: PostAPIServiceProtocol {
    var posts = [Post(ID: "1", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "2", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "3", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "4", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "5", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"])]
    
    
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void) {
        for x in posts {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion(x, nil)
            }
        }
    }
}
