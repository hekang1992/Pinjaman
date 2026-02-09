//
//  SecurityVault.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import Foundation
import Security
import UIKit
import AppTrackingTransparency
import AdSupport

class SecurityVault {
    static let shared = SecurityVault()
    private let service = "com.app.audit.storage"
    private let idfvKey = "unique_aroundet_id"
    
    func getIDFA() -> String {
        let manager = ASIdentifierManager.shared()
        
        let idfa = manager.advertisingIdentifier.uuidString
        
        if idfa == "00000000-0000-0000-0000-000000000000" {
            return ""
        }
        return idfa
    }

    func getIDFV() -> String {
        if let data = load(key: idfvKey), let id = String(data: data, encoding: .utf8) {
            return id
        }
        let newID = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        save(key: idfvKey, data: newID.data(using: .utf8)!)
        return newID
    }

    private func save(key: String, data: Data) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as [CFString : Any]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func load(key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [CFString : Any]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        return status == errSecSuccess ? (dataTypeRef as? Data) : nil
    }
}
