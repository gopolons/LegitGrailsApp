//
//  HomeViewModel.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private var tabCoordinator: AppTabViewModel
    private var _postStackVM: PostStackViewModel!
    var postStackVM: PostStackViewModel {
        return _postStackVM
    }
    
    func linkPress(navigateTo: Int) {
        self.tabCoordinator.selection = navigateTo
    }
    
    init(tabCoordinator: AppTabViewModel) {
        self._postStackVM = PostStackViewModel()
        self.tabCoordinator = tabCoordinator
    }
}
