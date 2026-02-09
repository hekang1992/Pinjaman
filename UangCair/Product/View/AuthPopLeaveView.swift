//
//  AuthPopLeaveView.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/2/2.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AuthPopLeaveView: BaseView {
    
    private enum Metric {
        static let bgSize = CGSize(width: 347, height: 482)
        static let btnWidth: CGFloat = 272
        static let primaryBtnHeight: CGFloat = 50
        static let secondaryBtnHeight: CGFloat = 38
        static let bottomMargin: CGFloat = 16
    }
    
    let confirmAction = PublishRelay<Void>()
    let cancelAction = PublishRelay<Void>()
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        let imageName = (languageCode == .indonesian) ? "d_l_lo_image" : "e_l_lo_image"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let confirmButton = UIButton(type: .custom)
    private let cancelButton = UIButton(type: .custom)
    
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
        bgImageView.addSubview(confirmButton)
        bgImageView.addSubview(cancelButton)
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(Metric.bgSize.pixSize)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Metric.bottomMargin.pix())
            make.size.equalTo(CGSize(width: Metric.btnWidth.pix(), height: Metric.secondaryBtnHeight.pix()))
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(cancelButton.snp.top)
            make.size.equalTo(CGSize(width: Metric.btnWidth.pix(), height: Metric.primaryBtnHeight.pix()))
        }
    }
    
    private func setupBindings() {
        confirmButton.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .bind(to: confirmAction)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .bind(to: cancelAction)
            .disposed(by: disposeBag)
    }
}

private extension CGSize {
    var pixSize: CGSize {
        return CGSize(width: width.pix(), height: height.pix())
    }
}
