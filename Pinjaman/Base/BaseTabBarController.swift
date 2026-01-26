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
        setupTabBars()
        
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
    }
    
    private func setupTabBars() {
        let homeVC = createNavController(viewController: HomeViewController(), imageName: "home")
        let orderVC = createNavController(viewController: OrderViewController(), imageName: "order")
        let centerVC = createNavController(viewController: CenterViewController(), imageName: "center")
        
        viewControllers = [homeVC, orderVC, centerVC]
    }
    
    private func createNavController(viewController: UIViewController, imageName: String) -> UINavigationController {
        let nav = BaseNavigationController(rootViewController: viewController)
        
        viewController.view.backgroundColor = .white
        
        nav.tabBarItem = UITabBarItem(title: nil,
                                      image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                                      selectedImage: UIImage(named: "\(imageName)_sel")?.withRenderingMode(.alwaysOriginal))
        
        return nav
    }
}
