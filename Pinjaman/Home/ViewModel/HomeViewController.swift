//
//  HomeViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import SnapKit
import MJRefresh
import CoreLocation

class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    private let locationService = LocationService()
    
    var locationParameters: [String: String] = [:]
    
    lazy var oneView: OneHomeView = {
        let view = OneHomeView()
        view.backgroundColor = UIColor(hexString: "#ECEEF0")
        view.isHidden = true
        return view
    }()
    
    lazy var twoView: TwoHomeView = {
        let view = TwoHomeView()
        view.backgroundColor = UIColor(hexString: "#ECEEF0")
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
        setupRefresh()
        locationService.requestCurrentLocation { locationDict in }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await getHomeInfo() }
    }
}

private extension HomeViewController {
    
    func setupViews() {
        view.addSubview(oneView)
        oneView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        view.addSubview(twoView)
        twoView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupActions() {
        
        oneView.loanBlock = { [weak self] in
            guard let self = self else { return }
            guard UserManager.shared.isLogin else {
                self.presentLogin()
                return
            }
            ToastManager.showLocal("loan")
        }
        
        oneView.applyBlock = { [weak self] model in
            guard let self = self else { return }
            
            guard UserManager.shared.isLogin else {
                self.presentLogin()
                return
            }
            
            let productID = String(model.allosion ?? 0)
            
            Task {
                let status = CLLocationManager().authorizationStatus
                if LanguageManager.shared.currentType == .indonesian {
                    if status == .restricted || status == .denied {
                        self.showSettingsAlert()
                        return
                    }
                }
                
                Task {
                    await self.clickProductInfo(with: productID)
                }
                
                Task {
                    await self.uploadAppInfo()
                }
            }
            
            
        }
        
        twoView.tapCellBlock = { [weak self] model in
            guard let self = self else { return }
            
            guard UserManager.shared.isLogin else {
                self.presentLogin()
                return
            }
            
            let productID = String(model.allosion ?? 0)
            
            Task {
                let status = CLLocationManager().authorizationStatus
                if LanguageManager.shared.currentType == .indonesian {
                    if status == .restricted || status == .denied {
                        self.showSettingsAlert()
                        return
                    }
                }
                
                Task {
                    await self.clickProductInfo(with: productID)
                }
                
                Task {
                    await self.uploadAppInfo()
                }
            }
            
        }
        
        twoView.tapBanBlock = { [weak self] model in
            guard let self = self else { return }
            let pageUrl = model.howeveracy ?? ""
            clickPageInfo(with: pageUrl)
        }
        
    }
    
    func setupRefresh() {
        oneView.scrollView.mj_header = MJRefreshNormalHeader { [weak self] in
            guard let self = self else { return }
            Task { await self.getHomeInfo() }
        }
        twoView.tableView.mj_header = MJRefreshNormalHeader { [weak self] in
            guard let self = self else { return }
            Task { await self.getHomeInfo() }
        }
    }
    
    func presentLogin() {
        let loginVc = BaseNavigationController(
            rootViewController: LoginViewController()
        )
        loginVc.modalPresentationStyle = .fullScreen
        present(loginVc, animated: true)
    }
}

private extension HomeViewController {
    
    func getHomeInfo() async {
        defer {
            Task { @MainActor in
                self.oneView.scrollView.mj_header?.endRefreshing()
                self.twoView.tableView.mj_header?.endRefreshing()
            }
        }
        
        do {
            let model = try await viewModel.getHomeInfo()
            handleHomeInfo(model)
        } catch {
            
        }
    }
    
    func handleHomeInfo(_ model: BaseModel) {
        let taxant = model.taxant ?? ""
        guard ["0", "00"].contains(taxant) else {
            ToastManager.showLocal(model.troubleably ?? "")
            return
        }
        
        let list = model.standee?.variousing ?? []
        
        if let oneModel = list.first(where: { $0.histrieastlike == "horm" }) {
            oneView.listModel = oneModel
            oneView.isHidden = false
            twoView.isHidden = true
            return
        }
        
        if (model.standee?.variousing?.first(where: { $0.histrieastlike == "brom" })) != nil {
            let modelArray = model.standee?.variousing ?? []
            let lastModels = modelArray.contains(where: { $0.histrieastlike == "nomisive" })
            ? modelArray.filter { $0.histrieastlike != "nomisive" }
            : modelArray
            
            twoView.modelArry = lastModels
            oneView.isHidden = true
            twoView.isHidden = false
        }
        
    }
    
    func clickProductInfo(with productID: String) async {
        
        let parameters = [
            "forgetaire": "1001",
            "sacridirectorive": "1000",
            "tersery": "1000",
            "ideaical": productID
        ]
        
        do {
            let model = try await viewModel.clickProductInfo(with: parameters)
            handleProductInfo(model)
        } catch {
            
        }
    }
    
    func handleProductInfo(_ model: BaseModel) {
        let taxant = model.taxant ?? ""
        guard ["0", "00"].contains(taxant) else {
            ToastManager.showLocal(model.troubleably ?? "")
            return
        }
        
        let pageUrl = model.standee?.howeveracy ?? ""
        clickPageInfo(with: pageUrl)
    }
    
    private func uploadAppInfo() async {
        locationService.requestCurrentLocation { [weak self] locationDict in
            Task {
                await self?.uploadLocationInfo(with: locationDict ?? [:])
            }
        }
        Task {
            await self.uploadMacInfo()
        }
    }
}

extension HomeViewController {
    
    private func uploadLocationInfo(with parameters: [String: String]) async {
        do {
            let _ = try await viewModel.uploadLocationInfo(with: parameters)
        } catch {
            
        }
    }
    
    private func uploadMacInfo() async {
        await withCheckedContinuation { continuation in
            DeviceCollector.collect { dict in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                    let base64String = jsonData.base64EncodedString()
                    
                    let parameters = ["standee": base64String]
                    
                    Task {
                        do {
                            let _ = try await self.viewModel.uploadMacInfo(with: parameters)
                            continuation.resume()
                        } catch {
                            continuation.resume()
                        }
                    }
                } catch {
                    continuation.resume()
                }
            }
        }
    }
    
}

private extension HomeViewController {
    
    private func showSettingsAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: LStr("Location Services Disabled"),
                message: LStr("Please enable location services in Settings to allow the app to determine your location."),
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: LStr("Cancel"), style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            let settingsAction = UIAlertAction(title: LStr("Settings"), style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            alert.addAction(settingsAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func clickPageInfo(with pageUrl: String) {
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        } else if pageUrl.hasPrefix("http") {
            goContentWebVc(with: pageUrl)
        }
    }
}
