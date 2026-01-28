//
//  PhonesViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
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
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "he_id_au_image") : UIImage(named: "he_eb_au_image")
        return bgImageView
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
            self.toProductDetailVc()
        }
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 85.pix()))
        }
        
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
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                var parameters = ["ideaical": productID]
                
                
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
        do {
            let model = try await viewModel.savephonesInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                Task {
                    await self.productdetilInfo(with: productID, viewModel: viewModel)
                }
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
        } catch {
            
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
                guard let contact = contact else { return }
                print("选择了：\(contact.tomoeconomyet), 电话：\(contact.tellard)")
            }
            ContactManager.shared.fetchAllContacts { contacts in
                if let data = try? JSONEncoder().encode(contacts),
                   let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
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
