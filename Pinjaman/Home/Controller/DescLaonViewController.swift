//
//  DescLaonViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/2/3.
//

import UIKit
import SnapKit

class DescLaonViewController: BaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "de_he_on_image")
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "de_he_to_image")
        twoImageView.contentMode = .scaleAspectFit
        return twoImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(headView)
        headView.nameLabel.text = LStr("Quick Loan Strategy")
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 148.pix()))
        }
        
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 379.pix()))
            make.bottom.equalToSuperview().offset(-30.pix())
        }
        
    }


}
