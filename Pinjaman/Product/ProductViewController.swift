//
//  ProductViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import UIKit
import SnapKit
import MJRefresh

class ProductViewController: BaseViewController {
    
    var productID: String = ""
    
    private let viewModel = ProductViewModel()
    
    lazy var productView: ProductView = {
        let productView = ProductView(frame: .zero)
        productView.backgroundColor = UIColor.init(hexString: "#ECEEF0")
        return productView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setTitleColor(.white, for: .normal)
        clickBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        clickBtn.backgroundColor = UIColor.init(hexString: "#222A40")
        clickBtn.layer.cornerRadius = 12.pix()
        clickBtn.layer.masksToBounds = true
        return clickBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 54.pix()))
        }
        
        view.addSubview(productView)
        productView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(clickBtn.snp.top).offset(-15.pix())
        }
        
        productView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.productdetilInfo()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.productdetilInfo()
        }
    }
    
}

extension ProductViewController {
    
    private func productdetilInfo() async {
        let parameters = ["ideaical": productID]
        do {
            let model = try await viewModel.productInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                if let standeeModel = model.standee {
                    if let republicanModel = standeeModel.republican {
                        self.setupUI(with: republicanModel)
                    }
                    self.productView.standeeModel = standeeModel
                }
            }
            await MainActor.run {
                self.productView.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.productView.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    private func setupUI(with model: republicanModel) {
        self.headView.nameLabel.text = model.wideious ?? ""
        self.clickBtn.setTitle(model.powerability ?? "", for: .normal)
    }
    
}
