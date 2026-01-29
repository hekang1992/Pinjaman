//
//  HomeHeadViewCell.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class HomeHeadViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    var tapCellBlock: ((misceeerModel) -> Void)?
    
    var model: misceeerModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.wideious ?? ""
            logoImageView.kf.setImage(with: URL(string: model.spicly ?? ""))
            
            limitLabel.text = model.nuchine ?? ""
            numLabel.text = model.megfinishern ?? ""
            
            leftLabel.text = model.putitive ?? ""
            rightLabel.text = model.morning ?? ""
            
            applyLabel.text = model.powerability ?? ""
        }
    }
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "two_hea_li_image")
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "two_ac_li_image")
        twoImageView.contentMode = .scaleAspectFit
        return twoImageView
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
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var limitLabel: UILabel = {
        let limitLabel = UILabel()
        limitLabel.textAlignment = .center
        limitLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        limitLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return limitLabel
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        numLabel.font = UIFont.systemFont(ofSize: 47, weight: .bold)
        return numLabel
    }()
    
    lazy var leftLabel: UILabel = {
        let leftLabel = UILabel()
        leftLabel.textAlignment = .center
        leftLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        leftLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        leftLabel.layer.cornerRadius = 14
        leftLabel.layer.masksToBounds = true
        leftLabel.backgroundColor = UIColor.init(hexString: "#7F8594")
        return leftLabel
    }()
    
    lazy var rightLabel: UILabel = {
        let rightLabel = UILabel()
        rightLabel.textAlignment = .center
        rightLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        rightLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rightLabel.layer.cornerRadius = 14
        rightLabel.layer.masksToBounds = true
        rightLabel.backgroundColor = UIColor.init(hexString: "#7F8594")
        return rightLabel
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.backgroundColor = UIColor.init(hexString: "#4CA466")
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.layer.cornerRadius = 12
        applyLabel.layer.masksToBounds = true
        applyLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return applyLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(oneImageView)
        contentView.addSubview(twoImageView)
        contentView.addSubview(tapBtn)
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
        oneImageView.addSubview(nameLabel)
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(limitLabel)
        oneImageView.addSubview(numLabel)
        
        oneImageView.addSubview(leftLabel)
        oneImageView.addSubview(rightLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(17)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(nameLabel.snp.left).offset(-5)
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
            make.left.equalToSuperview().offset(44.pix())
            make.size.equalTo(CGSize(width: 120, height: 28))
        }
        rightLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(13.pix())
            make.right.equalToSuperview().offset(-44.pix())
            make.size.equalTo(CGSize(width: 120, height: 28))
        }
        
        twoImageView.addSubview(applyLabel)
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 50.pix()))
            make.bottom.equalToSuperview().offset(-11.pix())
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
