//
//  SignUpView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var modelData: SignUpViewModel
    
    var body: some View {
        NavigationView {
            VStack {

                VStack(spacing: 15) {
                    LegitGrailsLogo()
                    Text("Welcome!")
                        .font(.largeTitle)
                        .bold()
                    Text("Sign up to start authentication")
                        .foregroundColor(.gray)
                }
     
                VStack {
                    LoginTextInput(placeholder: "Username", input: $modelData.username)
                    LoginTextInput(placeholder: "Email", input: $modelData.email)
                    LoginTextInput(placeholder: "Password", input: $modelData.password)
                    
                    HStack(spacing: 0) {
                        ToggleCheckbox(toggled: $modelData.userAgreement)
                            .padding(.horizontal)
                        
                        Text("I agree with our")
                            .foregroundColor(.gray)
                        Button {
                            
                        } label: {
                            Text(" terms and conditions")

                        }
                        
                        Spacer()
                        
                    }
                    .padding(.top)
                    
                }
                .padding(.vertical, 60)
                

                ConfirmButton(text: "Create account") {
                    
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
                .padding(.top, 40)
                
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(modelData: SignUpViewModel(coordinator: SessionManagerObject()))
    }
}
