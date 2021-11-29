//
//  SignUpViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
// MARK: Stored parameters
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var userAgreement = false
    @Published var availableLogInServices = ["FacebookIcon", "GoogleIcon", "TwitterIcon"]
    @Published var navigateToSignIn = false
    var coordinator: SessionManagerObject
    @Published var signInVM: SignInViewModel
    @Published var usernameError = ""
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var tncError = false
    @Published var signUpError = false
    @Published var signUpErrorMsg = ""
    @Published var errors: [LoginUIError] = []
    
// MARK: Methods
    func signIn() {
        signInVM = SignInViewModel(coordinator: coordinator)
        navigateToSignIn.toggle()
    }
    
    func userAgreementTap() {
        if userAgreement {
            withAnimation {
                tncError = false
            }
        }
    }
    
    func isValidUsername() {
        if username == "" {
            withAnimation {
                self.usernameError = "Invalid username"
            }
        } else {
            withAnimation {
                self.usernameError = ""
            }
        }
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
    
    func isValidPassword() {
        if password == "" {
            withAnimation {
                self.passwordError = "Invalid password"
            }
        } else {
            withAnimation {
                self.passwordError = ""
            }
        }
    }
    
    func isValidTNC() {
        if !userAgreement {
            withAnimation {
                self.tncError = true
            }
        }
    }
    
    func isValidData() {
        isValidEmail()
        isValidPassword()
        isValidUsername()
        isValidTNC()
    }
    
    func signUp() {
        isValidData()
        
        if self.emailError == "" && self.usernameError == "" && self.passwordError == "" && self.tncError == false {
            print("success")
        } else {
            self.signUpErrorMsg = "Invalid credentials, please check your data"
            self.signUpError.toggle()
        }
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
        self.signInVM = SignInViewModel(coordinator: coordinator)
    }
}
