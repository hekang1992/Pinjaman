//
//  OrderListViewController.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import MJRefresh

class OrderListViewController: BaseViewController {
    
    var name: String = ""
    
    var type: String = ""
    
    private let viewModel = OrderViewModel()
    
    private var selectedButton: UIButton?
    
    var modelArray: [variousingModel] = []
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        emptyView.isHidden = true
        return emptyView
    }()
    
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
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        tableView.register(OrderNorViewCell.self, forCellReuseIdentifier: "OrderNorViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.nameLabel.text = name
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        emptyView.clickBlock = { [weak self] in
            self?.changeRootVc()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.orderlistInfo(with: self.type)
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.orderlistInfo(with: type)
        }
    }
    
}

extension OrderListViewController {
    
    private func orderlistInfo(with type: String) async {
        do {
            let parameters = ["leihotelform": type,
                              "pudeauthorityule": String(Int(0 + 1)),
                              "ohoon": String(Int(20 + 30))]
            let model = try await viewModel.getOrderInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let listArray = model.standee?.variousing ?? []
                emptyView.isHidden = !listArray.isEmpty
                tableView.isHidden = listArray.isEmpty
                self.modelArray = listArray
                self.tableView.reloadData()
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let applyName = model.requiresure?.equinism ?? ""
        
        if applyName.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNorViewCell", for: indexPath) as! OrderNorViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.identifyally ?? ""
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        }else if pageUrl.hasPrefix("http") {
            self.goContentWebVc(with: pageUrl)
        }
    }
    
}
