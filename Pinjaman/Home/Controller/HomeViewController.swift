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
    
    // MARK: - Properties
    private let viewModel = HomeViewModel()
    private let productViewModel = ProductViewModel()
    private let locationService = LocationService()
    
    private lazy var oneView: OneHomeView = {
        let view = OneHomeView()
        view.backgroundColor = UIColor(hexString: "#ECEEF0")
        view.isHidden = true
        return view
    }()
    
    private lazy var twoView: TwoHomeView = {
        let view = TwoHomeView()
        view.backgroundColor = UIColor(hexString: "#ECEEF0")
        view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupActions()
        setupRefresh()
        setupInitialData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await getHomeInfo() }
    }
}

// MARK: - Setup
private extension HomeViewController {
    
    func setupViews() {
        view.addSubview(oneView)
        oneView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        view.addSubview(twoView)
        twoView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setupActions() {
        setupOneViewActions()
        setupTwoViewActions()
    }
    
    func setupOneViewActions() {
        oneView.loanBlock = { [weak self] in
            self?.handleLoanAction()
        }
        
        oneView.descBlock = { [weak self] in
            self?.handleDescAction()
        }
        
        oneView.applyBlock = { [weak self] model in
            self?.handleProductApplyAction(model)
        }
    }
    
    func setupTwoViewActions() {
        twoView.tapCellBlock = { [weak self] model in
            self?.handleProductCellTapAction(model)
        }
        
        twoView.tapBanBlock = { [weak self] model in
            self?.handleBannerTapAction(model)
        }
    }
    
    func setupRefresh() {
        oneView.scrollView.mj_header = MJRefreshNormalHeader { [weak self] in
            Task { await self?.getHomeInfo() }
        }
        
        twoView.tableView.mj_header = MJRefreshNormalHeader { [weak self] in
            Task { await self?.getHomeInfo() }
        }
    }
    
    func setupInitialData() {
        locationService.requestCurrentLocation { _ in }
        
        let type = UserDefaults.standard.object(forKey: "upload_IDFA_Info") as? String ?? ""
        if type != "1" {
            Task { await self.uploadIDFAInfo() }
        }
        
        Task { await self.getProvicesInfo() }
    }
}

// MARK: - Action Handlers
private extension HomeViewController {
    
    func handleLoanAction() {
        guard UserManager.shared.isLogin else {
            presentLogin()
            return
        }
        let pageUrl = h5_base_url + "/forery"
        goContentWebVc(with: pageUrl)
    }
    
    func handleDescAction() {
        let descVc = DescLaonViewController()
        navigationController?.pushViewController(descVc, animated: true)
    }
    
    func handleProductApplyAction(_ model: misceeerModel) {
        guard UserManager.shared.isLogin else {
            presentLogin()
            return
        }
        
        guard validateLocationPermission() else { return }
        
        let productID = String(model.allosion ?? 0)
        executeProductFlow(for: productID)
    }
    
    func handleProductCellTapAction(_ model: misceeerModel) {
        guard UserManager.shared.isLogin else {
            presentLogin()
            return
        }
        
        guard validateLocationPermission() else { return }
        
        let productID = String(model.allosion ?? 0)
        executeProductFlow(for: productID)
    }
    
    func handleBannerTapAction(_ model: misceeerModel) {
        let pageUrl = model.howeveracy ?? ""
        clickPageInfo(with: pageUrl)
    }
    
