//
//  HomeView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var modelData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                HomeLinks(modelData: modelData)
                
                PostStackView(modelData: modelData.postStackVM)
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("LegitGrails")
                        .resizable()
                        .frame(width: 50, height: 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(modelData: HomeViewModel(tabCoordinator: AppTabViewModel(coordinator: SessionManagerObject()), coordinator: SessionManagerObject()))
    }
}
