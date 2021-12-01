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
    var coordinator: SessionManagerObject
    private var dataRepo: AuthenticationDataRepositoryProtocol
    
    @Published var email = ""
    @Published var emailError = ""
    @Published var restorePasswordAlert = false
    @Published var restorePasswordAlertTitle = ""
    @Published var restorePasswordAlertText = ""
    @Published var restorePasswordAlertPreset: SPAlertIconPreset = .done
    @Published var restorePasswordAlertHaptic: SPAlertHaptic = .none
    @Published var isLoading = false
        
// MARK: Methods
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
    
    func restorePassword() {
        isValidData()
        if emailError == "" {
            withAnimation {
                self.isLoading.toggle()
            }
            dataRepo.restorePasswordWithEmail(email) { response, err in
                guard err == nil else {
                    switch err {
                    case .invalidRequest:
                        withAnimation {
                            self.isLoading.toggle()
                        }
                        self.restorePasswordAlertTitle = "Error!"
                        self.restorePasswordAlertText = err!.description
                        self.restorePasswordAlertHaptic = .error
                        self.restorePasswordAlertPreset = .error
                        self.restorePasswordAlert = true
                        return
                    case .noConnection:
                        withAnimation {
                            self.isLoading.toggle()
                        }
                        self.restorePasswordAlertTitle = "Error!"
                        self.restorePasswordAlertText = err!.description
                        self.restorePasswordAlertHaptic = .error
                        self.restorePasswordAlertPreset = .error
                        self.restorePasswordAlert = true
                        return
                    case .none:
                        return
                    }
                }
                withAnimation {
                    self.isLoading.toggle()
                }
                self.restorePasswordAlertTitle = "Success!"
                self.restorePasswordAlertText = "Check your email for the password restoration link"
                self.restorePasswordAlertHaptic = .success
                self.restorePasswordAlertPreset = .done
                self.restorePasswordAlert = true
            }
        } else {
            self.restorePasswordAlertTitle = "Error!"
            self.restorePasswordAlertText = "Check your email and try again"
            self.restorePasswordAlertHaptic = .error
            self.restorePasswordAlertPreset = .error
            self.restorePasswordAlert = true
        }
    }
    
// MARK: Initialization
    init(coordinator: SessionManagerObject, dataRepo: AuthenticationDataRepositoryProtocol = AuthenticationDataRepository()) {
        self.coordinator = coordinator
        self.dataRepo = dataRepo
    }
}
