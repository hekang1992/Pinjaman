//
//  NetworkMonitor.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import Alamofire
import Foundation

enum NetworkType: String {
    case unknown = "UNKNOWN"
    case none = "NONE"
    case wifi = "WIFI"
    case cellular = "5G"
}

final class NetworkSaveManager {

    private static let key = "net_net_work"

    static func saveNetworkType(_ type: NetworkType) {
        UserDefaults.standard.set(type.rawValue, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func currentNetworkType() -> NetworkType {
        guard let value = UserDefaults.standard.string(forKey: key),
              let type = NetworkType(rawValue: value) else {
            return .unknown
        }
        return type
    }

    static func hasNetwork() -> Bool {
        let type = currentNetworkType()
        return type == .wifi || type == .cellular
    }
}

enum NetworkStatus {
    case unknown
    case notReachable
    case reachableViaWiFi
    case reachableViaCellular
}

final class NetworkMonitor {

    static let shared = NetworkMonitor()

    private let reachabilityManager = NetworkReachabilityManager()
    private var statusBlock: ((NetworkStatus) -> Void)?

    private init() {}

    func startListening(status: @escaping (NetworkStatus) -> Void) {
        self.statusBlock = status

        reachabilityManager?.startListening(onUpdatePerforming: { status in
            let networkStatus: NetworkStatus

            switch status {
            case .unknown:
                networkStatus = .unknown
                NetworkSaveManager.saveNetworkType(.unknown)

            case .notReachable:
                networkStatus = .notReachable
                NetworkSaveManager.saveNetworkType(.none)

            case .reachable(let connectionType):
                switch connectionType {
                case .ethernetOrWiFi:
                    networkStatus = .reachableViaWiFi
                    NetworkSaveManager.saveNetworkType(.wifi)

                case .cellular:
                    networkStatus = .reachableViaCellular
                    NetworkSaveManager.saveNetworkType(.cellular)
                }
            }

            self.statusBlock?(networkStatus)
        })
    }

    func stopListening() {
        reachabilityManager?.stopListening()
//        statusBlock = nil
    }
}
