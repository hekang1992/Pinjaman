//
//  AppDelegate.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        rootNotiVc()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = StartViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {

    private func rootNotiVc() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVc), name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    @objc func changeRootVc() {
        window?.rootViewController = BaseTabBarController()
    }
    
}
