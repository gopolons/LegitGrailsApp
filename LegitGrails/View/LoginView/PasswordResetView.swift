//
//  PasswordResetView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct PasswordResetView: View {
    
    @State var modelData: PasswordResetViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                LoginTextInput(placeholder: "Email", input: $modelData.email)
                
                ConfirmButton(text: "Reset password") {
                    
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView(modelData: PasswordResetViewModel(coordinator: SessionManagerObject()))
    }
}
