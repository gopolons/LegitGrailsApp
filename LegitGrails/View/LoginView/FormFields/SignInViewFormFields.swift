//
//  SignInViewFormFields.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import Foundation
import Focuser

enum SignInFormFields {
    case email, password, none
}

extension SignInFormFields: FocusStateCompliant {

    static var last: SignInFormFields {
        .password
    }

    var next: SignInFormFields? {
        switch self {
        case .email:
            return .password
        default: return SignInFormFields.none
        }
    }
}

