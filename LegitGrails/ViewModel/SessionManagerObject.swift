//
//  SessionManagerObject.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SessionManagerObject: ObservableObject {
    @Published var authToken = "fds"
    @Published var screenHeight: Double
    private var _signUpVM: SignUpViewModel!
    var signUpVM: SignUpViewModel {
        return _signUpVM
    }
    private var _appTabVM: AppTabViewModel!
    var appTabVM: AppTabViewModel {
        return _appTabVM
    }
    
    
    init() {
        self.screenHeight = UIScreen.screenHeight
        self._signUpVM = SignUpViewModel(coordinator: self)
        self._appTabVM = AppTabViewModel(coordinator: self)
    }
}
