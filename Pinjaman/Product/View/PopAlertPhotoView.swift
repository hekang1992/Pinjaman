//
//  PopAlertPhotoView.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopAlertPhotoView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        return sureBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(sureBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 613.pix()))
        }
        cancelBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(30.pix())
        }
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260.pix(), height: 50.pix()))
            make.bottom.equalTo(cancelBtn.snp.top).offset(-20.pix())
        }
        
        sureBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.sureBlock?()
            })
            .disposed(by: disposeBag)
        
        cancelBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
