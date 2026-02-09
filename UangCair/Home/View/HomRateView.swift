//
//  HomRateView.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit

class HomRateView: UIView {
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#666666")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.textColor = UIColor.init(hexString: "#333333")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return twoLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneLabel)
        addSubview(twoLabel)
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(17)
        }
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
