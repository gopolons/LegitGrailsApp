//
//  CommentStackViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

final class CommentStackViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    
    private var commentIDs: [String]
    
    private var dataRepo: PostDataRepository
    
    var postCoordinator: FullScreenGenericPostViewModel
    
    @Published var commentsUnavailable = false
    
    @Published var selectedComment = ""
    
    private func fetchData() {
        for id in commentIDs {
            dataRepo.fetchComment(id: id) { data, err in
                guard err == nil else {
                    switch err {
                    case .noConnection:
                        return
                    case .invalidRequest:
                        return
                    case .none:
                        return
                    }
                }
                withAnimation {
                    self.comments.append(data!)
                }
            }
        }
    }
    
    func onAppear() {
        if commentIDs.isEmpty {
            commentsUnavailable = true
        } else {
            fetchData()
        }
    }
    
    
    func changeSelectedComment(_ id: String) {
        withAnimation {
            selectedComment = id
        }
        postCoordinator.changeSelectedComment(id)
    }
    
    
    init(commentIDs: [String], postCoordinator: FullScreenGenericPostViewModel) {
        self.dataRepo = PostDataRepository()
        self.commentIDs = commentIDs
        self.postCoordinator = postCoordinator
    }
}
