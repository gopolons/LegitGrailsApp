//
//  SignInViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var navigateToForgotPassword = false
    
    func forgotPassword() {
        navigateToForgotPassword.toggle()
    }
}
