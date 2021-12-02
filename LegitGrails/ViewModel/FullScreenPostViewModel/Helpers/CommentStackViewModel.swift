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
    
    @Published var commentsUnavailable = false
    
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
    
    
    init(commentIDs: [String]) {
        self.dataRepo = PostDataRepository()
        self.commentIDs = commentIDs
    }
}
