//
//  PopAutnEnumView 2.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopAutnEnumView: BaseView {
    
    var cancelBlock: (() -> Void)?
    var saveBlock: ((trachyifyModel) -> Void)?
    
    private var currentSelectedIndex: Int? = nil
    
    var modelArray: [trachyifyModel]?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pop_head_su_image")
        return bgImageView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "cen_be_a_image"), for: .normal)
        cancelBtn.adjustsImageWhenHighlighted = true
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton(type: .custom)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.setTitle(LStr("Confirm"), for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        saveBtn.backgroundColor = UIColor.init(hexString: "#4CA466")
        saveBtn.layer.cornerRadius = 12.pix()
        saveBtn.layer.masksToBounds = true
        return saveBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AuthListViewCell.self, forCellReuseIdentifier: "AuthListViewCell")
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.addSubview(bgImageView)
        contentView.addSubview(bgView)
        contentView.addSubview(cancelBtn)
        bgView.addSubview(nameLabel)
        bgView.addSubview(saveBtn)
        bgView.addSubview(tableView)
        
        contentView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(546.pix())
        }
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 165.pix()))
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(380.pix())
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.width.height.equalTo(40.pix())
            make.top.right.equalToSuperview().inset(13.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(17)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25.pix())
            make.size.equalTo(CGSize(width: 311.pix(), height: 54.pix()))
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalTo(saveBtn.snp.top).offset(-5.pix())
        }
        
        cancelBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        saveBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if currentSelectedIndex == nil {
                    ToastManager.showLocal("Please select one")
                    return
                }
                if let modelArray = modelArray, let currentSelectedIndex = currentSelectedIndex {
                    self.saveBlock?(modelArray[currentSelectedIndex])
                }
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectIndex(_ index: Int?) {
        guard let modelArray = modelArray, modelArray.count > 0 else { return }
        
        if let index = index, index >= 0 && index < modelArray.count {
            currentSelectedIndex = index
        } else {
            currentSelectedIndex = nil
        }
        
        tableView.reloadData()
    }
    
}

extension PopAutnEnumView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthListViewCell", for: indexPath) as! AuthListViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.model = self.modelArray?[indexPath.row]
        
        let isSelected = (currentSelectedIndex == indexPath.row)
        cell.setSelectedState(isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSelectedIndex == indexPath.row {
            currentSelectedIndex = nil
        } else {
            currentSelectedIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
}
