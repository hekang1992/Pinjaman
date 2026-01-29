//
//  HomeViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    lazy var oneView: OneHomeView = {
        let oneView = OneHomeView()
        oneView.backgroundColor = UIColor.init(hexString: "#ECEEF0")
        return oneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(oneView)
        oneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneView.applyBlock = { [weak self] model in
            guard let self = self else { return }
            if !UserManager.shared.isLogin {
                let loginVc = BaseNavigationController(
                    rootViewController: LoginViewController()
                )
                loginVc.modalPresentationStyle = .fullScreen
                self.present(loginVc, animated: true)
                return
            }
            let productID = String(model.allosion ?? 0)
            Task {
                await self.clickProductInfo(with: productID)
            }
        }
        
        oneView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getHomeInfo()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getHomeInfo()
        }
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() async {
        do {
            let model = try await viewModel.getHomeInfo()
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let listArray = model.standee?.variousing ?? []
                if let oneModel = listArray.first(where: { $0.histrieastlike == "horm" }) {
                    self.oneView.listModel = oneModel
                }
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
            await MainActor.run {
                self.oneView.scrollView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.oneView.scrollView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func clickProductInfo(with productID: String) async {
        do {
            let parameters = ["forgetaire": "1001", "sacridirectorive": "1000", "tersery": "1000", "ideaical": productID]
            let model = try await viewModel.clickProductInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let pageUrl = model.standee?.howeveracy ?? ""
                self.clickPageInfo(with: pageUrl)
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
        } catch {
            
        }
    }
    
    private func clickPageInfo(with pageUrl: String) {
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        }else if pageUrl.hasPrefix("http") {
            self.goContentWebVc(with: pageUrl)
        }
    }
    
}
