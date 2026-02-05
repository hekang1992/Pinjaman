//
//  HomeViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import SnapKit
import MJRefresh
import CoreLocation
import FBSDKCoreKit

class HomeViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    private let productViewModel = ProductViewModel()
    
    private let locationService = LocationService()
    
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
        
        let type = UserDefaults.standard.object(forKey: "upload_IDFA_Info") as? String ?? ""
        
        if type != "1" {
            Task {
                await self.uploadIDFAInfo()
            }
        }
        
        Task {
            await self.getProvicesInfo()
        }
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
            let pageUrl = h5_base_url + "/forery"
            self.goContentWebVc(with: pageUrl)
        }
        
        oneView.descBlock = { [weak self] in
            guard let self = self else { return }
            let descVc = DescLaonViewController()
            self.navigationController?.pushViewController(descVc, animated: true)
        }
        
        oneView.applyBlock = { [weak self] model in
            guard let self = self else { return }
            
            guard UserManager.shared.isLogin else {
                self.presentLogin()
                return
            }
            
            let productID = String(model.allosion ?? 0)
            
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
            
            Task {
                let start = UserDefaults.standard.object(forKey: "start") as? String ?? ""
                let end = UserDefaults.standard.object(forKey: "end") as? String ?? ""
                if !start.isEmpty && !end.isEmpty {
                    await self.suddenlyalBeaconingInfo(with: self.productViewModel,
                                                       productID: "",
                                                       type: "1",
                                                       orderID: "",
                                                       start: start,
                                                       end: end)
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
            
            Task {
                let start = UserDefaults.standard.object(forKey: "start") as? String ?? ""
                let end = UserDefaults.standard.object(forKey: "end") as? String ?? ""
                if !start.isEmpty && !end.isEmpty {
                    await self.suddenlyalBeaconingInfo(with: self.productViewModel,
                                                       productID: "",
                                                       type: "1",
                                                       orderID: "",
                                                       start: start,
                                                       end: end)
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
    
    private func uploadIDFAInfo() async {
        let hol = SecurityVault.shared.getIDFV()
        let minaciial = SecurityVault.shared.getIDFV()
        let edgester = SecurityVault.shared.getIDFA()
        let parameters = ["hol": hol, "minaciial": minaciial, "edgester": edgester]
        do {
            let model = try await viewModel.uploadIDFAInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                UserDefaults.standard.set("1", forKey: "upload_IDFA_Info")
                UserDefaults.standard.synchronize()
                if let bkModel = model.standee?.stillarian {
                    self.bkcInfo(with: bkModel)
                }
            }
        } catch {
            
        }
    }
    
    private func bkcInfo(with model: stillarianModel) {
        Settings.shared.displayName = model.scelry ?? ""
        Settings.shared.appURLSchemeSuffix = model.dayist ?? ""
        Settings.shared.appID = model.camer ?? ""
        Settings.shared.clientToken = model.oenful ?? ""
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
    
    private func getProvicesInfo() async {
        do {
            let model = try await viewModel.getProvicesInfo()
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                ProvicesModelManager.shared.provicesModel = model.standee?.variousing ?? []
            }
        } catch {
            
        }
    }
    
}

private extension HomeViewController {
    
    private func showSettingsAlert() {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: LStr("Location Services Disabled"),
                message: LStr("Location permission is a necessary requirement for identity verification. It is only used for this verification, and the process cannot continue if it is not enabled. Please go to Settings to authorize it."),
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
