//
//  MeCenterView.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

class MeCenterView: BaseView {
    
    // 动态列表数组
    var listArray: [veriidModel]? {
        didSet {
            guard let listArray = listArray else { return }
            setupDynamicListViews(with: listArray)
        }
    }
    
    var leftBlock: (() -> Void)?
    var rightBlock: (() -> Void)?
    var oneBlock: (() -> Void)?
    var twoBlock: (() -> Void)?
    var threeBlock: (() -> Void)?
    var fourBlock: (() -> Void)?
    var listTapClick: ((String) -> Void)?
    
    private var dynamicListViews: [CenterClickListView] = []
    
    // MARK: - Lazy UI Components
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "me_head_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = LStr("Mine")
        nameLabel.textColor = UIColor(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return nameLabel
    }()
    
    lazy var appLabel: UILabel = {
        let appLabel = UILabel()
        appLabel.textAlignment = .center
        appLabel.text = LStr("UangCair")
        appLabel.textColor = UIColor(hexString: "#333333")
        appLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return appLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .center
        let phone = UserManager.shared.getPhone() ?? ""
        phoneLabel.text = PhoneNumberFormatter.format(phone)
        phoneLabel.textColor = UIColor(hexString: "#333333")
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        return phoneLabel
    }()
    
    lazy var oneView: CenterListView = {
        let oneView = CenterListView()
        oneView.oneBtn.setImage(UIImage(named: "c_p_left_image"), for: .normal)
        oneView.oneBtn.setTitle(LStr("Contact us"), for: .normal)
        return oneView
    }()
    
    lazy var twoView: CenterListView = {
        let twoView = CenterListView()
        twoView.oneBtn.setImage(UIImage(named: "c_p_right_image"), for: .normal)
        twoView.oneBtn.setTitle(LStr("Privacy Policy"), for: .normal)
        return twoView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var orderImageView: UIImageView = {
        let orderImageView = UIImageView()
        orderImageView.image = languageCode == .indonesian ? UIImage(named: "c_m_o_e_image") : UIImage(named: "c_m_o_en_image")
        orderImageView.isUserInteractionEnabled = true
        return orderImageView
    }()
    
    lazy var oneBtn: UIButton = UIButton(type: .custom)
    lazy var twoBtn: UIButton = UIButton(type: .custom)
    lazy var threeBtn: UIButton = UIButton(type: .custom)
    lazy var fourBtn: UIButton = UIButton(type: .custom)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStaticHierarchy()
        setupStaticConstraints()
        setupBinding()
    }
    
    private func setupStaticHierarchy() {
        addSubview(bgImageView)
        addSubview(nameLabel)
        bgImageView.addSubview(appLabel)
        bgImageView.addSubview(phoneLabel)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(oneView)
        contentView.addSubview(twoView)
        contentView.addSubview(orderImageView)
        
        orderImageView.addSubview(oneBtn)
        orderImageView.addSubview(twoBtn)
        orderImageView.addSubview(threeBtn)
        orderImageView.addSubview(fourBtn)
    }
    
    private func setupStaticConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 347.pix()))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        appLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(206.pix())
            make.height.equalTo(17)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appLabel.snp.bottom).offset(6.pix())
            make.height.equalTo(17)
        }
        
        scrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(10.pix())
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview() // 保证垂直滚动
        }
        
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.pix())
            make.left.equalToSuperview().offset(16.pix())
            make.size.equalTo(CGSize(width: 168.pix(), height: 60.pix()))
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.top)
            make.right.equalToSuperview().offset(-16.pix())
            make.size.equalTo(CGSize(width: 168.pix(), height: 60.pix()))
        }
        
        orderImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneView.snp.bottom).offset(36.pix())
            make.size.equalTo(CGSize(width: 359.pix(), height: 114.pix()))
        }
        
        // 订单按钮布局
        let btnWidth = 359.pix() / 4
        oneBtn.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(btnWidth)
        }
        twoBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(oneBtn.snp.right)
            make.width.equalTo(btnWidth)
        }
        threeBtn.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(twoBtn.snp.right)
            make.width.equalTo(btnWidth)
        }
        fourBtn.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(threeBtn.snp.right)
        }
    }
    
    private func setupDynamicListViews(with models: [veriidModel]) {
        dynamicListViews.forEach { $0.removeFromSuperview() }
        dynamicListViews.removeAll()
        
        var lastView: UIView = orderImageView
        
        for (index, model) in models.enumerated() {
            let listView = CenterClickListView()
            //            listView.logoImageView.kf.setImage(with: URL(string: model.dreamorium ?? ""))
            listView.nameLabel.text = model.asform ?? ""
            
            
            listView.tapBlock = { [weak self] in
                guard let self = self else { return }
                self.listTapClick?(model.wish ?? "")
            }
            
            contentView.addSubview(listView)
            dynamicListViews.append(listView)
            
            listView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 359.pix(), height: 49.pix()))
                make.top.equalTo(lastView.snp.bottom).offset(index == 0 ? 12.pix() : 12.pix())
                
                if index == models.count - 1 {
                    make.bottom.equalToSuperview().offset(-30.pix())
                }
            }
            lastView = listView
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MeCenterView {
    private func setupBinding() {
        oneView.tapBlock = { [weak self] in self?.leftBlock?() }
        twoView.tapBlock = { [weak self] in self?.rightBlock?() }
        
        let btns = [oneBtn, twoBtn, threeBtn, fourBtn]
        let blocks = [{ self.oneBlock?() }, { self.twoBlock?() }, { self.threeBlock?() }, { self.fourBlock?() }]
        
        for (index, btn) in btns.enumerated() {
            btn.rx.tap
                .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
                .subscribe(onNext: {
                    blocks[index]()
                })
                .disposed(by: disposeBag)
        }
    }
}
class PhoneNumberFormatter {
    static func format(_ phoneNumber: String) -> String {
        guard phoneNumber.count >= 8 else { return phoneNumber }
        
        let startIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
        let endIndex = phoneNumber.index(phoneNumber.endIndex, offsetBy: -4)
        
        guard startIndex < endIndex else {
            let prefix = String(phoneNumber.prefix(3))
            return "\(prefix)***"
        }
        
        var formatted = phoneNumber
        formatted.replaceSubrange(startIndex..<endIndex, with: "***")
        return formatted
    }
}

