//
//  OrderEmptyView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OrderEmptyView: BaseView {
    
    var clickBlock: (() -> Void)?
    
    lazy var emptyBtn: UIButton = {
        let emptyBtn = UIButton(type: .custom)
        let imagename = languageCode == .indonesian ? "pty_id_image" : "pty_en_image"
        emptyBtn.setImage(UIImage(named: imagename), for: .normal)
        emptyBtn.adjustsImageWhenHighlighted = false
        emptyBtn.imageView?.contentMode = .scaleAspectFit
        return emptyBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyBtn)
        emptyBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 193.pix(), height: 255.pix()))
        }
        
        emptyBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.clickBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
