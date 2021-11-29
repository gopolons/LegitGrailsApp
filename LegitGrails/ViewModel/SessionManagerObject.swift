//
//  SessionManagerObject.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

final class SessionManagerObject: ObservableObject {
    @Published var authToken = ""
    @Published var screenHeight: Double
    private var _signUpVM: SignUpViewModel!
    var signUpVM: SignUpViewModel {
        return _signUpVM
    }
    
    
    init() {
        self.screenHeight = UIScreen.screenHeight
        self._signUpVM = SignUpViewModel(coordinator: self)
    }
}
