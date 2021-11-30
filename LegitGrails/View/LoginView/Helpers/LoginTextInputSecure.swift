//
//  LoginTextInputSecure.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct LoginTextInputSecure: View {
    
    var placeholder: String
    
    @Binding var error: String
    
    @Binding var input: String
    
    @State var hint = false
    
    var body: some View {
        ZStack {
            VStack {
                SecureField(placeholder, text: $input)
                    .padding(.vertical, UIScreen.screenHeight <= 736.0 ? 10 : 15)
                    .onChange(of: error) { err in
                        if err != "" {
                            withAnimation {
                                hint = true
                            }
                        } else {
                            withAnimation {
                                hint = false
                            }
                        }
                        
                    }
                    
                    
                Divider()
                
                if hint {
                    HStack {
                        Text("Password should be at least 8 characters long and contain one number and one capital letter")
                            .multilineTextAlignment(.leading)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                    
                }
            }
            .padding(.horizontal)
            
            if error != "" {
                Button {
                    withAnimation {
                        hint.toggle()
                        
                    }
                } label: {
                    HStack {
                        Spacer()
                        
                        Text(error)
                            .foregroundColor(.red)
                            .font(.footnote)
                        
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding(.bottom, hint ? 40 : 0)
            }
        }
    }
}

struct LoginTextInputSecure_Previews: PreviewProvider {
    
    @State static var input = ""
    
    @State static var error = "fdsa"
    
    static var previews: some View {
        LoginTextInputSecure(placeholder: "Password", error: $error, input: $input)
    }
}
