//
//  LoginView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginView: BaseView {
    
    var backBlock: (() -> Void)?
    
    var codeBlock: (() -> Void)?
    
    var loginBlock: (() -> Void)?
    
    var sureBlock: ((UIButton) -> Void)?
    
    var airBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "back_btn_image"), for: .normal)
        backBtn.isHidden = true
        return backBtn
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = languageCode == .indonesian ? UIImage(named: "login_head_id_image") : UIImage(named: "login_head_en_image")
        return headImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.text = LStr("Login mobile number (+91)")
        phoneLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        phoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return phoneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 16
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return oneView
    }()
    
    lazy var phoneFiled: UITextField = {
        let phoneFiled = UITextField()
        phoneFiled.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LStr("Enter your mobile phone number"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#999999") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ])
        phoneFiled.attributedPlaceholder = attrString
        phoneFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        phoneFiled.textColor = UIColor.init(hexString: "#333333")
        phoneFiled.text = UserManager.shared.getPhone() ?? ""
        return phoneFiled
    }()
    
    lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.textAlignment = .left
        codeLabel.text = LStr("Verification code")
        codeLabel.textColor = UIColor.init(hexString: "#FFFFFF")
        codeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return codeLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 16
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return twoView
    }()
    
    lazy var codeFiled: UITextField = {
        let codeFiled = UITextField()
        codeFiled.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: LStr("Verification code"), attributes: [
            .foregroundColor: UIColor.init(hexString: "#999999") as Any,
            .font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ])
        codeFiled.attributedPlaceholder = attrString
        codeFiled.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        codeFiled.textColor = UIColor.init(hexString: "#333333")
        return codeFiled
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle(LStr("Send code"), for: .normal)
        codeBtn.setTitleColor(UIColor.init(hexString: "#252D43"), for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return codeBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hexString: "#252D43")
        return lineView
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setImage(languageCode == .indonesian ? UIImage(named: "login_id_image") : UIImage(named: "login_en_image") , for: .normal)
        return loginBtn
    }()
    
    lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        let part1 = LStr("Thank you for choosing us.Continuing with the operation means that you have confirmed the")
        let part2 = LStr(" privacy policy.")
        let fullText = "\(part1)\(part2)"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: fullText, attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hexString: "#FFFFFF").withAlphaComponent(0.6),
            .paragraphStyle: paragraphStyle
        ])
        
        let range = (fullText as NSString).range(of: part2)
        attributedString.addAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 12)
        ], range: range)
        
        label.attributedText = attributedString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.isSelected = true
        sureBtn.setImage(UIImage(named: "login_nor_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "login_sel_image"), for: .selected)
        return sureBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(backBtn)
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(phoneLabel)
        scrollView.addSubview(oneView)
        oneView.addSubview(phoneFiled)
        
        scrollView.addSubview(codeLabel)
        scrollView.addSubview(twoView)
        twoView.addSubview(codeFiled)
        twoView.addSubview(codeBtn)
        twoView.addSubview(lineView)
        
        scrollView.addSubview(loginBtn)
        
        scrollView.addSubview(privacyLabel)
        scrollView.addSubview(sureBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(25)
            make.left.equalToSuperview().offset(16)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview()
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            if languageCode == .indonesian {
                make.size.equalTo(CGSize(width: 332, height: 67))
            }else {
                make.size.equalTo(CGSize(width: 297, height: 48))
            }
            
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(38)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(20)
        }
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.height.equalTo(54)
        }
        phoneFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(17)
            make.height.equalTo(20)
        }
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(codeLabel.snp.bottom).offset(8)
            make.height.equalTo(54)
        }
        codeFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(150)
        }
        codeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.bottom.equalTo(codeBtn)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311, height: 54))
            make.top.equalTo(twoView.snp.bottom).offset(20)
        }
        
        privacyLabel.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(15)
            make.centerX.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 300, height: 51))
            make.bottom.equalToSuperview().offset(-50)
        }
        
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(privacyLabel).offset(5)
            make.right.equalTo(privacyLabel.snp.left)
            make.width.height.equalTo(15)
        }
        
        backBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.backBlock?()
            })
            .disposed(by: disposeBag)
        
        sureBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.sureBlock?(self?.sureBtn ?? UIButton())
            })
            .disposed(by: disposeBag)
        
        codeBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.codeBlock?()
            })
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.loginBlock?()
            })
            .disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    @objc private func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        self.airBlock?()
    }
    
}
