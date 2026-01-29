//
//  OrderEmptyView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OrderEmptyView: BaseView {
    
    var clickBlock: (() -> Void)?
    
    private lazy var emptyBtn: UIButton = {
        let button = UIButton(type: .custom)
        let imageName = languageCode == .indonesian ? "pty_id_image" : "pty_en_image"
        button.setImage(UIImage(named: imageName), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.imageView?.contentMode = .scaleAspectFit
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
        addSubview(emptyBtn)
    }
    
    private func setupConstraints() {
        emptyBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 193.pix(), height: 255.pix()))
        }
    }
    
    private func setupBindings() {
        emptyBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.clickBlock?()
            })
            .disposed(by: disposeBag)
    }
}
