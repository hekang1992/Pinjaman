//
//  CpoViewCell.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CpoViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var tapBlock: (() -> Void)?
    
    var model: individualsterModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.asform ?? ""
            oneFiled.placeholder = model.betterern ?? ""
            
//            let enough = model.enough ?? ""
//            oneFiled.keyboardType = enough == "1" ? .numberPad : .default
            
            let windowfication = model.windowfication ?? ""
            oneFiled.text = windowfication
        }
    }
    
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
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(oneLabel)
        bgView.addSubview(oneView)
        oneView.addSubview(oneFiled)
        oneView.addSubview(rightImageView)
        oneView.addSubview(clickBtn)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(83)
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
        
        clickBtn.rx.tap
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
