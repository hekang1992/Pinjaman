//
//  AuthListViewCell.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import SnapKit

class AuthListViewCell: UITableViewCell {
    
    var model: trachyifyModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.tomoeconomyet ?? ""
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FDDC63")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "sel_g_image")
        return iconImageView
    }()
    
    lazy var cycleView: UIView = {
        let cycleView = UIView()
        cycleView.layer.cornerRadius = 13
        cycleView.layer.masksToBounds = true
        cycleView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return cycleView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(cycleView)
        bgView.addSubview(iconImageView)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-18)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        cycleView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(26)
            make.right.equalToSuperview().offset(-18)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(26)
            make.right.equalToSuperview().offset(-18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedState(_ isSelected: Bool) {
        iconImageView.isHidden = !isSelected
    }
}
