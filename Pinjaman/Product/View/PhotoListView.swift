//
//  PhotoListView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhotoListView: BaseView {
    
    var tapClickBlock: (() -> Void)?
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#52A66B")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.backgroundColor = UIColor(hexString: "#D5E3DC")
        label.layer.cornerRadius = 10.pix()
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "p_dec_o_image")
        return imageView
    }()
    
    private lazy var bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var peopleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.contents = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = LStr("Upload")
        label.backgroundColor = UIColor(hexString: "#2C344A")
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var trptImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sel_g_image")
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var clickBtn: UIButton = {
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
        addSubview(descLabel)
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgImageView.addSubview(nameLabel)
        addSubview(clickBtn)
        bgImageView.addSubview(peopleImageView)
        bgView.addSubview(trptImageView)
    }
    
    private func setupConstraints() {
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 29.pix()))
        }
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(12.pix())
            make.leading.equalToSuperview()
            make.height.equalTo(170.pix())
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 332.pix(), height: 170.pix()))
        }
        
        peopleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 163.pix(), height: 97.pix()))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16.pix())
            
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 136, height: 30))
            } else {
                make.size.equalTo(CGSize(width: 106, height: 30))
            }
        }
        
        trptImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-18)
            make.width.height.equalTo(26)
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.tapClickBlock?()
            })
            .disposed(by: disposeBag)
    }
}
