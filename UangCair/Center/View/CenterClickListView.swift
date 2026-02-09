//
//  CenterClickListView.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CenterClickListView: BaseView {
    
    var tapBlock: (() -> Void)?
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16.pix()
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cpo_lis_l_r_image")
        return imageView
    }()
    
    private lazy var tapBtn: UIButton = {
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
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(rightImageView)
        bgView.addSubview(tapBtn)
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 359.pix(), height: 49.pix()))
        }
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20.pix())
            make.width.height.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20.pix())
            make.height.equalTo(20.pix())
        }
        
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        tapBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapBlock?()
            })
            .disposed(by: disposeBag)
    }
}
