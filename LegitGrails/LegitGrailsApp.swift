//
//  LegitGrailsApp.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

@main
struct LegitGrailsApp: App {
    
    @StateObject var coordinator = SessionManagerObject()
    
    var body: some Scene {
        WindowGroup {
            SessionManagerView(coordinator: coordinator)
        }
    }
}
