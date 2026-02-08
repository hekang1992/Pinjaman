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
    
    private lazy var loginView: LoginView = {
        return LoginView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupInitialData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginView.phoneFiled.becomeFirstResponder()
    }
    
    @MainActor
    deinit {
        stopCountdown()
    }
}

private extension LoginViewController {
    
    func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupBindings() {
        loginView.backBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        loginView.sureBlock = { btn in
            btn.isSelected.toggle()
        }
        
        loginView.codeBlock = { [weak self] in
            self?.handleCodeButtonTap()
        }
        
        loginView.loginBlock = { [weak self] in
            self?.handleLoginButtonTap()
        }
        
        loginView.airBlock = { [weak self] in
            self?.handleAirButtonTap()
        }
    }
    
    func setupInitialData() {
        let phone = UserManager.shared.getPhone() ?? ""
        if phone.isEmpty {
            Task {
                await self.getIDFA()
            }
        }
        
        let start = String(Int(Date().timeIntervalSince1970))
        UserDefaults.standard.set(start, forKey: "start")
    }
}

private extension LoginViewController {
    
    func handleCodeButtonTap() {
        saveEndTimestamp()
        let phone = loginView.phoneFiled.text ?? ""
        
        guard !phone.isEmpty else {
            ToastManager.showLocal("Enter your mobile phone number")
            return
        }
        
        Task {
            await codeInfo(with: phone)
        }
    }
    
    func handleLoginButtonTap() {
        saveEndTimestamp()
        let phone = loginView.phoneFiled.text ?? ""
        let code = loginView.codeFiled.text ?? ""
        
        guard validateLoginInput(phone: phone, code: code) else { return }
        
        Task {
            await loginInfo(with: phone, code: code)
        }
    }
    
    func handleAirButtonTap() {
        let pageUrl = h5_base_url + "/startous"
        goContentWebVc(with: pageUrl)
    }
    
    func saveEndTimestamp() {
        let end = String(Int(Date().timeIntervalSince1970))
        UserDefaults.standard.set(end, forKey: "end")
    }
}

private extension LoginViewController {
    
    func validateLoginInput(phone: String, code: String) -> Bool {
        guard !phone.isEmpty else {
            ToastManager.showLocal("Enter your mobile phone number")
            return false
        }
        
        guard !code.isEmpty else {
            ToastManager.showLocal("Verification code")
            return false
        }
        
        guard loginView.sureBtn.isSelected else {
            ToastManager.showLocal("Please read and agree to the privacy agreement")
            return false
        }
        
        return true
    }
}

private extension LoginViewController {
    
    func startCountdown() {
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
    
    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        loginView.codeBtn.isEnabled = true
        loginView.codeBtn.setTitle(LStr("Send code"), for: .normal)
    }
}

private extension LoginViewController {
    
    func codeInfo(with phone: String) async {
        do {
            let model = try await viewModel.codeInfo(with: ["tellard": phone])
            let taxant = model.taxant ?? ""
            
            if ["0", "00"].contains(taxant) {
                await MainActor.run {
                    self.loginView.codeFiled.becomeFirstResponder()
                    self.startCountdown()
                }
            }
            
            ToastManager.showLocal(model.troubleably ?? "")
        } catch {
            print("Code info error: \(error)")
        }
    }
    
    func loginInfo(with phone: String, code: String) async {
        await MainActor.run {
            self.loginView.phoneFiled.resignFirstResponder()
            self.loginView.codeFiled.resignFirstResponder()
        }
        
        do {
            let model = try await viewModel.loginInfo(with: [
                "angumedicalwise": phone,
                "readify": code
            ])
            
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
            print("Login info error: \(error)")
        }
    }
}

private extension LoginViewController {
    
    func getIDFA() async {
        guard #available(iOS 14, *) else { return }
        
        try? await Task.sleep(nanoseconds: 1_200_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized, .denied, .notDetermined:
            await uploadIDFAInfo()
        case .restricted:
            break
        @unknown default:
            break
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
            
            if ["0", "00"].contains(taxant),
               let bkModel = model.standee?.stillarian {
                configureFacebookSDK(with: bkModel)
            }
        } catch {
            print("Upload IDFA error: \(error)")
        }
    }
    
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
