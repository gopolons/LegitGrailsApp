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
    
// MARK: Methods
    func signIn() {
        signInVM = SignInViewModel(coordinator: coordinator)
        navigateToSignIn.toggle()
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
        self.signInVM = SignInViewModel(coordinator: coordinator)
    }
}
