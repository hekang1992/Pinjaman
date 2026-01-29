//
//  LanguageType.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import Foundation

enum LanguageType: String {
    case indonesian = "3100"
    case english    = "3102"
}

class LanguageManager {
    
    static let shared = LanguageManager()
    
    private(set) var currentBundle: Bundle = .main
    
    private(set) var currentType: LanguageType = .english
    
    private init() {}
    
    func configure(with externalID: String?) {
        if externalID == "3100" {
            currentType = .indonesian
        } else {
            currentType = .english
        }
        
        let langCode = (currentType == .indonesian) ? "id" : "en"
        
        if let path = Bundle.main.path(forResource: langCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.currentBundle = bundle
        } else {
            self.currentBundle = .main
        }
    }
    
    func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, bundle: currentBundle, comment: "")
    }
}

func LStr(_ key: String) -> String {
    return LanguageManager.shared.localizedString(key)
}
