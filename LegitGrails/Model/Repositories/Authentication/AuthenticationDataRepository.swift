//
//  AuthenticationDataRepository.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 30/11/2021.
//

import Foundation

protocol AuthenticationDataRepositoryProtocol {
    func checkEmail(_ email: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void)
    
    func checkUserName(_ username: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void)
    
    func checkPassword(_ password: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void)
    
    func signUp(username: String, email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void)
    
    func signIn(email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void)
    
    func restorePasswordWithEmail(_ email: String, completion: @escaping (NetResponse?, NetError?) -> Void)
}

final class AuthenticationDataRepository: AuthenticationDataRepositoryProtocol {
    private var apiService: AuthenticationAPIServiceProtocol
    
    func checkEmail(_ email: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void) {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                completion(nil, AuthenticationParameterError.invalid)
                return
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            completion(nil, AuthenticationParameterError.invalid)
            return
        }
        completion(DataVerificationResponse.success, nil)
    }
    
    func checkUserName(_ username: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void) {
        if username.count == 0 {
            completion(nil, AuthenticationParameterError.invalid)
        } else {
            completion(DataVerificationResponse.success, nil)
        }
    }
    
    func checkPassword(_ password: String, completion: @escaping (DataVerificationResponse?, AuthenticationParameterError?) -> Void) {
        let correctPassword = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$")
        
        let capLetter = NSPredicate(format: "SELF MATCHES %@ ", ".*[A-Z]+.*")
        
        let containsNum = NSPredicate(format: "SELF MATCHES %@ ", ".*[0-9]+.*")
        
        if capLetter.evaluate(with: password) {
            completion(DataVerificationResponse.success, nil)
        } else {
            completion(nil, AuthenticationParameterError.invalid)
        }
        
        if containsNum.evaluate(with: password) {
            completion(DataVerificationResponse.success, nil)
        } else {
            completion(nil, AuthenticationParameterError.invalid)
        }
        
        if correctPassword.evaluate(with: password) {
            completion(DataVerificationResponse.success, nil)
        } else {
            completion(nil, AuthenticationParameterError.invalid)
        }
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void) {
        apiService.signUp(username: username, email: email, password: password) { response, err in
            guard err == nil else {
                completion(nil, err!)
                return
            }
            completion(response, nil)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (SessionData?, NetError?) -> Void) {
        apiService.signIn(email: email, password: password) { response, err in
            guard err == nil else {
                completion(nil, err!)
                return
            }
            completion(response, nil)
        }
    }
    
    func restorePasswordWithEmail(_ email: String, completion: @escaping (NetResponse?, NetError?) -> Void) {
        apiService.restorePasswordWithEmail(email) { response, err in
            guard err == nil else {
                completion(nil, err!)
                return
            }
            completion(response, nil)
        }
    }
    
    init(apiService: AuthenticationAPIServiceProtocol = AuthenticationApiService()) {
        self.apiService = apiService
    }
    
}
