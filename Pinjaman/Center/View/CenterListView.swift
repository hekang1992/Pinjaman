//
//  CenterListView.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CenterListView: BaseView {
    
    var tapBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.06
        view.layer.shadowRadius = 2.5
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var oneBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor(hexString: "#333333"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .black)
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        
        let spacing: CGFloat = 5
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        
        btn.semanticContentAttribute = .forceLeftToRight
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBinding()
    }
    
    private func setupUI() {
        addSubview(bgView)
        bgView.addSubview(oneBtn)
        
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 168.pix(), height: 60.pix()))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBinding() {
        oneBtn.rx.tap
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
