//
//  SignUpViewFormFields.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import Foundation
import Focuser

enum SignUpFormFields {
    case username, email, password, none
}

extension SignUpFormFields: FocusStateCompliant {

    static var last: SignUpFormFields {
        .password
    }

    var next: SignUpFormFields? {
        switch self {
        case .username:
            return .email
        case .email:
            return .password
        default: return SignUpFormFields.none
        }
    }
}
