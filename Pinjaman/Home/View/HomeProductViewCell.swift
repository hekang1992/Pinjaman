//
//  HomeProductViewCell.swift
//  Pinjaman
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
            guard let model = model else { return }
            nameLabel.text = model.wideious ?? ""
            logoImageView.kf.setImage(with: URL(string: model.spicly ?? ""))
            
            limitLabel.text = model.nuchine ?? ""
            numLabel.text = model.megfinishern ?? ""
            
            applyLabel.text = model.powerability ?? ""
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var tapCellBlock: ((misceeerModel) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var limitLabel: UILabel = {
        let limitLabel = UILabel()
        limitLabel.textAlignment = .left
        limitLabel.textColor = UIColor.init(hexString: "#666666")
        limitLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return limitLabel
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textAlignment = .right
        numLabel.textColor = UIColor.init(hexString: "#333333")
        numLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return numLabel
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.backgroundColor = UIColor.init(hexString: "#4CA466")
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.layer.cornerRadius = 16
        applyLabel.layer.masksToBounds = true
        applyLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return applyLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(limitLabel)
        bgView.addSubview(numLabel)
        bgView.addSubview(applyLabel)
        bgView.addSubview(tapBtn)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 87.pix()))
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.height.equalTo(17)
        }
        limitLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-15.pix())
            make.height.equalTo(17)
        }
        applyLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(logoImageView)
            make.height.equalTo(32)
            make.width.greaterThanOrEqualTo(110.pix())
        }
        numLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(limitLabel)
            make.height.equalTo(20.pix())
        }
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self, let model = model else { return }
                self.tapCellBlock?(model)
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
