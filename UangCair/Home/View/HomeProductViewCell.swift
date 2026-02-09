//
//  HomeProductViewCell.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class HomeProductViewCell: UITableViewCell {
    
    var model: misceeerModel? {
        didSet {
            configureCell()
        }
    }
    
    var tapCellBlock: ((misceeerModel) -> Void)?
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var limitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#666666")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.backgroundColor = UIColor(hexString: "#4CA466")
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var tapBtn: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(limitLabel)
        bgView.addSubview(numLabel)
        bgView.addSubview(applyButton)
        bgView.addSubview(tapBtn)
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 87.pix()))
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.leading.equalTo(logoImageView.snp.trailing).offset(5)
            make.height.equalTo(17)
        }
        
        limitLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-15.pix())
            make.height.equalTo(17)
        }
        
        applyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(logoImageView)
            make.height.equalTo(32)
            make.width.greaterThanOrEqualTo(110.pix())
        }
        
        numLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(limitLabel)
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
                guard let self = self, let model = self.model else { return }
                self.tapCellBlock?(model)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureCell() {
        guard let model = model else { return }
        
        nameLabel.text = model.wideious ?? ""
        
        if let imageUrlString = model.spicly,
           let imageUrl = URL(string: imageUrlString) {
            logoImageView.kf.setImage(with: imageUrl)
        }
        
        limitLabel.text = model.nuchine ?? ""
        numLabel.text = model.megfinishern ?? ""
        applyButton.setTitle(model.powerability ?? "", for: .normal)
    }
}
