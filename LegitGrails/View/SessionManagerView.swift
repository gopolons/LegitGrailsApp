//
//  SessionManagerView.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct SessionManagerView: View {
    
    @ObservedObject var coordinator: SessionManagerObject
    
    var body: some View {
        if coordinator.authToken == "" {
            SignUpView(modelData: coordinator.signUpVM)
        } else {
            HomeView()
        }
    }
}

struct SessionManagerView_Previews: PreviewProvider {
    static var previews: some View {
        SessionManagerView(coordinator: SessionManagerObject())
    }
}
