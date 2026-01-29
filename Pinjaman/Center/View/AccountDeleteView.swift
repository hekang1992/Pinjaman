//
//  AccountDeleteView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AccountDeleteView: BaseView {
    
    var oneBlock: (() -> Void)?
    var twoBlock: (() -> Void)?
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "acc_del_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setImage(UIImage(named: "login_nor_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "login_sel_image"), for: .selected)
        return sureBtn
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .left
        descLabel.text = "I agree with the above content."
        descLabel.textColor = UIColor.init(hexString: "#333333")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(descLabel)
        bgImageView.addSubview(sureBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 347.pix(), height: 511.pix()))
        }
        twoBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 272.pix(), height: 38.pix()))
        }
        oneBtn.snp.makeConstraints { make in
            make.bottom.equalTo(twoBtn.snp.top)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 272.pix(), height: 50.pix()))
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(14.pix())
            make.bottom.equalTo(oneBtn.snp.top).offset(-12.pix())
            make.height.equalTo(17.pix())
        }
        sureBtn.snp.makeConstraints { make in
            make.centerY.equalTo(descLabel)
            make.width.height.equalTo(15.pix())
            make.right.equalTo(descLabel.snp.left).offset(-7.pix())
        }
        
        oneBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.oneBlock?()
            })
            .disposed(by: disposeBag)
        
        twoBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.twoBlock?()
            })
            .disposed(by: disposeBag)
        
        sureBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.sureBtn.isSelected.toggle()
            })
            .disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountDeleteView {
    
}
