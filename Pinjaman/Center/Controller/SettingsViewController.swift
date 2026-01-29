//
//  SettingsViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import TYAlertController
import RxSwift
import RxCocoa

class SettingsViewController: BaseViewController {
    
    private let viewModel = CenterViewModel()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "launch_logo_image")
        return logoImageView
    }()
    
    lazy var footImageView: UIImageView = {
        let footImageView = UIImageView()
        footImageView.image = UIImage(named: "en_out_a_image")
        return footImageView
    }()
    
    lazy var outView: CenterClickListView = {
        let outView = CenterClickListView()
        outView.nameLabel.text = LStr("Log out of the account")
        return outView
    }()
    
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.setTitle(LStr("Cancel account"), for: .normal)
        deleteBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return deleteBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hexString: "#252D43")
        return lineView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.nameLabel.text = LStr("Settings")
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headView.snp.bottom).offset(40)
            make.width.height.equalTo(112)
        }
        
        view.addSubview(outView)
        outView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 49.pix()))
        }
        
        if languageCode == .english {
            
            view.addSubview(deleteBtn)
            deleteBtn.addSubview(lineView)
            
            deleteBtn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(outView.snp.bottom).offset(11.pix())
                make.height.equalTo(17)
            }
            lineView.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.left.right.bottom.equalTo(deleteBtn)
            }
            
            view.addSubview(footImageView)
            footImageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
                make.size.equalTo(CGSize(width: 343.pix(), height: 98.pix()))
            }
        }
        
        outView.tapBlock = { [weak self] in
            self?.popExitAccount()
        }
        
        deleteBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.popDeleteAccount()
            })
            .disposed(by: disposeBag)
        
    }
    
}

extension SettingsViewController {
    
    private func popExitAccount() {
        let popView = AccountExitView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.confirmAction
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        popView.cancelAction
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.exitInfo()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func popDeleteAccount() {
        
        let popView = AccountDeleteView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.oneBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.twoBlock = { [weak self] in
            guard let self = self else { return }
            if popView.sureBtn.isSelected == false {
                ToastManager.showLocal("Please confirm the above agreement first.")
                return
            }
            Task {
                await self.deleteInfo()
            }
        }
        
    }
    
}

extension SettingsViewController {
    
    private func exitInfo() async {
        do {
            let model = try await viewModel.accountExitInfo()
            let taxant = model.taxant ?? ""
            ToastManager.showLocal(model.troubleably ?? "")
            if ["0", "00"].contains(taxant) {
                self.dismiss(animated: true)
                UserManager.shared.clearUserInfo()
                try? await Task.sleep(nanoseconds: 500_000_000)
                await MainActor.run {
                    self.changeRootVc()
                }
            }
        } catch {
            
        }
    }
    
    private func deleteInfo() async {
        do {
            let model = try await viewModel.accountDeleteInfo()
            let taxant = model.taxant ?? ""
            ToastManager.showLocal(model.troubleably ?? "")
            if ["0", "00"].contains(taxant) {
                self.dismiss(animated: true)
                UserManager.shared.clearUserInfo()
                try? await Task.sleep(nanoseconds: 500_000_000)
                await MainActor.run {
                    self.changeRootVc()
                }
            }
        } catch {
            
        }
    }
    
}
