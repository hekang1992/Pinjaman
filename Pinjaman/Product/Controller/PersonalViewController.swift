//
//  PersonalViewController.swift
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

class PersonalViewController: BaseViewController {
    
    var productID: String = ""
    
    var republicanModel: republicanModel?
    
    var mnesteryModel: mnesteryModel?
    
    var modelArray: [individualsterModel] = []
    
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
        tableView.register(OvaViewCell.self, forCellReuseIdentifier: "OvaViewCell")
        tableView.register(CpoViewCell.self, forCellReuseIdentifier: "CpoViewCell")
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
                for model in modelArray {
                    let key = model.taxant ?? ""
                    let value = model.histrieastlike ?? ""
                    parameters[key] = value
                }
                Task {
                    await self.savepersonalInfo(with: parameters)
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.personalInfo()
        }
    }
    
}

extension PersonalViewController {
    
    private func personalInfo() async {
        do {
            let parameters = ["ideaical": productID]
            let model = try await viewModel.personalInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                self.modelArray = model.standee?.individualster ?? []
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    private func savepersonalInfo(with parameters: [String: String]) async {
        do {
            let model = try await viewModel.savepersonalInfo(with: parameters)
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

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let colfy = model.colfy ?? ""
        if colfy == "sceneition" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OvaViewCell", for: indexPath) as! OvaViewCell
            cell.model = model
            cell.textChangeBlock = { title in
                model.windowfication = title
                model.histrieastlike = title
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CpoViewCell", for: indexPath) as! CpoViewCell
            cell.model = model
            cell.tapBlock = { [weak self] in
                guard let self = self else { return }
                self.view.endEditing(true)
                if colfy == "reasonee" {
                    self.tapClickCell(with: cell, model: model)
                }else {
                    
                }
            }
            return cell
        }
        
    }
    
    private func tapClickCell(with cell: CpoViewCell, model: individualsterModel) {
        let popView = PopAutnEnumView(frame: self.view.bounds)
        popView.nameLabel.text = model.asform ?? ""
        let modelArray = model.trachyify ?? []
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
            model.windowfication = listModel.tomoeconomyet ?? ""
            model.histrieastlike = listModel.histrieastlike ?? ""
            cell.oneFiled.text = listModel.tomoeconomyet ?? ""
        }
    }
    
    
}
