//
//  CommentCellViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

final class CommentCellViewModel: ObservableObject {
    @Published var comment: Comment! 
    @Published var tooManyComments: Bool = false
    @Published var selected = false
    @Published var shownComments = 2    
    private var dataRepo: PostDataRepositoryProtocol
    
    private var _commentStackCoordinator: CommentStackViewModel
    var commentStackCoordinator: CommentStackViewModel {
        return _commentStackCoordinator
    }

    func commentPressed() {
        commentStackCoordinator.changeSelectedComment(comment.ID)
    }
    
    func buttonPress() {
        withAnimation {
            tooManyComments = false
            shownComments = comment.comments.count
        }
    }

    var extraComments: Bool = true
    
    init(dataRepo: PostDataRepositoryProtocol = PostDataRepository(), comment: Comment, commentStackCoordinator: CommentStackViewModel) {
        self.dataRepo = dataRepo
        self.comment = comment
        self._commentStackCoordinator = commentStackCoordinator
    }
}
