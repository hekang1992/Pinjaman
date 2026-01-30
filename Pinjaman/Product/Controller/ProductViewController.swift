//
//  ProductViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import MJRefresh
import RxSwift
import RxCocoa

class ProductViewController: BaseViewController {
    
    var productID: String = ""
    
    private let viewModel = ProductViewModel()
    
    var model: BaseModel?
    
    private let locationService = LocationService()
    
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
        
        productView.cellBlock = { [weak self] model in
            guard let self = self else { return }
            let nascorium = model.nascorium ?? ""
            if nascorium == "1" {
                if let republicanModel = self.model?.standee?.republican {
                    self.clickModelToPage(with: model,
                                          republicanModel: republicanModel,
                                          productID: productID,
                                          viewModel: viewModel)
                }
                
            }else {
                if let clickModel = self.model?.standee?.annsureist, let republicanModel = self.model?.standee?.republican {
                    self.clickModelToPage(with: clickModel,
                                          republicanModel: republicanModel,
                                          productID: productID,
                                          viewModel: viewModel)
                }
            }
        }
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      let model = model else { return }
                let clickModel = model.standee?.annsureist
                let republicanModel = model.standee?.republican
                self.clickModelToPage(with: clickModel,
                                      republicanModel: republicanModel,
                                      productID: productID,
                                      viewModel: viewModel)
            })
            .disposed(by: disposeBag)
        
        productView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.productPagedetilInfo()
            }
        })
        
        locationService.requestCurrentLocation { locationDict in }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.productPagedetilInfo()
        }
    }
    
}

extension ProductViewController {
    
    private func productPagedetilInfo() async {
        let parameters = ["ideaical": productID]
        do {
            let model = try await viewModel.productInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                self.model = model
                if let standeeModel = model.standee {
                    if let republicanModel = standeeModel.republican {
                        self.setupUI(with: republicanModel)
                    }
                    self.productView.standeeModel = standeeModel
                }
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
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
