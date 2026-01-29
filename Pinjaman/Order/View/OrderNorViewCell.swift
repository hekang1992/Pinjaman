//
//  OrderNorViewCell 2.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/29.
//

import UIKit
import SnapKit
import Kingfisher

class OrderNorViewCell: UITableViewCell {
    
    var model: variousingModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.spicly ?? ""
            let name = model.wideious ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = name
            
            oneLabel.text = model.mrsible ?? ""
            twoLabel.text = model.responsesive ?? ""
            
            threeLabel.text = model.requiresure?.caud ?? ""
            fourLabel.text = model.requiresure?.memberaster ?? ""
            
            let densneverless = model.requiresure?.densneverless ?? ""
            typeLabel.text = model.requiresure?.lowor ?? ""
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
            
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "odd_listno_bg_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = UIColor.init(hexString: "#D5D5D5")
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .center
        typeLabel.layer.cornerRadius = 12
        typeLabel.layer.masksToBounds = true
        typeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(500))
        return typeLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .right
        twoLabel.textColor = UIColor.init(hexString: "#333333")
        twoLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = UIColor.init(hexString: "#333333")
        threeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return threeLabel
    }()
    
    lazy var fourLabel: UILabel = {
        let fourLabel = UILabel()
        fourLabel.textAlignment = .right
        fourLabel.textColor = UIColor.init(hexString: "#333333")
        fourLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return fourLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(typeLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(fourLabel)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 171.pix()))
            make.bottom.equalToSuperview().offset(-15.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(28.pix())
            make.top.equalToSuperview().offset(13.pix())
            make.left.equalToSuperview().offset(16)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(17)
        }
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.height.equalTo(24)
            make.right.equalToSuperview().offset(-16)
            make.width.greaterThanOrEqualTo(110)
        }
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(logoImageView.snp.bottom).offset(42.pix())
            make.height.equalTo(14)
        }
        twoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(oneLabel)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(oneLabel.snp.bottom).offset(23.pix())
            make.height.equalTo(15)
        }
        fourLabel.snp.makeConstraints { make in
            make.centerY.equalTo(threeLabel)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(14)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
