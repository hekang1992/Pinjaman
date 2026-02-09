//
//  HomeBnViewCell.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/29.
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
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
        return view
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bn_arr_a_image")
        return imageView
    }()
    
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(CustomPagerCell.self, forCellWithReuseIdentifier: "CustomPagerCell")
        pagerView.interitemSpacing = 5
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.backgroundColor = .clear
        pagerView.layer.borderWidth = 0
        return pagerView
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
        bgView.addSubview(pagerView)
        bgView.addSubview(arrowImageView)
    }
    
    private func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 58.pix()))
            make.bottom.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        pagerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.trailing.equalTo(arrowImageView.snp.leading).offset(-10)
        }
    }
}

extension HomeBnViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(
            withReuseIdentifier: "CustomPagerCell",
            at: index
        ) as! CustomPagerCell
        
        if let model = modelArray?[index] {
            cell.titleLabel.text = model.troubleably ?? ""
        }
        self.cellPara(with: cell)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        guard let model = modelArray?[index] else { return }
        tapBanBlock?(model)
    }
    
    private func cellPara(with cell: CustomPagerCell) {
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        cell.contentView.transform = CGAffineTransform.identity
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
    }
}

class CustomPagerCell: FSPagerViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#030305")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var containerView: UIView = {
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
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
