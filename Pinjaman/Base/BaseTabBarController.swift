//
//  BaseTabBarController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit

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
        
        viewController.view.backgroundColor = .white
        
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
        return true
    }
    
}
