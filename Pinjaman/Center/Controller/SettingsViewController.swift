//
//  SettingsViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit
import SnapKit

class SettingsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.nameLabel.text = LStr("Settings")
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
