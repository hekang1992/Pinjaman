//
//  ToastManager.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import Toast_Swift

class ToastManager {
    
    static func showLocal(_ key: String) {
        let translatedStr = LStr(key)
        showOnWindow(translatedStr)
    }
    
    private static func showOnWindow(_ text: String) {
        let window = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first { $0.isKeyWindow }
        
        guard let targetWindow = window else { return }
        
        DispatchQueue.main.async {
            targetWindow.makeToast(text, duration: 3.0, position: .center)
        }
    }
}
