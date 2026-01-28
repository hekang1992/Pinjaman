//
//  SavePhotoMessageView.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SavePhotoMessageView: BaseView {
    
    var model: standeeModel? {
        didSet {
            guard let model = model else { return }
            oneFiled.text = model.tomoeconomyet ?? ""
            twoFiled.text = model.neverful ?? ""
            threeFiled.text = model.pentecostate ?? ""
        }
    }
    
    var cancelBlock: (() -> Void)?
    
    var timeBlock: ((UITextField) -> Void)?
    
    var saveBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pop_head_su_image")
        return bgImageView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "cen_be_a_image"), for: .normal)
        cancelBtn.adjustsImageWhenHighlighted = true
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LStr("Identity information")
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.text = LStr("Real name")
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 16
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#FDDC63")
        return oneView
    }()
    
    lazy var oneFiled: UITextField = {
        let oneFiled = UITextField()
        oneFiled.placeholder = LStr("Real name")
        oneFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        oneFiled.textColor = UIColor.init(hexString: "#333333")
        return oneFiled
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.text = LStr("ID Number")
        twoLabel.textColor = UIColor.init(hexString: "#333333")
        twoLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 16
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#FDDC63")
        return twoView
    }()
    
    lazy var twoFiled: UITextField = {
        let twoFiled = UITextField()
        twoFiled.placeholder = LStr("ID Number")
        twoFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        twoFiled.textColor = UIColor.init(hexString: "#333333")
        return twoFiled
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.text = LStr("Birthday")
        threeLabel.textColor = UIColor.init(hexString: "#333333")
        threeLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return threeLabel
    }()
    
    lazy var threeView: UIView = {
        let threeView = UIView()
        threeView.layer.cornerRadius = 16
        threeView.layer.masksToBounds = true
        threeView.backgroundColor = UIColor.init(hexString: "#FDDC63")
        return threeView
    }()
    
    lazy var threeFiled: UITextField = {
        let threeFiled = UITextField()
        threeFiled.placeholder = LStr("Birthday")
        threeFiled.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        threeFiled.textColor = UIColor.init(hexString: "#333333")
        return threeFiled
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.setTitle(LStr("Confirm"), for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        saveBtn.backgroundColor = UIColor.init(hexString: "#4CA466")
        saveBtn.layer.cornerRadius = 12.pix()
        saveBtn.layer.masksToBounds = true
        return saveBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.addSubview(bgImageView)
        contentView.addSubview(bgView)
        contentView.addSubview(cancelBtn)
        bgView.addSubview(nameLabel)
        
        bgView.addSubview(oneLabel)
        bgView.addSubview(oneView)
        oneView.addSubview(oneFiled)
        
        bgView.addSubview(twoLabel)
        bgView.addSubview(twoView)
        twoView.addSubview(twoFiled)
        
        bgView.addSubview(threeLabel)
        bgView.addSubview(threeView)
        threeView.addSubview(threeFiled)
        threeView.addSubview(clickBtn)
        
        bgView.addSubview(saveBtn)
        
        contentView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(566.pix())
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 165.pix()))
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(401.pix())
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.width.height.equalTo(40.pix())
            make.top.right.equalToSuperview().inset(13.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(17)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(nameLabel.snp.bottom).offset(18)
            make.height.equalTo(20)
        }
        
        oneView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(8)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        oneFiled.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12.pix())
            make.top.bottom.equalToSuperview()
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(oneView.snp.bottom).offset(16)
            make.height.equalTo(20)
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(8)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        twoFiled.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12.pix())
            make.top.bottom.equalToSuperview()
        }
        
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(twoView.snp.bottom).offset(16)
            make.height.equalTo(20)
        }
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(threeLabel.snp.bottom).offset(8)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        threeFiled.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(12.pix())
            make.top.bottom.equalToSuperview()
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.pix())
            make.size.equalTo(CGSize(width: 311.pix(), height: 54.pix()))
        }
        
        cancelBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.timeBlock?(threeFiled)
            })
            .disposed(by: disposeBag)
        
        saveBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.saveBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
