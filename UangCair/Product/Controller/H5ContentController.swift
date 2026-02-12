//
//  H5ContentController.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import WebKit
import StoreKit
import RxSwift
import RxCocoa

class H5ContentController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let locationService = LocationService()
    
    private let viewModel = ProductViewModel()
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let userContent = WKUserContentController()
        
        let nativeMethods = ["psammaneity", "ethmownule", "plosaneous", "petfier", "nominiaudienceency", "acerb"]
        nativeMethods.forEach { userContent.add(self, name: $0) }
        
        config.userContentController = userContent
        let web = WKWebView(frame: .zero, configuration: config)
        return web
    }()
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.trackTintColor = .clear
        progress.progressTintColor = UIColor.init(hexString: "#222A40")
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadUrl()
    }
    
    private func setupUI() {
        view.addSubview(headView)
        view.addSubview(webView)
        view.addSubview(progressView)
        
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toOrderListVc()
        }
    }
    
    private func setupBindings() {
        webView.rx.observe(String.self, "title")
            .subscribe(onNext: { [weak self] title in
                if let title = title, !title.isEmpty {
                    self?.headView.nameLabel.text = title
                }
            })
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .map { Float($0 ?? 0) }
            .subscribe(onNext: { [weak self] progress in
                self?.progressView.alpha = 1.0
                self?.progressView.setProgress(progress, animated: true)
                
                if progress >= 1.0 {
                    UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut) {
                        self?.progressView.alpha = 0
                    } completion: { _ in
                        self?.progressView.setProgress(0, animated: false)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func loadUrl() {
        let contentUrl = pageUrl.appendingQueryParameters(DeviceProfile.assembleAuditParams())
        print("contentUrl=======\(contentUrl)")
        guard let url = URL(string: contentUrl) else { return }
        webView.load(URLRequest(url: url))
    }
}

extension H5ContentController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "psammaneity":
            self.requestLocationInfo(message: message)
            
        case "ethmownule":
            self.handleNavigation(message: message)
            
        case "plosaneous":
            self.navigationController?.popViewController(animated: true)
            
        case "petfier":
            self.changeRootVc()
            
        case "nominiaudienceency":
            self.goEmail(message: message)
            
        case "acerb":
            self.toAppStore()
            
        default:
            break
        }
    }
}

extension H5ContentController {
    
    private func requestLocationInfo(message: WKScriptMessage) {
        locationService.requestCurrentLocation { locationDict in }
        let body = message.body as? [String] ?? []
        let productID = body.first ?? ""
        let orderID = body.last ?? ""
        let start = String(Int(Date().timeIntervalSince1970))
        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            await self.suddenlyalBeaconingInfo(with: viewModel,
                                               productID: productID,
                                               type: "9",
                                               orderID: orderID,
                                               start: start,
                                               end: start)
        }
    }
    
    private func handleNavigation(message: WKScriptMessage) {
        guard let pageUrl = message.body as? String, !pageUrl.isEmpty else {
            return
        }
        
        if pageUrl.hasPrefix(scheme_url) {
            DeepLinkNavigator.navigate(to: pageUrl, from: self)
        } else if pageUrl.hasPrefix("http") {
            self.pageUrl = pageUrl
            self.loadUrl()
        }
    }
    
    private func goEmail(message: WKScriptMessage) {
        guard let email = message.body as? String, !email.isEmpty else {
            return
        }
        
        let phone = UserManager.shared.getPhone() ?? ""
        let body = "Uang Cair: \(phone)"
        
        guard let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let emailURL = URL(string: "mailto:\(email)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(emailURL) else {
            return
        }
        
        UIApplication.shared.open(emailURL)
    }
    
    func toAppStore() {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
}

extension H5ContentController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
}
