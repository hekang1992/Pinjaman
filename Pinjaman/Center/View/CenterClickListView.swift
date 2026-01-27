//
//  CenterClickListView.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CenterClickListView: BaseView {
    
    var tapBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
//    lazy var logoImageView: UIImageView = {
//        let logoImageView = UIImageView()
//        logoImageView.layer.cornerRadius = 5
//        logoImageView.layer.masksToBounds = true
//        logoImageView.backgroundColor = .red
//        return logoImageView
//    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "cpo_lis_l_r_image")
        return rightImageView
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
//        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(rightImageView)
        bgView.addSubview(tapBtn)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 359.pix(), height: 49.pix()))
        }
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20.pix())
            make.width.height.height.equalTo(24)
        }
//        logoImageView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().offset(20.pix())
//            make.width.height.equalTo(30)
//        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20.pix())
            make.height.equalTo(20.pix())
        }
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
