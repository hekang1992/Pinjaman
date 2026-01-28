//
//  PhotoViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import UIKit
import SnapKit

class PhotoViewController: BaseViewController {
    
    var productID: String = ""
    
    var mnesteryModel: mnesteryModel?
    
    var model: BaseModel?
    
    private let viewModel = ProductViewModel()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "he_id_au_image") : UIImage(named: "he_eb_au_image")
        return bgImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
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
    
    lazy var oneListView: PhotoListView = {
        let oneListView = PhotoListView()
        oneListView.descLabel.text = LStr("ID card front photo")
        return oneListView
    }()
    
    lazy var twoListView: PhotoListView = {
        let twoListView = PhotoListView()
        twoListView.descLabel.text = LStr("Face recognition")
        return twoListView
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
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 54.pix()))
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(13.pix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(clickBtn.snp.top).offset(-13.pix())
        }
        
        scrollView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 85.pix()))
        }
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = LStr("Identity verification")
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(18)
            make.left.equalTo(bgImageView)
            make.height.equalTo(17)
        }
        
        scrollView.addSubview(oneListView)
        scrollView.addSubview(twoListView)
        
        oneListView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14.pix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16.pix())
            make.height.equalTo(215.pix())
        }
        
        twoListView.snp.makeConstraints { make in
            make.top.equalTo(oneListView.snp.bottom).offset(20.pix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16.pix())
            make.height.equalTo(215.pix())
            make.bottom.equalToSuperview().offset(-30.pix())
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.photoInfo()
        }
    }
    
}

extension PhotoViewController {
    
    private func photoInfo() async {
        do {
            let parameters = ["ideaical": productID,
                              "salutive": UserManager.shared.getPhone() ?? ""]
            let model = try await viewModel.photoInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                self.model = model
            }
        } catch {
            
        }
    }
    
}
