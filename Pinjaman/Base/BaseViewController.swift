//
//  BaseViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView()
        return headView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "#ECEEF0")
    }

}
