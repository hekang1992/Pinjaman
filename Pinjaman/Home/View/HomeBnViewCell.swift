//
//  HomeBnViewCell.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/29.
//

import UIKit
import SnapKit
import FSPagerView

class HomeBnViewCell: UITableViewCell {
    
    var tapBanBlock: ((misceeerModel) -> Void)?
    
    var modelArray: [misceeerModel]? {
        didSet {
            pagerView.reloadData()
        }
    }

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "bn_arr_a_image")
        return arrowImageView
    }()
    
    lazy var pagerView: FSPagerView = {
        let pv = FSPagerView()
        pv.dataSource = self
        pv.delegate = self
        pv.register(CustomPagerCell.self, forCellWithReuseIdentifier: "CustomPagerCell")
        pv.interitemSpacing = 5
        pv.transformer = FSPagerViewTransformer(type: .linear)
        pv.isInfinite = true
        pv.automaticSlidingInterval = 3.0
        pv.backgroundColor = .clear
        pv.layer.borderWidth = 0
        return pv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(pagerView)
        bgView.addSubview(arrowImageView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 58.pix()))
            make.bottom.equalToSuperview().offset(-10)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        pagerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeBnViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let model = self.modelArray?[index]
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CustomPagerCell", at: index) as! CustomPagerCell
        cell.titleLabel.text = model?.troubleably ?? ""
        
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        cell.contentView.transform = CGAffineTransform.identity
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let model = self.modelArray?[index] {
            self.tapBanBlock?(model)
        }
    }
}

class CustomPagerCell: FSPagerViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(hexString: "#030305")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}
