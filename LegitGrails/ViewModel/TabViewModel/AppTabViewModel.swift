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
    private var _homeVM: HomeViewModel!
    var homeVM: HomeViewModel {
        return _homeVM
    }
    
    
    init(coordinator: SessionManagerObject) {
        self.coordinator = coordinator
        self._homeVM = HomeViewModel(tabCoordinator: self, coordinator: coordinator)

    }
}
