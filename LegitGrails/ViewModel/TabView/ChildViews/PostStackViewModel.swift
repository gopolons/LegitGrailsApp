//
//  PostStackViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

final class PostStackViewModel: ObservableObject {
    
    private var dataRepo: PostDataRepositoryProtocol
    
    @Published var posts: [Post] = []
    
    private func fetchPosts() {
        dataRepo.fetchPosts { post, err in
            guard err == nil else {
                return
            }
            withAnimation {
                self.posts.append(post!)
            }
        }
    }
    
    func onAppear() {
        fetchPosts()
    }
    
    init(dataRepo: PostDataRepositoryProtocol = PostDataRepository()) {
        self.dataRepo = dataRepo
    }
}
