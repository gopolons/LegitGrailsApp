//
//  PostLoadingView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 02/12/2021.
//

import SwiftUI

struct PostLoadingView: View {
    
    @ObservedObject var modelData: FullScreenGenericPostViewModel
    
    var body: some View {
        ZStack {
            if modelData.connectionError {
                VStack(spacing: 50) {
                    Text("No connection!")
                        .foregroundColor(.gray)
                        .bold()
                    
                    
                    HStack {
                        Spacer()
                        Button {
                            modelData.onAppear()
                        } label: {
                            HStack {
                                Text("Retry")
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            }
                        }
                        Spacer()
                    }

                }

            } else {
                Text("")
                    .onAppear {
                        modelData.onAppear()
                    }
            }
        }
    }
}

struct PostLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        PostLoadingView(modelData: FullScreenGenericPostViewModel(coordinator: SessionManagerObject()))
    }
}
