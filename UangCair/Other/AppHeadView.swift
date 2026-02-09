//
//  AppHeadView.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AppHeadView: BaseView {

    var backBlock: (() -> Void)?
    
    lazy var safeView: UIView = {
        let safeView = UIView()
        safeView.backgroundColor = UIColor.init(hexString: "#4CA466")
        return safeView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#4CA466")
        return bgView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "app_back_icon_image"), for: .normal)
        return backBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(safeView)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(nameLabel)
        safeView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        bgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(safeView.snp.bottom)
            make.height.equalTo(40.pix())
            make.bottom.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(18.pix())
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        backBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.backBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
