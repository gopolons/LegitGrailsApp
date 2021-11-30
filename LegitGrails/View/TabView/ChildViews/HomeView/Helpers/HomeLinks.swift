//
//  HomeLinks.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import SwiftUI

struct HomeLinks: View {
    
    @ObservedObject var modelData: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                LinkButton(image: "AuthenticateLink", text: "Authenticate now") {
                    modelData.linkPress(navigateTo: 2)
                }
                
                LinkButton(image: "CommunitiesLink", text: "Communities") {
                    
                }
            }
            
            HStack(spacing: 20) {
                
                LinkButton(image: "GuidesLink", text: "Guides") {
                    
                }
                
                LinkButton(image: "ChecksLink", text: "Recent checks") {
                    
                }

            }
            
            HStack(spacing: 20) {
                
                LinkButton(image: "PracticeLink", text: "Practice skills") {
                    
                }
                
                LinkButton(image: "HowItWorksLink", text: "How it works") {
                    
                }
            }
        }
    }
}

struct HomeLinks_Previews: PreviewProvider {
    static var previews: some View {
        HomeLinks(modelData: HomeViewModel(tabCoordinator: AppTabViewModel(coordinator: SessionManagerObject())))
    }
}
