//
//  AppTabViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

final class AppTabViewModel: ObservableObject {
    private var coordinator: SessionManagerObject
    @Published var selection = 0
    
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
    }
}
