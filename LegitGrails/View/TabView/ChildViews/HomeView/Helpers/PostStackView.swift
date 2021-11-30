//
//  PostStackView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct PostStackView: View {
    
    @StateObject var modelData: PostStackViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("All activity")
                .font(.title2)
                .padding()
            
            ForEach(0...3, id: \.self) { _ in
                PostView(post: modelData.post)
            }
            .padding(.horizontal)
        }
    }
}

struct PostStackView_Previews: PreviewProvider {
    static var previews: some View {
        PostStackView(modelData: PostStackViewModel())
    }
}
