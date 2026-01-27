//
//  ProductViewCell.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit
import SnapKit

class ProductViewCell: UITableViewCell {
    
    var model: mnesteryModel? {
        didSet {
            guard let model = model else { return }
            let nascorium = model.nascorium ?? ""
            typeImageView.image = nascorium == "1" ? UIImage(named: "cmp_lis_l_r_image") : UIImage(named: "cpo_lis_l_r_image")
        }
    }
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        return bgView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "pc_le_a_image")
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "pc_lef_a_image")
        return twoImageView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.image = UIImage(named: "cpo_lis_l_r_image")
        return typeImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(oneImageView)
        bgView.addSubview(twoImageView)
        twoImageView.addSubview(typeImageView)
        bgView.snp.makeConstraints { make in
            make.top.leading.right.equalToSuperview()
            make.height.equalTo(66.pix())
            make.bottom.equalToSuperview().offset(-12.pix())
        }
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.pix())
            make.size.equalTo(CGSize(width: 290.pix(), height: 66.pix()))
        }
        twoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.pix())
            make.size.equalTo(CGSize(width: 60.pix(), height: 66.pix()))
        }
        typeImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(26.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
