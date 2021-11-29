//
//  ConfirmButton.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct ConfirmButton: View {
    
    var text: String
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
             
            Text(text)
                .foregroundColor(.white)
                .frame(width: (UIScreen.screenWidth - 50), height: 50)
                .background(Color("AccentColor"))
                .cornerRadius(15)
  
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ConfirmButton_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmButton(text: "Log in", action: {})
    }
}
