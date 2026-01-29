//
//  OneHomeView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class OneHomeView: BaseView {
    
    var listModel: variousingModel? {
        didSet {
            guard let listModel = listModel, let model = listModel.misceeer?.first else { return }
            nameLabel.text = model.wideious ?? ""
            logoImageView.kf.setImage(with: URL(string: model.spicly ?? ""))
            
            limitLabel.text = model.nuchine ?? ""
            numLabel.text = model.megfinishern ?? ""
            
            oneRateView.oneLabel.text = model.gentture ?? ""
            oneRateView.twoLabel.text = model.pinndataad ?? ""
            
            twoRateView.oneLabel.text = model.butly ?? ""
            twoRateView.twoLabel.text = model.morning ?? ""
            
            applyLabel.text = model.powerability ?? ""
        }
    }
    
    var applyBlock: ((misceeerModel) -> Void)?
    
    var loanBlock: (() -> Void)?
    
    private lazy var bgImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "one_home_head_image")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = .clear
        return sv
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var oneImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: languageCode == .indonesian ? "eqn_head_desc_image" : "en_head_desc_image")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = LStr("Interest is transparent, and the borrowing is clear.")
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var twoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home_rate_image")
        return iv
    }()
    
    private lazy var threeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "en_rac_image")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var fourImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: languageCode == .indonesian ? "id_foot_home_image" : "en_foot_home_image")
        return iv
    }()
    
    lazy var oneRateView: HomRateView = {
        let oneRateView = HomRateView()
        return oneRateView
    }()
    
    lazy var twoRateView: HomRateView = {
        let twoRateView = HomRateView()
        return twoRateView
    }()
    
    private lazy var fiveImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "en_quc_home_image")
        return iv
    }()
    
    private lazy var sixImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "en_fin_home_image")
        return iv
    }()
    
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return nameLabel
    }()
    
    lazy var limitLabel: UILabel = {
        let limitLabel = UILabel()
        limitLabel.textAlignment = .center
        limitLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        limitLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return limitLabel
    }()
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textAlignment = .center
        numLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        numLabel.font = UIFont.systemFont(ofSize: 47, weight: .bold)
        return numLabel
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel()
        applyLabel.textAlignment = .center
        applyLabel.backgroundColor = UIColor.init(hexString: "#4CA466")
        applyLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        applyLabel.layer.cornerRadius = 12
        applyLabel.layer.masksToBounds = true
        applyLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return applyLabel
    }()
    
    lazy var loanLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        let fullText = LStr("Please review the <loan terms> before applying.")
        let part2 = LStr("<loan terms>")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: fullText, attributes: [
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor(hexString: "#333333"),
            .paragraphStyle: paragraphStyle
        ])
        
        let range = (fullText as NSString).range(of: part2)
        attributedString.addAttributes([
            .foregroundColor: UIColor.init(hexString: "#4CA466"),
            .font: UIFont.boldSystemFont(ofSize: 13)
        ], range: range)
        
        label.attributedText = attributedString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        return applyBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(bgImageView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(oneImageView)
        contentView.addSubview(descLabel)
        contentView.addSubview(twoImageView)
        twoImageView.addSubview(nameLabel)
        twoImageView.addSubview(logoImageView)
        twoImageView.addSubview(limitLabel)
        twoImageView.addSubview(numLabel)
        contentView.addSubview(threeImageView)
        threeImageView.addSubview(oneRateView)
        threeImageView.addSubview(twoRateView)
        threeImageView.addSubview(applyLabel)
        threeImageView.addSubview(loanLabel)
        contentView.addSubview(fourImageView)
        contentView.addSubview(applyBtn)
        
        if languageCode == .english {
            contentView.addSubview(fiveImageView)
            contentView.addSubview(sixImageView)
        }
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(399.pix())
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 63.pix()))
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(29)
            make.centerX.equalToSuperview()
            make.height.equalTo(15)
        }
        
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 347, height: 225))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(17)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(nameLabel.snp.left).offset(-5)
            make.width.height.equalTo(28)
        }
        
        limitLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(14)
            make.height.equalTo(19)
        }
        
        numLabel.snp.makeConstraints { make in
            make.top.equalTo(limitLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        threeImageView.snp.makeConstraints { make in
            make.top.equalTo(twoImageView.snp.top).offset(195)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 189))
        }
        
        oneRateView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        twoRateView.snp.makeConstraints { make in
            make.top.equalTo(oneRateView.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        applyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoRateView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 311, height: 50))
        }
        
        loanLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(applyLabel.snp.bottom).offset(12)
            make.height.equalTo(16)
        }
        
        applyBtn.snp.makeConstraints { make in
            make.top.equalTo(twoImageView)
            make.bottom.equalTo(threeImageView).offset(-52.pix())
            make.centerX.equalToSuperview()
            make.width.equalTo(335.pix())
        }
        
        fourImageView.snp.makeConstraints { make in
            make.top.equalTo(threeImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343, height: 146))
            
            if languageCode == .indonesian {
                make.bottom.equalToSuperview().offset(-80)
            }
        }
        
        if languageCode == .english {
            fiveImageView.snp.makeConstraints { make in
                make.top.equalTo(fourImageView.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343, height: 133))
            }
            
            sixImageView.snp.makeConstraints { make in
                make.top.equalTo(fiveImageView.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343, height: 98))
                make.bottom.equalToSuperview().offset(-20)
            }
        }
        
        applyBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if let model = listModel?.misceeer?.first {
                    self.applyBlock?(model)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension OneHomeView {
    
    @objc private func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        self.loanBlock?()
    }
    
}
