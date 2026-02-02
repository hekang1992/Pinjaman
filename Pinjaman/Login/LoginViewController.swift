//
//  LoginViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import SnapKit
import FBSDKCoreKit
import AppTrackingTransparency

class LoginViewController: BaseViewController {
    
    private var timer: Timer?
    
    private var countdownTime = 60
    
    private let viewModel = LoginViewModel()
    
//    private let locationService = LocationService()
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        loginView.sureBlock = { btn in
            btn.isSelected.toggle()
        }
        
        loginView.codeBlock = { [weak self] in
            guard let self = self else { return }
            let end = String(Int(Date().timeIntervalSince1970))
            UserDefaults.standard.set(end, forKey: "end")
            let phone = loginView.phoneFiled.text ?? ""
            if phone.isEmpty {
                ToastManager.showLocal("Enter your mobile phone number")
                return
            }
            Task {
                await self.codeInfo(with: phone)
            }
        }
        
        loginView.loginBlock = { [weak self] in
            guard let self = self else { return }
            let end = String(Int(Date().timeIntervalSince1970))
            UserDefaults.standard.set(end, forKey: "end")
            let phone = loginView.phoneFiled.text ?? ""
            let code = loginView.codeFiled.text ?? ""
            if phone.isEmpty {
                ToastManager.showLocal("Enter your mobile phone number")
                return
            }
            if code.isEmpty {
                ToastManager.showLocal("Verification code")
                return
            }
            if self.loginView.sureBtn.isSelected == false {
                ToastManager.showLocal("Please read and agree to the privacy agreement")
                return
            }
            Task {
                await self.loginInfo(with: phone, code: code)
            }
        }
        
        loginView.airBlock = { [weak self] in
            guard let self = self else { return }
            let pageUrl = h5_base_url + "/startous"
            self.goContentWebVc(with: pageUrl)
        }
        
//        locationService.requestCurrentLocation { locationDict in }
        
        Task {
            await self.getIDFA()
        }
        
        let start = String(Int(Date().timeIntervalSince1970))
        UserDefaults.standard.set(start, forKey: "start")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneFiled.becomeFirstResponder()
    }
    
    @MainActor
    deinit {
        stopCountdown()
    }
}

extension LoginViewController {
    
    private func startCountdown() {
        stopCountdown()
        
        countdownTime = 60
        loginView.codeBtn.isEnabled = false
        
        loginView.codeBtn.setTitle("\(countdownTime)s", for: .disabled)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.countdownTime -= 1
            
            if self.countdownTime <= 0 {
                self.stopCountdown()
            } else {
                self.loginView.codeBtn.setTitle("\(self.countdownTime)s", for: .disabled)
            }
        }
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
        loginView.codeBtn.isEnabled = true
        loginView.codeBtn.setTitle(LStr("Send code"), for: .normal)
    }
    
}

extension LoginViewController {
    
    private func codeInfo(with phone: String) async {
        do {
            let model = try await viewModel.codeInfo(with: ["tellard": phone])
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                self.loginView.codeFiled.becomeFirstResponder()
                self.startCountdown()
            }
            ToastManager.showLocal(model.troubleably ?? "")
        } catch {
            
        }
    }
    
    private func loginInfo(with phone: String, code: String) async {
        await MainActor.run {
            self.loginView.phoneFiled.resignFirstResponder()
            self.loginView.codeFiled.resignFirstResponder()
        }
        
        do {
            let model = try await viewModel.loginInfo(with: ["angumedicalwise": phone, "readify": code])
            
            let taxant = model.taxant ?? ""
            
            await MainActor.run {
                ToastManager.showLocal(model.troubleably ?? "")
            }
            
            if ["0", "00"].contains(taxant) {
                
                let phone = model.standee?.angumedicalwise ?? ""
                let token = model.standee?.anaorderade ?? ""
                
                UserManager.shared.saveUserInfo(phone: phone, token: token)
                
                try? await Task.sleep(nanoseconds: 500_000_000)
                await MainActor.run {
                    self.changeRootVc()
                }
            }
        } catch {
            
        }
    }
    
}

extension LoginViewController {
    
    private func getIDFA() async {
        guard #available(iOS 14, *) else { return }
        try? await Task.sleep(nanoseconds: 1_200_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized, .denied, .notDetermined:
            Task {
                await self.uploadIDFAInfo()
            }
            
        case .restricted:
            break
            
        @unknown default:
            break
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
    
}
