//
//  ProductView.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit
import SnapKit
import Kingfisher

class ProductView: UIView {
    
    var standeeModel: standeeModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 66.pix()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: "ProductViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 334.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let model = standeeModel?.republican
        
        let headView = UIView()
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pc_head_image")
        bgImageView.contentMode = .scaleToFill
        
        headView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(244.pix())
        }
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LStr("Certification process")
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let descLabel = UILabel()
        descLabel.textAlignment = .center
        descLabel.text = LStr("We will ensure the security of your information.")
        descLabel.textColor = UIColor.init(hexString: "#52A66B")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descLabel.backgroundColor = UIColor.init(hexString: "#D5E3DC")
        descLabel.layer.cornerRadius = 10.pix()
        descLabel.layer.masksToBounds = true
        
        headView.addSubview(nameLabel)
        headView.addSubview(descLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-55.pix())
            make.left.equalToSuperview().offset(17.pix())
            make.height.equalTo(17.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 29.pix()))
        }
        
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "pc_ha_head_image")
        headView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 347.pix(), height: 195.pix()))
            make.top.equalToSuperview().offset(20.pix())
        }
        
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 6
        logoImageView.layer.masksToBounds = true
        
        let productLabel = UILabel()
        productLabel.textAlignment = .left
        productLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        productLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        let limitLabel = UILabel()
        limitLabel.textAlignment = .center
        limitLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        limitLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        let numLabel = UILabel()
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        numLabel.font = UIFont.systemFont(ofSize: 47, weight: .bold)
        
        headView.addSubview(productLabel)
        headView.addSubview(logoImageView)
        headView.addSubview(limitLabel)
        headView.addSubview(numLabel)
        
        productLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(77.pix())
            make.height.equalTo(17.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(nameLabel.snp.left).offset(-5)
            make.width.height.equalTo(28)
        }
        
        limitLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(productLabel.snp.bottom).offset(18.5.pix())
            make.height.equalTo(19)
        }
        
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(limitLabel.snp.bottom).offset(4.pix())
            make.centerX.equalToSuperview()
            make.height.equalTo(55.pix())
        }
        
        productLabel.text = model?.wideious ?? ""
        logoImageView.kf.setImage(with: URL(string: model?.spicly ?? ""))
        limitLabel.text = model?.controwho ?? ""
        numLabel.text = model?.epish ?? ""
        
        return headView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standeeModel?.mnestery?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = standeeModel?.mnestery?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductViewCell", for: indexPath) as! ProductViewCell
        cell.model = model
        return cell
    }
    
}
