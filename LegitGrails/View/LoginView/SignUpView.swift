//
//  SignUpView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI
import SPAlert
import Focuser

struct SignUpView: View {
    
    @StateObject var modelData: SignUpViewModel
    
    @FocusStateLegacy var focusedFields: SignUpFormFields?
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {

                    VStack(spacing: UIScreen.screenHeight <= 736 ? 5 : 15) {
                        LegitGrailsLogo()
                        Text("Welcome!")
                            .font(.largeTitle)
                            .bold()
                        Text("Sign up to start authentication")
                            .foregroundColor(.gray)
                    }
         
                    VStack {
                        LoginTextInput(placeholder: "Username", error: $modelData.usernameError, input: $modelData.username)
                            .onChange(of: modelData.username) { _ in
                                modelData.isValidUsername()
                            }
                            .focusedLegacy($focusedFields, equals: .username)
                        
                        LoginTextInput(placeholder: "Email", error: $modelData.emailError, input: $modelData.email)
                            .onChange(of: modelData.email) { _ in
                                modelData.isValidEmail()
                            }
                            .focusedLegacy($focusedFields, equals: .email)
                            .keyboardType(.emailAddress)
                        
                        LoginTextInputSecure(placeholder: "Password", error: $modelData.passwordError, input: $modelData.password)
                            .onChange(of: modelData.password) { _ in
                                modelData.isValidPassword()
                            }
                            .focusedLegacy($focusedFields, equals: .password)
                        
                        HStack(spacing: 0) {
                            ToggleCheckbox(toggled: $modelData.userAgreement)
                                .padding(.horizontal)
                                .onChange(of: modelData.userAgreement) { _ in
                                    modelData.userAgreementTap()
                                }
                            
                            Text("I agree with")
                                .foregroundColor(.gray)
                            Button {
                                
                            } label: {
                                Text(" terms and conditions")

                            }
                            
                            Spacer()
                            
                            if modelData.tncError {
                                Image(systemName: "xmark.octagon")
                                    .foregroundColor(.red)
                                    .padding(.horizontal)
                            }
                            
                        }
                        .padding(.top)
                        
                    }
                    .padding(.vertical, UIScreen.screenHeight <= 736 ? 10 : 20)
                    

                    ConfirmButton(text: "Create account") {
                        self.focusedFields = SignUpFormFields.none
                        hideKeyboard()
                        modelData.signUp()
                    }
                    
                    VStack(spacing: 0) {
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.gray)
                            
                            Button {
                                modelData.signIn()
                            } label: {
                                Text("Sign in")
                            }
                        }
                        
                        HStack {
                            
                            ForEach(modelData.availableLogInServices, id: \.self) { ac in
                                Button {
                                    
                                } label: {
                                    Image(ac)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding()
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(true)
                                    
                            }
                        }
                    }
                    .padding(.top, UIScreen.screenHeight <= 736 ? 10 : 40)
                    
                    NavigationLink(isActive: $modelData.navigateToSignIn) {
                        SignInView(modelData: modelData.signInVM)
                            .navigationTitle("")
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    } label: {
                        Text("")
                    }
                    .hidden()
                }
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            .spAlert(isPresent: $modelData.signUpError, title: "Error", message: modelData.signUpErrorMsg, duration: 1, dismissOnTap: true, preset: .error, haptic: .error, layout: .message()) {
                
            }
            if modelData.isLoading {
                ActivityIndicator(isAnimating: true)
                    .padding()
                    .background(Color(.systemGray4))
                    .cornerRadius(5)
            }

        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(modelData: SignUpViewModel(coordinator: SessionManagerObject()))
    }
}
