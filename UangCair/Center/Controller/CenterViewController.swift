//
//  CenterViewController.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import SnapKit
import MJRefresh

class CenterViewController: BaseViewController {
    
    private let viewModel = CenterViewModel()
    
    lazy var mineView: MeCenterView = {
        let mineView = MeCenterView()
        mineView.backgroundColor = UIColor.init(hexString: "#ECEEF0")
        return mineView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mineView)
        mineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mineView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.centerInfo()
            }
        })
        
        mineView.leftBlock = { [weak self] in
            guard let self = self else { return }
            let pageUrl = h5_base_url + "/vellidea"
            self.goContentWebVc(with: pageUrl)
        }
        
        mineView.rightBlock = { [weak self] in
            guard let self = self else { return }
            let pageUrl = h5_base_url + "/forery"
            self.goContentWebVc(with: pageUrl)
        }
        
        mineView.oneBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderListViewController()
            listVc.type = "4"
            listVc.name = LStr("All")
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        mineView.twoBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderListViewController()
            listVc.type = "7"
            listVc.name = LStr("In progress")
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        mineView.threeBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderListViewController()
            listVc.type = "6"
            listVc.name = LStr("Repayment")
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        mineView.fourBlock = { [weak self] in
            guard let self = self else { return }
            let listVc = OrderListViewController()
            listVc.type = "5"
            listVc.name = LStr("Finished")
            self.navigationController?.pushViewController(listVc, animated: true)
        }
        
        mineView.listTapClick = { [weak self] pageUrl in
            guard let self = self else { return }
            if pageUrl.hasPrefix(scheme_url) {
                DeepLinkNavigator.navigate(to: pageUrl, from: self)
            }else if pageUrl.hasPrefix("http") {
                self.goContentWebVc(with: pageUrl)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.centerInfo()
        }
    }
    
}

extension CenterViewController {
    
    private func centerInfo() async {
        do {
            let model = try await viewModel.getCenterInfo()
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let listArray = model.standee?.veriid ?? []
                self.mineView.listArray = listArray
            }
            await self.mineView.scrollView.mj_header?.endRefreshing()
        } catch {
            await self.mineView.scrollView.mj_header?.endRefreshing()
        }
    }
    
}
