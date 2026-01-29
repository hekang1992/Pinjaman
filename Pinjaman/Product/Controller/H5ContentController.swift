//
//  H5ContentController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/29.
//

import UIKit
import SnapKit
import WebKit
import RxSwift
import RxCocoa

class H5ContentController: BaseViewController {
    
    var pageUrl: String = ""
    
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
        progress.progressTintColor = .systemBlue
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
        print("JS 调用了原生方法: \(message.name), 参数: \(message.body)")
        switch message.name {
        case "psammaneity":
            // H5调用方法1
            break
        case "ethmownule":
            // H5调用方法2
            break
        case "plosaneous":
            // H5调用方法3
            break
        case "petfier":
            // H5调用方法4
            break
        case "nominiaudienceency":
            // H5调用方法5
            break
        case "acerb":
            // H5调用方法6
            break
        default:
            break
        }
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
