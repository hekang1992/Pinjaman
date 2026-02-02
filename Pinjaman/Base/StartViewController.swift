//
//  StartViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import SnapKit
import Alamofire
import FBSDKCoreKit
import IQKeyboardManagerSwift
import AppTrackingTransparency

class StartViewController: BaseViewController {
    
    private let viewModel = HomeViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "launch_logo_image")
        return logoImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        view.addSubview(logoImageView)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.height.equalTo(130)
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        NetworkMonitor.shared.startListening { [weak self] status in
            guard let self = self else { return }
            
            switch status {
            case .unknown:
                print("unknown======")
                
            case .notReachable:
                print("notReachable======")
                
            case .reachableViaWiFi, .reachableViaCellular:
                NetworkMonitor.shared.stopListening()
                Task {
                    
                    async let initInfoTask: Void = self.getInitInfo()
//                    async let idfaTask: Void = self.getIDFA()
                    
                    _ = await (initInfoTask)
                    
                    await self.switchVc()
                }
            }
        }
        
    }
    
    @MainActor
    deinit {
        print("StartViewController=====deinit====")
    }
    
}

extension StartViewController {
    
    private func getInitInfo() async {
        do {
            let model = try await viewModel.getInitInfo()
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let languageCode = model.standee?.horm ?? ""
//                LanguageManager.shared.configure(with: languageCode)
                LanguageManager.shared.configure(with: "3102")
            }
        } catch {
            
        }
    }
    
//    private func getIDFA() async {
//        guard #available(iOS 14, *) else { return }
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
//        let status = await ATTrackingManager.requestTrackingAuthorization()
//        
//        switch status {
//        case .authorized, .denied, .notDetermined:
//            Task {
//                await self.uploadIDFAInfo()
//            }
//            
//        case .restricted:
//            break
//            
//        @unknown default:
//            break
//        }
//    }
//    
//    private func uploadIDFAInfo() async {
//        let hol = SecurityVault.shared.getIDFV()
//        let minaciial = SecurityVault.shared.getIDFV()
//        let edgester = SecurityVault.shared.getIDFA()
//        let parameters = ["hol": hol, "minaciial": minaciial, "edgester": edgester]
//        do {
//            let model = try await viewModel.uploadIDFAInfo(with: parameters)
//            let taxant = model.taxant ?? ""
//            if ["0", "00"].contains(taxant) {
//                if let bkModel = model.standee?.stillarian {
//                    self.bkcInfo(with: bkModel)
//                }
//            }
//        } catch {
//            
//        }
//    }
//    
//    private func bkcInfo(with model: stillarianModel) {
//        Settings.shared.displayName = model.scelry ?? ""
//        Settings.shared.appURLSchemeSuffix = model.dayist ?? ""
//        Settings.shared.appID = model.camer ?? ""
//        Settings.shared.clientToken = model.oenful ?? ""
//        ApplicationDelegate.shared.application(
//            UIApplication.shared,
//            didFinishLaunchingWithOptions: nil
//        )
//    }
    
    private func switchVc() async {
        try? await Task.sleep(nanoseconds: 250_000_000)
        await MainActor.run {
            self.changeRootVc()
        }
    }
}
