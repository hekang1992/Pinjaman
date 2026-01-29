//
//  BaseTabBarController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import CoreLocation

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupTabBars()
        setupAppearance()
    }
    
    private func setupTabBars() {
        let homeVC = createNavController(
            viewController: HomeViewController(),
            imageName: "home"
        )
        let orderVC = createNavController(
            viewController: OrderViewController(),
            imageName: "order"
        )
        let centerVC = createNavController(
            viewController: CenterViewController(),
            imageName: "center"
        )
        
        viewControllers = [homeVC, orderVC, centerVC]
    }
    
    private func setupAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        self.tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    private func createNavController(viewController: UIViewController, imageName: String) -> UINavigationController {
        let nav = BaseNavigationController(rootViewController: viewController)
        
        viewController.view.backgroundColor = UIColor.init(hexString: "#ECEEF0")
        
        nav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: imageName)?
                .withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(
                named: "\(imageName)_sel"
            )?
                .withRenderingMode(.alwaysOriginal)
        )
        
        return nav
    }
}

extension BaseTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !UserManager.shared.isLogin {
            let loginVc = BaseNavigationController(
                rootViewController: LoginViewController()
            )
            loginVc.modalPresentationStyle = .fullScreen
            self.present(loginVc, animated: true)
            return false
        }
        
//        let status = CLLocationManager().authorizationStatus
//        if LanguageManager.shared.currentType == .indonesian {
//            if status == .restricted || status == .denied {
//                self.showSettingsAlert()
//                return false
//            }
//        }
        
        return true
    }
    
    private func showSettingsAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: LStr("Location Services Disabled"),
                message: LStr("Please enable location services in Settings to allow the app to determine your location."),
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: LStr("Cancel"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let settingsAction = UIAlertAction(title: LStr("Settings"), style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            alert.addAction(settingsAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
