//
//  CommentInputField.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct CommentInputField: View {
    
    @State var input = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                TextField("Write a comment", text: $input)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(colorScheme == .light ? Color.white : Color.black)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1)
                    )
                
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color(.systemGray3))
            }
            .padding()
            .background(Color(.systemGray6))

        }
    }
}

struct CommentInputField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CommentInputField()
                .preferredColorScheme(.light)
            CommentInputField()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
