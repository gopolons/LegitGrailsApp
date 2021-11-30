//
//  PasswordResetViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI
import SPAlert

final class PasswordResetViewModel: ObservableObject {
// MARK: Stored parameters
    @Published var email = ""
    @Published var emailError = ""
    @Published var restorePasswordAlert = false
    @Published var restorePasswordAlertTitle = ""
    @Published var restorePasswordAlertText = ""
    @Published var restorePasswordAlertPreset: SPAlertIconPreset = .done
    @Published var restorePasswordAlertHaptic: SPAlertHaptic = .none
    
    var coordinator: SessionManagerObject
    
// MARK: Methods
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
    
    func restorePassword() {
        isValidData()
        
        if emailError == "" {
            self.restorePasswordAlertTitle = "Success!"
            self.restorePasswordAlertText = "Check your email for the password restoration link"
            self.restorePasswordAlertHaptic = .success
            self.restorePasswordAlertPreset = .done
            self.restorePasswordAlert = true
        } else {
            self.restorePasswordAlertTitle = "Error!"
            self.restorePasswordAlertText = "Check your email and try again"
            self.restorePasswordAlertHaptic = .error
            self.restorePasswordAlertPreset = .error
            self.restorePasswordAlert = true
        }
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
    }
}
