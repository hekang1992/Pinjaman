//
//  AuthPhonesViewCell.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AuthPhonesViewCell: UITableViewCell {
    
    var model: variousingModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.punctious ?? ""
            oneLabel.text = model.payous ?? ""
            oneFiled.placeholder = model.tomoous ?? ""
            
            twoLabel.text = model.fire ?? ""
            twoFiled.placeholder = model.zyg ?? ""
            
            let name = model.secrfier ?? ""
            let listModelArray = model.tonightture ?? []
            for model in listModelArray {
                if name == model.histrieastlike ?? "" {
                    oneFiled.text = model.tomoeconomyet ?? ""
                }
            }
            
            let novendecevidenceeer = model.novendecevidenceeer ?? ""
            let tomoeconomyet = model.tomoeconomyet ?? ""
            twoFiled.text = novendecevidenceeer.isEmpty ? "" : "\(tomoeconomyet): \(novendecevidenceeer)"
            
        }
    }
    
    let disposeBag = DisposeBag()
    
    var tapRelaBlock: (() -> Void)?
    
    var tapPhoBlock: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 16
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#F9F9F9")
        return oneView
    }()
    
    lazy var oneFiled: UITextField = {
        let oneFiled = UITextField()
        oneFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        oneFiled.textColor = UIColor.init(hexString: "#333333")
        oneFiled.isEnabled = false
        return oneFiled
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "cpo_lis_l_r_image")
        return rightImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#333333")
        twoLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 16
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#F9F9F9")
        return twoView
    }()
    
    lazy var twoFiled: UITextField = {
        let twoFiled = UITextField()
        twoFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        twoFiled.textColor = UIColor.init(hexString: "#333333")
        twoFiled.isEnabled = false
        return twoFiled
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "cpo_lis_l_r_image")
        return twoImageView
    }()
    
    lazy var ctBtn: UIButton = {
        let ctBtn = UIButton(type: .custom)
        return ctBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        
        bgView.addSubview(oneLabel)
        bgView.addSubview(oneView)
        oneView.addSubview(oneFiled)
        oneView.addSubview(rightImageView)
        oneView.addSubview(clickBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(250)
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(18)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(20)
        }
        oneView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }
        rightImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.width.height.equalTo(20.pix())
            make.centerY.equalToSuperview()
        }
        oneFiled.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(twoLabel)
        bgView.addSubview(twoView)
        twoView.addSubview(twoFiled)
        twoView.addSubview(twoImageView)
        twoView.addSubview(ctBtn)
        
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(20)
        }
        twoView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(8)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(54)
        }
        twoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.width.height.equalTo(20.pix())
            make.centerY.equalToSuperview()
        }
        twoFiled.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
        ctBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapRelaBlock?()
            })
            .disposed(by: disposeBag)
        
        ctBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapPhoBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
