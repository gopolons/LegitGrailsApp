//
//  InputTextField.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct LoginTextInput: View {
    
    var placeholder: String
    
    @Binding var input: String

    var body: some View {
        VStack {
            TextField(placeholder, text: $input)
                .padding(.vertical)
                
            Divider()
        }
        .padding(.horizontal)
    }
}

struct LoginTextInput_Previews: PreviewProvider {
    
    @State static var input = ""
    
    static var previews: some View {
        LoginTextInput(placeholder: "Email", input: $input)
    }
}
