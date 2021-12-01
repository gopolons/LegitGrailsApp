//
//  NetError.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

enum NetError: Error {
    case noConnection
    case invalidRequest
    
    var description: String {
        switch self {
        case .noConnection:
            return "No connection, please try again later"
        case .invalidRequest:
            return "Invalid request, please try again later"
        }
    }
}
