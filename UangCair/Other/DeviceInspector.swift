//
//  DeviceInspector.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//


import Foundation
import CFNetwork

struct DeviceInspector {
    
    static func getAuditParams() -> [String: String] {
        return [
            "iterable": isProxyActive() ? "1" : "0",
            "soldierast": isVPNActive() ? "1" : "0",
            "agor": Locale.preferredLanguages.first ?? "en-US"
        ]
    }
    
     static func isProxyActive() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
              let scopes = proxySettings["__SCOPED__"] as? [AnyHashable: Any] else {
            return false
        }
        
        for key in scopes.keys {
            if let keyString = key as? String, 
               (keyString.contains("http") || keyString.contains("https")) {
                return true
            }
        }
        return false
    }
    
     static func isVPNActive() -> Bool {
        let vpnProtocolsKeys = ["tap", "tun", "ppp", "ipsec", "utun"]
        var address: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&address) == 0 else { return false }
        defer { freeifaddrs(address) }
        
        var ptr = address
        while ptr != nil {
            if let name = ptr?.pointee.ifa_name {
                let interfaceName = String(cString: name)
                for protocolKey in vpnProtocolsKeys {
                    if interfaceName.lowercased().contains(protocolKey) {
                        return true
                    }
                }
            }
            ptr = ptr?.pointee.ifa_next
        }
        return false
    }
}
