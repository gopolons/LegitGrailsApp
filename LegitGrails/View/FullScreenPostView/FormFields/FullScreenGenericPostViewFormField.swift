//
//  FullScreenGenericPostViewFormField.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import Foundation
import Focuser

enum FullScreenGenericPostViewFormField {
    case input
}

extension FullScreenGenericPostViewFormField: FocusStateCompliant {

    static var last: FullScreenGenericPostViewFormField {
        .input
    }

    var next: FullScreenGenericPostViewFormField? {
        switch self {
        default: return FullScreenGenericPostViewFormField.input
        }
    }
}
