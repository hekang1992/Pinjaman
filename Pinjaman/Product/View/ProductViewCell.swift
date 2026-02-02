//
//  ProductViewCell.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import Kingfisher

class ProductViewCell: UITableViewCell {
        
    var model: mnesteryModel? {
        didSet {
            configureCell()
        }
    }
        
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var oneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pc_le_a_image")
        return imageView
    }()
    
    private lazy var twoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pc_lef_a_image")
        return imageView
    }()
    
    private lazy var typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cpo_lis_l_r_image")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(oneImageView)
        bgView.addSubview(twoImageView)
        
        oneImageView.addSubview(logoImageView)
        oneImageView.addSubview(nameLabel)
        twoImageView.addSubview(typeImageView)
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(66.pix())
            make.bottom.equalToSuperview().offset(-12.pix())
        }
        
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16.pix())
            make.size.equalTo(CGSize(width: 290.pix(), height: 66.pix()))
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(54.pix())
            make.leading.equalToSuperview().offset(5.pix())
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(30.pix())
            make.leading.equalTo(logoImageView.snp.trailing).offset(21.pix())
        }
        
        twoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16.pix())
            make.size.equalTo(CGSize(width: 60.pix(), height: 66.pix()))
        }
        
        typeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(26.pix())
        }
    }
        
    private func configureCell() {
        guard let model = model else { return }
        
        let nascorium = model.nascorium ?? ""
        typeImageView.image = nascorium == "1" ?
            UIImage(named: "cmp_lis_l_r_image") :
            UIImage(named: "cpo_lis_l_r_image")
        
        if let imageUrlString = model.tenuot,
           let imageUrl = URL(string: imageUrlString) {
            logoImageView.kf.setImage(with: imageUrl)
        }
        
        nameLabel.text = model.asform ?? ""
    }
}
