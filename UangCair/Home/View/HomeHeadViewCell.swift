//
//  HomeHeadViewCell.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class HomeHeadViewCell: UITableViewCell {
    
    var model: misceeerModel? {
        didSet {
            configureCell()
        }
    }
    
    var tapCellBlock: ((misceeerModel) -> Void)?
    
    private lazy var oneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "two_hea_li_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var twoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "two_ac_li_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var limitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 47, weight: .bold)
        return label
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(hexString: "#7F8594")
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(hexString: "#7F8594")
        return label
    }()
    
    private lazy var applyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(hexString: "#4CA466")
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
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
        contentView.addSubview(oneImageView)
        contentView.addSubview(twoImageView)
        contentView.addSubview(tapBtn)
        
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(limitLabel)
        oneImageView.addSubview(numLabel)
        oneImageView.addSubview(leftLabel)
        oneImageView.addSubview(rightLabel)
        
        twoImageView.addSubview(applyLabel)
    }
    
    private func setupConstraints() {
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 347.pix(), height: 267.pix()))
        }
        
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(-40.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 89.pix()))
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(17)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalTo(nameLabel.snp.leading).offset(-5)
            make.width.height.equalTo(28)
        }
        
        limitLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(14)
            make.height.equalTo(19)
        }
        
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(limitLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(13.pix())
            make.leading.equalToSuperview().offset(44.pix())
            make.size.equalTo(CGSize(width: 120, height: 28))
        }
        
        rightLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(13.pix())
            make.trailing.equalToSuperview().offset(-44.pix())
            make.size.equalTo(CGSize(width: 120, height: 28))
        }
        
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 50.pix()))
            make.bottom.equalToSuperview().offset(-11.pix())
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
        leftLabel.text = model.putitive ?? ""
        rightLabel.text = model.morning ?? ""
        applyLabel.text = model.powerability ?? ""
    }
}
