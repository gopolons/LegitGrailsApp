//
//  AuthenticationAPIService.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol AuthenticationAPIServiceProtocol {
    func checkEmail(_ email: String, completion: @escaping (AuthenticationParameterError?) -> Void)
    
    func checkUserName(_ username: String, completion: @escaping (AuthenticationParameterError?) -> Void)
    
    func signUp(username: String, email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void)
    
    func signIn(email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void)
    
    func restorePasswordWithEmail(_ email: String, completion: @escaping (NetResponse?, AuthenticationParameterError?, NetError?) -> Void)
}
