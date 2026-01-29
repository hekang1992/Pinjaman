//
//  OrderViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import SnapKit
import MJRefresh

class OrderViewController: BaseViewController {
    
    private let viewModel = OrderViewModel()
    
    private var selectedButton: UIButton?
    
    var type: String = "4"
    
    var modelArray: [variousingModel] = []
    
    lazy var emptyView: OrderEmptyView = {
        let emptyView = OrderEmptyView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        oneBtn.setTitle(LStr("All"), for: .normal)
        oneBtn.setTitleColor(.white, for: .normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        oneBtn.layer.cornerRadius = 12.pix()
        oneBtn.layer.masksToBounds = true
        oneBtn.backgroundColor = UIColor.init(hexString: "#4CA466")
        oneBtn.tag = 0
        oneBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle(LStr("In progress"), for: .normal)
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        twoBtn.layer.cornerRadius = 12.pix()
        twoBtn.layer.masksToBounds = true
        twoBtn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        twoBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        twoBtn.tag = 1
        twoBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        threeBtn.setTitle(LStr("Repayment"), for: .normal)
        threeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        threeBtn.layer.cornerRadius = 12.pix()
        threeBtn.layer.masksToBounds = true
        threeBtn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        threeBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        threeBtn.tag = 2
        threeBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return threeBtn
    }()
    
    lazy var fourBtn: UIButton = {
        let fourBtn = UIButton(type: .custom)
        fourBtn.setTitle(LStr("Finished"), for: .normal)
        fourBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        fourBtn.layer.cornerRadius = 12.pix()
        fourBtn.layer.masksToBounds = true
        fourBtn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        fourBtn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        fourBtn.tag = 3
        fourBtn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return fourBtn
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        tableView.register(OrderNorViewCell.self, forCellReuseIdentifier: "OrderNorViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headView)
        headView.backBtn.isHidden = true
        headView.nameLabel.text = LStr("Order List")
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(18)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(32.pix())
        }
        
        scrollView.addSubview(oneBtn)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(threeBtn)
        scrollView.addSubview(fourBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 62.pix(), height: 32.pix()))
            make.left.equalToSuperview().offset(16.pix())
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 108.pix(), height: 32.pix()))
            make.left.equalTo(oneBtn.snp.right).offset(6.pix())
        }
        
        threeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 100.pix(), height: 32.pix()))
            make.left.equalTo(twoBtn.snp.right).offset(6.pix())
        }
        
        fourBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 80.pix(), height: 32.pix()))
            make.left.equalTo(threeBtn.snp.right).offset(6.pix())
            make.right.equalToSuperview().offset(-16.pix())
        }
        
        setButtonSelected(oneBtn)
        
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(10.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        emptyView.clickBlock = { [weak self] in
            self?.changeRootVc()
        }
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.orderlistInfo(with: self.type)
            }
        })
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        setButtonSelected(sender)
        
        switch sender.tag {
        case 0:
            Task {
                self.type = "4"
                await self.orderlistInfo(with: type)
            }
            
        case 1:
            Task {
                self.type = "7"
                await self.orderlistInfo(with: type)
            }
            
        case 2:
            Task {
                self.type = "6"
                await self.orderlistInfo(with: type)
            }
            
        case 3:
            Task {
                self.type = "5"
                await self.orderlistInfo(with: type)
            }
            
        default:
            break
        }
    }
    
    private func setButtonSelected(_ button: UIButton) {
        resetAllButtonsToDefault()
        button.backgroundColor = UIColor.init(hexString: "#4CA466")
        button.setTitleColor(.white, for: .normal)
        selectedButton = button
    }
    
    private func resetAllButtonsToDefault() {
        let buttons = [oneBtn, twoBtn, threeBtn, fourBtn]
        
        for btn in buttons {
            btn.backgroundColor = UIColor.init(hexString: "#FFFFFF")
            btn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        }
    }
    
    func selectButton(at index: Int) {
        let buttons = [oneBtn, twoBtn, threeBtn, fourBtn]
        if index >= 0 && index < buttons.count {
            setButtonSelected(buttons[index])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.orderlistInfo(with: type)
        }
    }
}

extension OrderViewController {
    
    private func orderlistInfo(with type: String) async {
        do {
            let parameters = ["leihotelform": type,
                              "pudeauthorityule": String(Int(0 + 1)),
                              "ohoon": String(Int(20 + 30))]
            let model = try await viewModel.getOrderInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let listArray = model.standee?.variousing ?? []
                emptyView.isHidden = !listArray.isEmpty
                tableView.isHidden = listArray.isEmpty
                self.modelArray = listArray
                self.tableView.reloadData()
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        } catch {
            await MainActor.run {
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.modelArray[indexPath.row]
        let applyName = model.requiresure?.equinism ?? ""
        
        if applyName.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderNorViewCell", for: indexPath) as! OrderNorViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model = model
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.identifyally ?? ""
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        }else if pageUrl.hasPrefix("http") {
            self.goContentWebVc(with: pageUrl)
        }
    }
    
}
