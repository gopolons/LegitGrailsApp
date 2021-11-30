//
//  PostDataRepository.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol PostDataRepositoryProtocol {
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void)
}

final class PostDataRepository: PostDataRepositoryProtocol {
    private var apiService: PostAPIServiceProtocol
    
    func fetchPosts(completion: @escaping (Post?, NetError?) -> Void) {
        apiService.fetchPosts { post, err in
            guard err == nil else {
                completion(nil, err)
                return
            }
            completion(post, nil)
        }
    }
    
    init(apiService: PostAPIServiceProtocol = PostApiService()) {
        self.apiService = apiService
    }
}
