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
        ScrollView {
            HomeLinks(modelData: modelData)
                .padding(.top, 10)
            
            PostStackView(modelData: modelData.postStackVM)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(modelData: HomeViewModel(tabCoordinator: AppTabViewModel(coordinator: SessionManagerObject()), coordinator: SessionManagerObject()))
    }
}
