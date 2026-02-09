//
//  PopAlertPhotoView.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopAlertPhotoView: BaseView {
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private lazy var sureBtn: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(sureBtn)
    }
    
    private func setupConstraints() {
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
    }
    
    private func setupBindings() {
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
}
