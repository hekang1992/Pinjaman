//
//  LoginViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    private var timer: Timer?
    
    private var countdownTime = 60
    
    private let viewModel = LoginViewModel()
    
    private let locationService = LocationService()
    
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
        
        loginView.codeBlock = { [weak self] in
            guard let self = self else { return }
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
            Task {
                await self.loginInfo(with: phone, code: code)
            }
        }
        
        locationService.requestCurrentLocation { locationDict in }
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
