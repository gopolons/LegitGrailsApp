//
//  SignInViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SignInViewModel: ObservableObject {
// MARK: Stored parameters
    @Published var email = ""
    @Published var password = ""
    @Published var navigateToForgotPassword = false
    var coordinator: SessionManagerObject
    @Published var passwordResetVM: PasswordResetViewModel
    
    
// MARK: Methods
    func forgotPassword() {
        passwordResetVM = PasswordResetViewModel(coordinator: coordinator)
        navigateToForgotPassword.toggle()
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
        self.passwordResetVM = PasswordResetViewModel(coordinator: coordinator)
    }
}
