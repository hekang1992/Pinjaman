//
//  TwoHomeView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit

class TwoHomeView: UIView {
    
    var modelArry: [variousingModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tapCellBlock: ((misceeerModel) -> Void)?
    
    var tapBanBlock: ((misceeerModel) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeHeadViewCell.self, forCellReuseIdentifier: "HomeHeadViewCell")
        tableView.register(HomeBnViewCell.self, forCellReuseIdentifier: "HomeBnViewCell")
        tableView.register(HomeProductViewCell.self, forCellReuseIdentifier: "HomeProductViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "one_home_head_image")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(tableView)
        
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(399.pix())
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(5.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TwoHomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArry?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = modelArry?[section]
        if model?.histrieastlike == "atite" {
            return 1
        }else {
            return model?.misceeer?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bigmodel = modelArry?[indexPath.section]
        let type = bigmodel?.histrieastlike ?? ""
        
        let listModel = bigmodel?.misceeer?[indexPath.row]
        
        if type == "brom" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeHeadViewCell", for: indexPath) as! HomeHeadViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = listModel
            cell.tapCellBlock = { [weak self] model in
                guard let self = self else { return }
                self.tapCellBlock?(model)
            }
            return cell
        }else if type == "atite" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBnViewCell", for: indexPath) as! HomeBnViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.modelArray = bigmodel?.misceeer ?? []
            cell.tapBanBlock = { [weak self] model in
                guard let self = self else { return }
                self.tapBanBlock?(model)
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeProductViewCell", for: indexPath) as! HomeProductViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = listModel
            cell.tapCellBlock = { [weak self] model in
                guard let self = self else { return }
                self.tapCellBlock?(model)
            }
            return cell
        }
    }
    
}
