//
//  AppMacInfo.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import Foundation
import SystemConfiguration.CaptiveNetwork
import DeviceKit
import NetworkExtension

extension UIDevice {
    static var safeBatteryLevel: String {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let level = UIDevice.current.batteryLevel
        return level < 0 ? "0" : String(Int(level * 100))
    }
}

final class RockonInfo {
    
    static func fetch() -> [String: String] {
        let totalDisk = totalDiskSpace()
        let freeDisk = freeDiskSpace()
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        let freeMemory = freeMemorySize()
        
        return [
            "backage": freeDisk,
            "emeature": totalDisk,
            "fory": String(totalMemory),
            "problemious": freeMemory
        ]
    }
    
    private static func totalDiskSpace() -> String {
        let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return String(attrs?[.systemSize] as? UInt64 ?? 0)
    }
    
    private static func freeDiskSpace() -> String {
        let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
        return String(attrs?[.systemFreeSize] as? UInt64 ?? 0)
    }
    
    private static func freeMemorySize() -> String {
        var pageSize: vm_size_t = 0
        var stats = vm_statistics64()
        var count = UInt32(MemoryLayout.size(ofValue: stats) / MemoryLayout<UInt32>.size)
        
        let host = mach_host_self()
        
        host_page_size(host, &pageSize)
        
        let result = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(host, HOST_VM_INFO64, $0, &count)
            }
        }
        
        guard result == KERN_SUCCESS else {
            return "0"
        }
        
        let freeMemory = UInt64(stats.free_count) * UInt64(pageSize)
        let inactiveMemory = UInt64(stats.inactive_count) * UInt64(pageSize)
        let availableMemory = freeMemory + inactiveMemory
        
        return "\(availableMemory)"
    }
    
}

final class FactorainInfo {
    
    static func fetch() -> [String: String] {
        return [
            "primivictimacle": UIDevice.safeBatteryLevel,
            "quindecim": UIDevice.current.batteryState == .charging ? "1" : "0"
        ]
    }
}

final class AndroshipInfo {
    
    static func fetch() -> [String: String] {
        let screen = UIScreen.main.bounds
        
        return [
            "viscistic": UIDevice.current.systemVersion,
            "altpublicfold": "iPhone",
            "sarcoorium": Device.identifier,
            "cidia": Device.current.description,
            "groundible": String(Int(screen.height)),
            "groundical": String(Int(screen.width)),
            "pitireport": String(Device.current.diagonal)
        ]
    }
    
}

final class ExperiencethInfo {
    
    static func fetch(with bssid: String) -> [String: String] {
        return [
            "matrture": TimeZone.current.abbreviation() ?? "",
            "iterable": isUsingProxy() ? "1" : "0",
            "soldierast": isVPNConnected() ? "1" : "0",
            "marriageency": "-",
            "hol": SecurityVault.shared.getIDFV(),
            "mitar": Locale.preferredLanguages.first ?? "en_US",
            "facious": NetworkSaveManager.currentNetworkType().rawValue,
            "nesary": Device.current.isPhone ? "1" : "0",
            "psychrature": getLocalIPAddress() ?? "",
            "gastroarian": bssid,
            "edgester": SecurityVault.shared.getIDFA()
        ]
    }
    
    private static func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        let keys = nsDict["__SCOPED__"] as? NSDictionary
        
        for key: String in keys?.allKeys as? [String] ?? [] {
            if key.contains("tap") || key.contains("tun") ||
                key.contains("ppp") || key.contains("ipsec") ||
                key.contains("utun") {
                return true
            }
        }
        return false
    }
    
    private static func isUsingProxy() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
            return false
        }
        
        if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
            return true
        }
        
        if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
            return true
        }
        
        if let proxyEnable = proxySettings["HTTPEnable"] as? Int, proxyEnable == 1 {
            return true
        }
        
        return false
    }
    
    private static func getLocalIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name = String(cString: (interface?.ifa_name)!)
                    
                    if name == "en0" || name == "en2" || name == "en3" || name == "en4" || name.hasPrefix("en") {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr,
                                    socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                                    &hostname,
                                    socklen_t(hostname.count),
                                    nil,
                                    socklen_t(0),
                                    NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
}

final class WifiInfo {
    
    static func fetch(completion: @escaping ([String: String]) -> Void) {
        var wifiInfo: [String: String] = [:]
        NEHotspotNetwork.fetchCurrent { hotspotNetwork in
            guard let network = hotspotNetwork else {
                completion(wifiInfo)
                return
            }
            wifiInfo["tingacity"] = network.bssid
            wifiInfo["flysive"] = network.ssid
            wifiInfo["gastroarian"] = wifiInfo["tingacity"]
            wifiInfo["tomoeconomyet"] = wifiInfo["flysive"]
            completion(wifiInfo)
        }
    }
}

final class DeviceCollector {
    
    static func collect(completion: @escaping ([String: Any]) -> Void) {
        
        WifiInfo.fetch { wifiList in
            
            let result: [String: Any] = [
                "rockon": RockonInfo.fetch(),
                "factorain": FactorainInfo.fetch(),
                "androship": AndroshipInfo.fetch(),
                "lictspaceety": [
                    "patientist": "100",
                    "kidage": "0",
                    "floratory": "0",
                    "federal": "0",
                    "pangwise": "0"
                ],
                "experienceth": ExperiencethInfo.fetch(with: wifiList["gastroarian"] ?? ""),
                "condition": [
                    "naissot": [wifiList]
                ]
            ]
            
            completion(result)
        }
    }
}
