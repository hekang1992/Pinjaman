//
//  DeepLinkTarget.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit

let scheme_url = "exactlyate://mustad.canceree.hope/"

enum DeepLinkTarget {
    
    case main
    case setting
    case login
    case order
    case productDetail(id: String)

    private static let scheme = "exactlyate"
    private static let host = "mustad.canceree.hope"

    init?(url: URL) {
        guard url.scheme == Self.scheme, url.host == Self.host else { return nil }
        
        let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        let params = queryItems?.reduce(into: [String: String]()) { $0[$1.name] = $1.value } ?? [:]

        switch path {
        case "fellhisine":
            self = .main
            
        case "tend":
            self = .setting
            
        case "jusensey":
            self = .login
            
        case "factorain":
            self = .order
            
        case "dentaccept":
            let productID = params["ideaical"] ?? ""
            self = .productDetail(id: productID)
            
        default:
            return nil
        }
    }
}

final class DeepLinkNavigator {
    
    static func navigate(to link: String, from sender: UIViewController) {
        guard let url = URL(string: link),
              let target = DeepLinkTarget(url: url) else {
            return
        }
        
        guard let nav = sender.navigationController else {
            return
        }
        
        switch target {
        case .setting:
            let vc = SettingsViewController()
            nav.pushViewController(vc, animated: true)
            
        case .productDetail(let productID):
//            let vc = ProductViewController()
//            vc.productID = productID
//            nav.pushViewController(vc, animated: true)
            break
            
        case .main, .login, .order:
            
            break
        }
    }
}
