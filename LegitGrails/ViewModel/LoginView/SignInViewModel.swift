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
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var signInError = false
    @Published var signInErrorMsg = ""
    
    
    
// MARK: Methods
    func forgotPassword() {
        passwordResetVM = PasswordResetViewModel(coordinator: coordinator)
        navigateToForgotPassword.toggle()
    }
    
    func isValidEmail() {
        if email == "" {
            withAnimation {
                self.emailError = "Invalid email"
            }
        } else {
            withAnimation {
                self.emailError = ""
            }
        }
    }
    
    func isValidData() {
        isValidEmail()
    }
    
    func signIn() {
        isValidData()
        
        if self.emailError == "" && self.password != "" {
            print("success")
        } else {
            self.signInErrorMsg = "Invalid credentials, please check your data"
            self.signInError.toggle()
        }
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
        self.passwordResetVM = PasswordResetViewModel(coordinator: coordinator)
    }
}
