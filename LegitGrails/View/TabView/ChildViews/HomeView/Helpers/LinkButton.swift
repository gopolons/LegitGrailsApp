//
//  LinkButton.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct LinkButton: View {
    
    let image: String
    
    let text: String
    
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Button {
                action()
            } label: {
                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 75)
                        .cornerRadius(15)

                    
                    Text(text)
                        .font(.footnote)
                        .bold()
                }
                .contentShape(Rectangle())

            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 150, height: 100)
            .zIndex(10)
        }
    }
}

struct LinkButton_Previews: PreviewProvider {
    static var previews: some View {
        LinkButton(image: "AuthenticateLink", text: "Authenticate now", action: {})
    }
}
