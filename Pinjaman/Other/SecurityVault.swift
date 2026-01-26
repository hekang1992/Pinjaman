//
//  SecurityVault.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import Foundation
import Security
import UIKit

class SecurityVault {
    static let shared = SecurityVault()
    private let service = "com.app.audit.storage"
    private let idfvKey = "unique_aroundet_id"

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
