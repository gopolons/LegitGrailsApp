//
//  Comment.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import Foundation

struct Reply: Codable, Hashable {
    var ID: String
    var userID: String
    var username: String
    var image: String
    var date: String
    var text: String
}

struct Comment: Codable, Hashable {
    var ID: String
    var userID: String
    var username: String
    var image: String
    var date: String
    var text: String
    var comments: [Reply]
}
