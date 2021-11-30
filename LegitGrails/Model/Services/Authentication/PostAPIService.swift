//
//  PostAPIService.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol PostAPIServiceProtocol {
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void)
    
    func likePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
    
    func dislikePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
    
    func repost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
    
    func unrepost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)

}

final class PostApiService: PostAPIServiceProtocol {
    var posts = [Post(ID: "1", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa", "test"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "2", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "3", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "4", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"]), Post(ID: "5", tags: ["thoughts"], userID: "", username: "username", communityID: "", communityName: "👜 Luxury lovers", title: "Here's how you can check your Gucci GG!", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", images: [], commentIDs: ["fd", "fds", "fdsa"], repostIDs: ["fd", "fds", "fdsa"], likeIDs: ["fd", "fds", "fdsa"], viewCountIDs: ["fd", "fds", "fdsa"])]
        
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void) {
        for x in posts {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                completion(x, nil)
            }
        }
    }
    
    func repost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        let post = posts.filter { post in
            post.ID == id
        }
        let index = posts.firstIndex(of: post.first!)
        
        posts[index!].repostIDs.append(userID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion(.success, nil)
        }
    }
    
    func unrepost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        let post = posts.filter { post in
            post.ID == id
        }
        let index = posts.firstIndex(of: post.first!)
        
        let userIndex = posts[index!].repostIDs.firstIndex(of: userID)
        
        posts[index!].repostIDs.remove(at: userIndex!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion(.success, nil)
        }
    }
    
    
    func likePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        let post = posts.filter { post in
            post.ID == id
        }
        let index = posts.firstIndex(of: post.first!)
        
        posts[index!].likeIDs.append(userID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion(.success, nil)
        }
        
    }
    
    func dislikePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        let post = posts.filter { post in
            post.ID == id
        }
        let index = posts.firstIndex(of: post.first!)
        
        let userIndex = posts[index!].likeIDs.firstIndex(of: userID)
        
        posts[index!].likeIDs.remove(at: userIndex!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            completion(.success, nil)
        }
    }
}
