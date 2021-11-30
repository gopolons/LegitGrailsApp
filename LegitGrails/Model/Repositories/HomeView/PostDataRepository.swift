//
//  PostDataRepository.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol PostDataRepositoryProtocol {
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void)
    
    func likePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
    
    func dislikePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
    
    func repost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
    
    func unrepost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void)
}

final class PostDataRepository: PostDataRepositoryProtocol {
    private var apiService: PostAPIServiceProtocol
    private var serviceManager: Reachability
    
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void) {
        if serviceManager.checkConnection() {
            apiService.fetchPosts { post, err in
                guard err == nil else {
                    completion(nil, err)
                    return
                }
                completion(post, nil)
            }
        } else {
            completion(nil, NetError.noConnection)
        }
    }
    
    func likePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        if serviceManager.checkConnection() {
            apiService.likePost(id: id, userID: userID) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        completion(nil, err)
                        return
                    case .noConnection:
                        completion(nil, err)
                        return
                    case .none:
                        return
                    }
                }
                completion(response, nil)
            }
        } else {
            completion(nil, NetError.noConnection)
        }
    }
    
    func dislikePost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        if serviceManager.checkConnection() {
            apiService.dislikePost(id: id, userID: userID) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        completion(nil, err)
                        return
                    case .noConnection:
                        completion(nil, err)
                        return
                    case .none:
                        return
                    }
                }
                completion(response, nil)
            }
        } else {
            completion(nil, NetError.noConnection)
        }

    }
    
    func repost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        if serviceManager.checkConnection() {
            apiService.repost(id: id, userID: userID) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        completion(nil, err)
                        return
                    case .noConnection:
                        completion(nil, err)
                        return
                    case .none:
                        return
                    }
                }
                completion(response, nil)
            }
        } else {
            completion(nil, NetError.noConnection)
        }

    }
    
    func unrepost(id: String, userID: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        if serviceManager.checkConnection() {
            apiService.unrepost(id: id, userID: userID) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        completion(nil, err)
                        return
                    case .noConnection:
                        completion(nil, err)
                        return
                    case .none:
                        return
                    }
                }
                completion(response, nil)
            }
        } else {
            completion(nil, NetError.noConnection)
        }

    }
    
    init(apiService: PostAPIServiceProtocol = PostApiService()) {
        self.apiService = apiService
        self.serviceManager = Reachability()
    }
}
