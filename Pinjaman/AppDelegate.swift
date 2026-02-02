//
//  AppDelegate.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
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
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVc(_:)), name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    @objc func changeRootVc(_ noti: Notification) {
        if UserManager.shared.isLogin {
            let userInfo = noti.userInfo as? [String: Int]
            let tabBar = BaseTabBarController()
            tabBar.selectedIndex = userInfo?["tab"] ?? 0
            window?.rootViewController = tabBar
        }else {
            window?.rootViewController = BaseNavigationController(rootViewController: LoginViewController())
        }
    }
    
}
