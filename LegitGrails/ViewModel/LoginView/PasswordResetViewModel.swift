//
//  PasswordResetViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import Foundation

final class PasswordResetViewModel: ObservableObject {
// MARK: Stored parameters
    @Published var email = ""
    
    var coordinator: SessionManagerObject
    
// MARK: Initialization
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
    }
}