    func executeProductFlow(for productID: String) {
        // 串行执行，避免并发问题
        Task {
            await clickProductInfo(with: productID)
            await uploadAppInfo()
            await uploadSessionData()
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

// MARK: - Validation
private extension HomeViewController {
    
    func validateLocationPermission() -> Bool {
        let status = CLLocationManager().authorizationStatus
        
        guard LanguageManager.shared.currentType == .indonesian else {
            return true
        }
        
        guard status != .restricted && status != .denied else {
            showSettingsAlert()
            return false
        }
        
        return true
    }
}

// MARK: - API Calls
private extension HomeViewController {
    
    func getHomeInfo() async {
        defer {
            DispatchQueue.main.async {
                self.oneView.scrollView.mj_header?.endRefreshing()
                self.twoView.tableView.mj_header?.endRefreshing()
            }
        }
        
        do {
            let model = try await viewModel.getHomeInfo()
            DispatchQueue.main.async {
                self.handleHomeInfo(model)
            }
        } catch {
            // Handle error appropriately
            print("Get home info error: \(error)")
        }
    }
    
    func handleHomeInfo(_ model: BaseModel) {
        let taxant = model.taxant ?? ""
        guard ["0", "00"].contains(taxant) else {
            ToastManager.showLocal(model.troubleably ?? "")
            return
        }
        
        let list = model.standee?.variousing ?? []
        
        // Handle "horm" type (oneView)
        if let oneModel = list.first(where: { $0.histrieastlike == "horm" }) {
            oneView.listModel = oneModel
            oneView.isHidden = false
            twoView.isHidden = true
            return
        }
        
        // Handle "brom" type (twoView)
        if list.contains(where: { $0.histrieastlike == "brom" }) {
            let modelArray = list
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
            DispatchQueue.main.async {
                self.handleProductInfo(model)
            }
        } catch {
            // Handle error appropriately
            print("Click product info error: \(error)")
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
    
    func uploadSessionData() async {
        let start = UserDefaults.standard.object(forKey: "start") as? String ?? ""
        let end = UserDefaults.standard.object(forKey: "end") as? String ?? ""
        
        guard !start.isEmpty && !end.isEmpty else { return }
        
        do {
            // 根据你的实际方法签名调整
            // 这里假设 suddenlyalBeaconingInfo 返回 Void
            try await suddenlyalBeaconingInfo(
                productID: "",
                type: "1",
                orderID: "",
                start: start,
                end: end
            )
        } catch {
            // Handle error appropriately
            print("Upload session data error: \(error)")
        }
    }
}

// MARK: - App Information Upload
private extension HomeViewController {
    
    func uploadAppInfo() async {
        // 改为顺序执行，避免并发问题
        await uploadLocationInfo()
        await uploadMacInfo()
    }
    
    func uploadLocationInfo() async {
        await withCheckedContinuation { continuation in
            locationService.requestCurrentLocation { [weak self] locationDict in
                guard let self = self else {
                    continuation.resume()
                    return
                }
                
                Task {
                    do {
                        let _ = try await self.viewModel.uploadLocationInfo(with: locationDict ?? [:])
                    } catch {
                        // Handle error appropriately
                        print("Upload location info error: \(error)")
                    }
                    continuation.resume()
                }
            }
        }
    }
    
    func uploadMacInfo() async {
        await withCheckedContinuation { continuation in
            DeviceCollector.collect { [weak self] dict in
                guard let self = self else {
                    continuation.resume()
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
                    let base64String = jsonData.base64EncodedString()
                    let parameters = ["standee": base64String]
                    
                    Task {
                        do {
                            let _ = try await self.viewModel.uploadMacInfo(with: parameters)
                        } catch {
                            // Handle error appropriately
                            print("Upload mac info error: \(error)")
                        }
                        continuation.resume()
                    }
                } catch {
                    print("Device collection serialization error: \(error)")
                    continuation.resume()
                }
            }
        }
    }
    
    func uploadIDFAInfo() async {
        let parameters = [
            "hol": SecurityVault.shared.getIDFV(),
            "minaciial": SecurityVault.shared.getIDFV(),
            "edgester": SecurityVault.shared.getIDFA()
        ]
        
        do {
            let model = try await viewModel.uploadIDFAInfo(with: parameters)
            let taxant = model.taxant ?? ""
            
            if ["0", "00"].contains(taxant) {
                UserDefaults.standard.set("1", forKey: "upload_IDFA_Info")
                
                if let bkModel = model.standee?.stillarian {
                    configureFacebookSDK(with: bkModel)
                }
            }
        } catch {
            // Handle error appropriately
            print("Upload IDFA info error: \(error)")
        }
    }
    
    func getProvicesInfo() async {
        do {
            let model = try await viewModel.getProvicesInfo()
            let taxant = model.taxant ?? ""
            
            if ["0", "00"].contains(taxant) {
                DispatchQueue.main.async {
                    ProvicesModelManager.shared.provicesModel = model.standee?.variousing ?? []
                }
            }
        } catch {
            // Handle error appropriately
            print("Get provinces info error: \(error)")
        }
    }
}

// MARK: - Configuration
private extension HomeViewController {
    
    func configureFacebookSDK(with model: stillarianModel) {
        Settings.shared.displayName = model.scelry ?? ""
        Settings.shared.appURLSchemeSuffix = model.dayist ?? ""
        Settings.shared.appID = model.camer ?? ""
        Settings.shared.clientToken = model.oenful ?? ""
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
    }
}

// MARK: - Navigation
private extension HomeViewController {
    
    func showSettingsAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: LStr("Location Services Disabled"),
                message: LStr("Location permission is a necessary requirement for identity verification. It is only used for this verification, and the process cannot continue if it is not enabled. Please go to Settings to authorize it."),
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: LStr("Cancel"), style: .cancel)
            alert.addAction(cancelAction)
            
            let settingsAction = UIAlertAction(title: LStr("Settings"), style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            alert.addAction(settingsAction)
            
            self.present(alert, animated: true)
        }
    }
    
    func clickPageInfo(with pageUrl: String) {
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        } else if pageUrl.hasPrefix("http") {
            goContentWebVc(with: pageUrl)
        }
    }
    
    // 添加缺少的方法
    func suddenlyalBeaconingInfo(productID: String, type: String, orderID: String, start: String, end: String) async throws {
        // 这里需要根据你的实际实现来补充
        // 假设这是一个网络请求
        let parameters: [String: Any] = [
            "productID": productID,
            "type": type,
            "orderID": orderID,
            "start": start,
            "end": end
        ]
        
        // 示例：调用 productViewModel 的方法
        // 需要根据你的实际代码调整
        // let _ = try await productViewModel.someMethod(with: parameters)
        
        // 临时实现，防止编译错误
        print("Uploading beacon info: \(parameters)")
    }
}
