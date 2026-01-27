//
//  BaseViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView()
        return headView
    }()
    
    let languageCode = LanguageManager.shared.currentType

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(hexString: "#ECEEF0")
    }

}
