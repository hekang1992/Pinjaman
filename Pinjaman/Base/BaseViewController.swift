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
    
    let languageCode = LanguageManager.shared.currentType
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView()
        return headView
    }()
    
    func changeRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#ECEEF0")
    }
    
}
