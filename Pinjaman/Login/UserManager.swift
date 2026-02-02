//
//  UserManager.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private let phoneKey = "user_phone_key"
    
    private let tokenKey = "user_token_key"
    
    private init() {}
    
    var isLogin: Bool {
        if let token = getToken(), !token.isEmpty {
            return true
        }
        return false
    }
    
    func saveUserInfo(phone: String, token: String) {
        savePhone(phone)
        saveToken(token)
    }
    
    func savePhone(_ phone: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
    }
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func getPhone() -> String? {
        return UserDefaults.standard.string(forKey: phoneKey)
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func clearUserInfo() {
//        UserDefaults.standard.removeObject(forKey: phoneKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
}
