//
//  HomeViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private var coordinator: SessionManagerObject
    private var tabCoordinator: AppTabViewModel
    private var _postStackVM: PostStackViewModel!
    var postStackVM: PostStackViewModel {
        return _postStackVM
    }
    
    func linkPress(navigateTo: Int) {
        self.tabCoordinator.selection = navigateTo
    }
    
    init(tabCoordinator: AppTabViewModel, coordinator: SessionManagerObject) {
        self.tabCoordinator = tabCoordinator
        self.coordinator = coordinator
        self._postStackVM = PostStackViewModel(coordinator: coordinator)

    }
}
