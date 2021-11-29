//
//  ToggleCheckbox.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct ToggleCheckbox: View {
    
    @Binding var toggled: Bool
    
    var body: some View {
        
        Button {
            withAnimation {
                toggled.toggle()
            }

        } label: {
            ZStack {
                
                
                Rectangle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(toggled ? Color("AccentColor") : Color(.systemGray6))
                    .cornerRadius(5)
                if toggled {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }


            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ToggleCheckbox_Previews: PreviewProvider {
    
    @State static var toggled = false
    
    static var previews: some View {
        ToggleCheckbox(toggled: $toggled)
    }
}
