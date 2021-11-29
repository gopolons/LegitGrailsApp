//
//  SignInView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI
import SPAlert
import Focuser

struct SignInView: View {
    
    @StateObject var modelData: SignInViewModel
    
    @Environment(\.presentationMode) var presentation
    
    @FocusStateLegacy var focusedFields: SignInFormFields?
    
    var body: some View {
        NavigationView {
            VStack {

                VStack(spacing: 15) {
                    LegitGrailsLogo()
                    Text("Welcome back!")
                        .font(.largeTitle)
                        .bold()
                    Text("Login to start authentication")
                        .foregroundColor(.gray)
                    
                }
                .padding(.top, 20)
     
                VStack {

                    LoginTextInput(placeholder: "Email", error: $modelData.emailError, input: $modelData.email)
                        .onChange(of: modelData.email) { _ in
                            modelData.isValidEmail()
                        }
                        .keyboardType(.emailAddress)
                        .focusedLegacy($focusedFields, equals: .email)
                    ZStack {
                        LoginTextInputSecure(placeholder: "Password", error: $modelData.passwordError, input: $modelData.password)
                            .focusedLegacy($focusedFields, equals: .password)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                modelData.forgotPassword()
                            } label: {
                                Text("Forgot password?")
                                    .font(.footnote)
                                    .bold()
                            }
                        }
                        .padding()
                    }
                }
                .padding(.vertical, 60)
                
                
                Spacer()
                
                VStack {
                    ConfirmButton(text: "Log in") {
                        modelData.signIn()
                    }
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                            
                            Button {
                                presentation.wrappedValue.dismiss()
                            } label: {
                                Text("Sign up")
                            }
                        }
                    }
                    .padding(.top, 40)

                }
                .padding(.bottom, 105)

                NavigationLink(isActive: $modelData.navigateToForgotPassword) {
                    PasswordResetView(modelData: modelData.passwordResetVM)
                        .navigationTitle("Reset password")
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image("LegitGrails")
                                    .resizable()
                                    .frame(width: 70, height: 50)          
                            }
                        }

                } label: {
                    Text("")
                }
                .hidden()

            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .spAlert(isPresent: $modelData.signInError, title: "Error", message: modelData.signInErrorMsg, duration: 1, dismissOnTap: true, preset: .error, haptic: .error, layout: .message()) {
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(modelData: SignInViewModel(coordinator: SessionManagerObject()))
    }
}
