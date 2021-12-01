//
//  FullScreenPostImageView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct FullScreenPostImageView: View {
    
    @StateObject var modelData: FullScreenPostImageViewModel
    
    @State var isSearching = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("")
                Spacer()
                HStack {
                    Spacer()
                }
            }
            .background(Color.black)
            .ignoresSafeArea(.all)
            
            VStack {
                if !modelData.images.isEmpty {
                    HStack {
                        TabView(selection: $modelData.openedImage) {
                            ForEach(modelData.images, id: \.self) { img in
                                ZoomableImageView(image: UIImage(named: img)!)
                                    .tag(img)
                                    .ignoresSafeArea(.all)
                                    .onTapGesture {
                                        modelData.hideUI()
                                    }
                            }
                        }
                        .onAppear(perform: {
                            UIScrollView.appearance().bounces = false
                        })
                        .onDisappear(perform: {
                            UIScrollView.appearance().bounces = true
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .modifier(DraggableModifier(direction: .vertical, action: {
                            modelData.dismissView()
                        }, draggedOffset: $modelData.imageOffset))
                    }
                }
            }
            .zIndex(1)

            if modelData.uiShown {
                VStack {
                    ZStack {
                        
                        HStack {
                            Button {
                                modelData.dismissView()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .frame(width: 12, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("\(modelData.images.firstIndex(of: modelData.openedImage)! + 1) of \(modelData.images.count)")
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                        

                    }
                    .padding(.top, UIScreen.screenHeight <= 736 ? 30 : 60)
                    .frame(width: UIScreen.screenWidth)
                    .padding(.bottom, 10)
                    .background(Color.black)

                    Spacer()
                }
                .ignoresSafeArea(.all)
                .zIndex(2)

            }
            
        }
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
