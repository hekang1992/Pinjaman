//
//  StartViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import SnapKit
import Alamofire
import IQKeyboardManagerSwift

class StartViewController: BaseViewController {
    
    private let viewModel = StartViewModel()
    
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
        
        NetworkMonitor.shared.startListening { status in
            switch status {
            case .unknown:
                print("unknown======")
                
            case .notReachable:
                print("notReachable======")
                
            case .reachableViaWiFi, .reachableViaCellular:
                NetworkMonitor.shared.stopListening()
                Task {
                    await self.getInitInfo()
                }
            }
        }
        
    }
    
}

extension StartViewController {
    
    private func getInitInfo() async {
        do {
            let model = try await viewModel.getInitInfo()
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let languageCode = model.standee?.horm ?? ""
                LanguageManager.shared.configure(with: languageCode)
                try? await Task.sleep(nanoseconds: 250_000_000)
                await MainActor.run {
                    self.changeRootVc()
                }
            }
        } catch {
            
        }
    }
    
}
