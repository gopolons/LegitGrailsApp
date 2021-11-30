//
//  Post.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

struct Post: Codable, Hashable {
    var ID: String
    var tags: [String]
    var userID: String
    var username: String
    var communityID: String
    var communityName: String
    var title: String
    var text: String
    var images: [String]
    var commentIDs: [String]
    var repostIDs: [String]
    var likeIDs: [String]
    var viewCountIDs: [String]
}
