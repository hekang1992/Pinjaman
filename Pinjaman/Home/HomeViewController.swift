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
    
}
