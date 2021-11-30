//
//  AppTabView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject var modelData: AppTabViewModel
    
    var body: some View {
        TabView(selection: $modelData.selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            AuthenticateView()
                .tabItem {
                    Image(systemName: "greetingcard.fill")
                    Text("Authenticate")
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(modelData: AppTabViewModel(coordinator: SessionManagerObject()))
    }
}
