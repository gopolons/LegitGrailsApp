//
//  AuthenticationAPIService.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol AuthenticationAPIServiceProtocol {
    
    func checkUserName(_ username: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void)
    
    func signUp(username: String, email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void)
    
    func signIn(email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void)
    
    func restorePasswordWithEmail(_ email: String, completion: @escaping (NetResponse?, NetError?) -> Void)
}

final class AuthenticationApiService: AuthenticationAPIServiceProtocol {
//    private var parser: DataParsingProtocol
    
    func checkUserName(_ username: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void) {
        
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(SessionData(authenticationToken: "success"), nil)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(SessionData(authenticationToken: "success"), nil)
        }
    }
    
    func restorePasswordWithEmail(_ email: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(NetResponse.success, nil)
        }
    }
}
