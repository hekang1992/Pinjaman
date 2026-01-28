//
//  PhotoListView.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhotoListView: BaseView {
    
    var tapClickBlock: (() -> Void)?
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textAlignment = .center        
        descLabel.textColor = UIColor.init(hexString: "#52A66B")
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.backgroundColor = UIColor.init(hexString: "#D5E3DC")
        descLabel.layer.cornerRadius = 10.pix()
        descLabel.layer.masksToBounds = true
        return descLabel
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "p_dec_o_image")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var peopleImageView: UIImageView = {
        let peopleImageView = UIImageView()
        peopleImageView.layer.contents = 16
        peopleImageView.layer.masksToBounds = true
        return peopleImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = LStr("Upload")
        nameLabel.backgroundColor = UIColor.init(hexString: "#2C344A")
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.layer.cornerRadius = 16
        nameLabel.layer.masksToBounds = true
        return nameLabel
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(descLabel)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        addSubview(clickBtn)
        bgImageView.addSubview(peopleImageView)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 29.pix()))
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(12.pix())
            make.left.equalToSuperview()
            make.height.equalTo(170.pix())
        }
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 332.pix(), height: 170.pix()))
        }
        peopleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 163.pix(), height: 97.pix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(16.pix())
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 136, height: 30))
            }else {
                make.size.equalTo(CGSize(width: 106, height: 30))
            }
        }
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapClickBlock?()
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
