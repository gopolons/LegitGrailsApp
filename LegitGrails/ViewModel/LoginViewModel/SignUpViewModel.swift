//
//  SignUpViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI
import SPAlert

final class SignUpViewModel: ObservableObject {
// MARK: Stored parameters
    private var dataRepo: AuthenticationDataRepositoryProtocol
    var coordinator: SessionManagerObject

    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var userAgreement = false
    @Published var availableLogInServices = ["FacebookIcon", "GoogleIcon", "TwitterIcon"]
    @Published var navigateToSignIn = false
    @Published var signInVM: SignInViewModel
    @Published var usernameError = ""
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var tncError = false
    @Published var signUpError = false
    @Published var signUpErrorMsg = ""
    @Published var isLoading = false
    
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
        dataRepo.checkUserName(username) { response, err in
            guard err == nil else {
                switch err {
                case .invalid:
                    withAnimation {
                        self.usernameError = "Invalid username"
                    }
                    return
                default:
                    withAnimation {
                        self.usernameError = "Username is taken"
                    }
                    return
                }
            }
            withAnimation {
                self.usernameError = ""
            }
        }
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

    
    func isValidPassword() {
        dataRepo.checkPassword(password) { response, err in
            guard err == nil else {
                withAnimation {
                    self.passwordError = "Invalid password"
                }
                return
            }
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
            withAnimation {
                self.isLoading.toggle()
            }
            dataRepo.signUp(username: username, email: email, password: password) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        withAnimation {
                            self.isLoading.toggle()
                        }
                        self.signUpErrorMsg = "Invalid request, please try again later"
                        self.signUpError.toggle()
                        return
                    case .noConnection:
                        withAnimation {
                            self.isLoading.toggle()
                        }
                        self.signUpErrorMsg = "No connection, please try again later"
                        self.signUpError.toggle()
                        return
                    case .none:
                        return
                    }
                }
                withAnimation {
                    self.isLoading.toggle()
                    self.coordinator.authToken = response!.authenticationToken
                    self.coordinator.appState = .tabView
                }
            }
        } else {
            self.signUpErrorMsg = "Invalid credentials, please check your data"
            self.signUpError.toggle()
        }
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject, dataRepo: AuthenticationDataRepositoryProtocol = AuthenticationDataRepository()) {
        self.coordinator = coordinator
        self.signInVM = SignInViewModel(coordinator: coordinator)
        self.dataRepo = dataRepo
    }
}
