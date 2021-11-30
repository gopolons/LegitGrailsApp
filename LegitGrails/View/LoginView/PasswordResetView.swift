//
//  PasswordResetView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI
import SPAlert

struct PasswordResetView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @StateObject var modelData: PasswordResetViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                LoginTextInput(placeholder: "Email", error: $modelData.emailError, input: $modelData.email)
                    .onChange(of: modelData.email) { _ in
                        modelData.isValidEmail()
                    }
                
                ConfirmButton(text: "Reset password") {
                    hideKeyboard()
                    modelData.restorePassword()
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)

        }
        .spAlert(isPresent: $modelData.restorePasswordAlert, title: modelData.restorePasswordAlertTitle, message: modelData.restorePasswordAlertText, duration: 1, dismissOnTap: true, preset: modelData.restorePasswordAlertPreset, haptic: modelData.restorePasswordAlertHaptic, layout: .message()) {
            
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView(modelData: PasswordResetViewModel(coordinator: SessionManagerObject()))
    }
}
