//
//  DeviceProfile.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit

struct DeviceProfile {
    static func assembleAuditParams() -> [String: String] {
        let idfv = SecurityVault.shared.getIDFV()
        
        var dict: [String: String] = [
            "nauindustryation": "ios",
            "caliditor": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0",
            "dynathe": UIDevice.current.modelName,
            "aroundet": idfv,
            "fund": UIDevice.current.systemVersion,
            "rachably": "pinjaman-lar",
            "anaorderade": "sessionId",
            "dermary": idfv,
            "horm": Locale.current.identifier,
            "iterable": DeviceInspector.isProxyActive() ? "1" : "0",
            "soldierast": DeviceInspector.isVPNActive() ? "1" : "0",
            "agor": Locale.preferredLanguages.first ?? "en-US"
        ]
        return dict
    }
    
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
}

extension String {
    func appendingQueryParameters(_ parameters: [String: String]) -> String {
        guard var components = URLComponents(string: self) else { return self }
        var queryItems = components.queryItems ?? []
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        return components.url?.absoluteString ?? self
    }
}
