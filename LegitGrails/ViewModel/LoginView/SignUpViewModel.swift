//
//  SignUpViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SignUpViewModel: ObservableObject {
//    Variables tracked by the view
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var userAgreement = false
    @Published var availableLogInServices = ["FacebookIcon", "GoogleIcon", "TwitterIcon"]
    @Published var navigateToSignIn = false
    
    func signIn() {
        navigateToSignIn.toggle()
    }
}
