//
//  FullScreenPostImageView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct FullScreenPostImageView: View {
    
    @StateObject var modelData: FullScreenPostImageViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if !modelData.images.isEmpty {
                    HStack {
                        TabView(selection: $modelData.openedImage) {
                            ForEach(modelData.images, id: \.self) { img in
                                ZoomableImageView(image: UIImage(named: img)!)
                                    .tag(img)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: modelData.hidePagination ? .never : .always))
                        .modifier(DraggableModifier(direction: .vertical, action: {
                            modelData.dismissView()
                        }, draggedOffset: $modelData.imageOffset))
                        .onChange(of: modelData.imageOffset) { x in
                            modelData.onDrag(x)
                        }
                    }
                }
            }
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            

            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        modelData.dismissView()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .padding(.top, 10)
                }
                Spacer()
            }
            
        }
        .background(Color(.black))
        .ignoresSafeArea(.all)
        .onDisappear {
            modelData.onDisappear()
        }
        
    }
}

struct FullScreenImageView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenPostImageView(modelData: FullScreenPostImageViewModel(coordinator: SessionManagerObject()))
    }
}
