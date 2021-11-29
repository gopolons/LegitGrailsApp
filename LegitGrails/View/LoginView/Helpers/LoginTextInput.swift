//
//  InputTextField.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct LoginTextInput: View {
    
    var placeholder: String
    
    @Binding var error: String
    
    @Binding var input: String

    var body: some View {
        ZStack {
            VStack {
                TextField(placeholder, text: $input)
                    .padding(.vertical, UIScreen.screenHeight <= 736.0 ? 10 : 15)
                    
                Divider()
            }
            .padding(.horizontal)
            
            if error != "" {
                HStack {
                    Spacer()
                    
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                    
                    Image(systemName: "xmark.octagon")
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
}

struct LoginTextInput_Previews: PreviewProvider {
    
    @State static var input = ""
    
    @State static var error = ""

    
    static var previews: some View {
        LoginTextInput(placeholder: "Email", error: $error, input: $input)
    }
}
