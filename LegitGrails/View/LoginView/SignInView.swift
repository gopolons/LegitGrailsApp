//
//  SignInView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var modelData = SignInViewModel()
    
    @Environment(\.presentationMode) var presentation
    
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

                    LoginTextInput(placeholder: "Email", input: $modelData.email)
                    ZStack {
                        LoginTextInput(placeholder: "Password", input: $modelData.password)
                        
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
                .padding(.bottom, 115)

                NavigationLink(isActive: $modelData.navigateToForgotPassword) {
                    PasswordResetView()
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
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
