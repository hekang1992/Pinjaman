//
//  OrderViewCell.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: variousingModel? {
        didSet {
            configureCell()
        }
    }
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "odd_list_bg_image")
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor(hexString: "#D5D5D5")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return label
    }()
    
    private lazy var oneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var twoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var threeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var fourLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor(hexString: "#333333")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var applyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(hexString: "#4CA466")
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(typeLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(fourLabel)
        bgImageView.addSubview(applyLabel)
        bgImageView.addSubview(descLabel)
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 249.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28.pix())
            make.top.equalToSuperview().offset(13.pix())
            make.leading.equalToSuperview().offset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.leading.equalTo(logoImageView.snp.trailing).offset(8)
            make.height.equalTo(17)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(24)
            make.trailing.equalToSuperview().offset(-16)
            make.width.greaterThanOrEqualTo(110)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(logoImageView.snp.bottom).offset(42.pix())
            make.height.equalTo(14)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(oneLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(oneLabel.snp.bottom).offset(23.pix())
            make.height.equalTo(15)
        }
        
        fourLabel.snp.makeConstraints { make in
            make.centerY.equalTo(threeLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(14)
        }
        
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(fourLabel.snp.bottom).offset(20.pix())
            make.size.equalTo(CGSize(width: 311.pix(), height: 45.pix()))
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(applyLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(311.pix())
        }
    }
    
    private func configureCell() {
        guard let model = model else { return }
        
        let logoUrl = model.spicly ?? ""
        let name = model.wideious ?? ""
        
        if let url = URL(string: logoUrl) {
            logoImageView.kf.setImage(with: url)
        }
        
        nameLabel.text = name
        oneLabel.text = model.mrsible ?? ""
        twoLabel.text = model.responsesive ?? ""
        threeLabel.text = model.requiresure?.caud ?? ""
        fourLabel.text = model.requiresure?.memberaster ?? ""
        applyLabel.text = model.requiresure?.equinism ?? ""
        descLabel.text = model.requiresure?.pageule ?? ""
        typeLabel.text = model.requiresure?.lowor ?? ""
        
        configureTypeLabel(for: model.requiresure?.densneverless ?? "")
    }
    
    private func configureTypeLabel(for densneverless: String) {
        switch densneverless {
        case "leaveance":
            typeLabel.backgroundColor = UIColor(hexString: "#DA3030")
        case "attorneyaceous":
            typeLabel.backgroundColor = UIColor(hexString: "#8530DA")
        case "munacious":
            typeLabel.backgroundColor = UIColor(hexString: "#30AADA")
        case "donian":
            typeLabel.backgroundColor = UIColor(hexString: "#DA9E30")
        case "classarian":
            typeLabel.backgroundColor = UIColor(hexString: "#AFDA30")
        default:
            break
        }
        
        descLabel.textColor = typeLabel.backgroundColor
    }
}
