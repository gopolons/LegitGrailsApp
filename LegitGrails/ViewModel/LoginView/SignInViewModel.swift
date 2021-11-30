//
//  SignInViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SignInViewModel: ObservableObject {
// MARK: Stored parameters
    private var dataRepo: AuthenticationDataRepositoryProtocol
    var coordinator: SessionManagerObject

    @Published var email = ""
    @Published var password = ""
    @Published var navigateToForgotPassword = false
    @Published var passwordResetVM: PasswordResetViewModel
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var signInError = false
    @Published var signInErrorMsg = ""
    @Published var isLoading = false
    
// MARK: Methods
    func forgotPassword() {
        passwordResetVM = PasswordResetViewModel(coordinator: coordinator)
        navigateToForgotPassword.toggle()
    }
    
    func isValidEmail() {
        dataRepo.checkEmail(email) { response, err in
            guard err == nil else {
                withAnimation {
                    self.emailError = "Invalid email"
                }
                return
            }
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
        
        if self.emailError == "" && password != "" {
            withAnimation {
                self.isLoading.toggle()
            }
            dataRepo.signIn(email: email, password: password) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        withAnimation {
                            self.isLoading.toggle()
                        }
                        self.signInErrorMsg = "Invalid request, please try again later"
                        self.signInError.toggle()
                        return
                    case .noConnection:
                        withAnimation {
                            self.isLoading.toggle()
                        }
                        self.signInErrorMsg = "No connection, please try again later"
                        self.signInError.toggle()
                        return
                    case .none:
                        return
                    }
                }
                withAnimation {
                    self.isLoading.toggle()
                    self.coordinator.authToken = response!.authenticationToken
                }
            }
        } else {
            self.signInErrorMsg = "Invalid credentials, please check your data"
            self.signInError.toggle()
        }
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject, dataRepo: AuthenticationDataRepositoryProtocol = AuthenticationDataRepository()) {
        self.coordinator = coordinator
        self.passwordResetVM = PasswordResetViewModel(coordinator: coordinator)
        self.dataRepo = dataRepo
    }
}
