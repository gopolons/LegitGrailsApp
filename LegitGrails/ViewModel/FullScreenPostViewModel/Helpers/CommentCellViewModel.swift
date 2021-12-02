//
//  CommentCellViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

final class CommentCellViewModel: ObservableObject {
    @Published var comment: Comment! = Comment(ID: "1", username: "boljedorik", image: "", date: "1 Sep at 1:36 PM", text: "Fire shoes mf", comments: [Reply(ID: "", username: "zhopik", image: "", date: "1 Sep at 1:36 PM", text: "year fam"), Reply(ID: "", username: "zhopik", image: "", date: "1 Sep at 1:36 PM", text: "year fam"), Reply(ID: "", username: "zhopik", image: "", date: "1 Sep at 1:36 PM", text: "year fam"), Reply(ID: "", username: "zhopik", image: "", date: "1 Sep at 1:36 PM", text: "year fam")])
    @Published var tooManyComments: Bool = false
    @Published var selected = false
    @Published var shownComments = 2
    
    private var dataRepo: PostDataRepositoryProtocol
    
    var isSelected = false

    func commentPressed() {
        
    }
    
    func buttonPress() {
        withAnimation {
            tooManyComments = false
            shownComments = comment.comments.count
        }
    }


    
    
    var extraComments: Bool = true
    
    init(dataRepo: PostDataRepositoryProtocol = PostDataRepository(), comment: Comment) {
        self.dataRepo = dataRepo
        self.comment = comment
    }

}
