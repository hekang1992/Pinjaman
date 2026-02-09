//
//  BaseViewController.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import RxSwift
import RxCocoa
import TYAlertController

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()
    let languageCode = LanguageManager.shared.currentType

    private var starteight: String = ""

    lazy var headView: AppHeadView = {
        let view = AppHeadView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#ECEEF0")
    }
}

// MARK: - Root & Navigation
extension BaseViewController {

    func changeRootVc() {
        NotificationCenter.default.post(
            name: NSNotification.Name("changeRootVc"),
            object: nil,
            userInfo: ["tab": 0]
        )
    }

    func toProductDetailVc() {
        guard let nav = navigationController else { return }

        if let vc = nav.viewControllers.compactMap({ $0 as? ProductViewController }).first {
            nav.popToViewController(vc, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }

    func toOrderListVc() {
        guard let nav = navigationController else { return }

        if let vc = nav.viewControllers.compactMap({ $0 as? OrderListViewController }).first {
            nav.popToViewController(vc, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
}

// MARK: - Alert
extension BaseViewController {

    func alertLeaveView() {
        let popView = AuthPopLeaveView(frame: view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)

        present(alertVc!, animated: true)

        popView.confirmAction
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        popView.cancelAction
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true) {
                    self?.toProductDetailVc()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Web
extension BaseViewController {

    func goContentWebVc(with pageUrl: String) {
        let vc = H5ContentController()
        vc.pageUrl = pageUrl
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Product Detail Flow
extension BaseViewController {

    func productdetilInfo(
        with productID: String,
        viewModel: ProductViewModel
    ) async {

        let parameters = ["ideaical": productID]

        do {
            let model = try await viewModel.productInfo(with: parameters)
            let taxant = model.taxant ?? ""

            guard ["0", "00"].contains(taxant) else { return }

            let mnesteryModel = model.standee?.annsureist
            let republicanModel = model.standee?.republican
            let type = mnesteryModel?.gymnhelparian ?? ""

            let listArray = model.standee?.mnestery ?? []
            for item in listArray {
                if item.gymnhelparian == type {
                    mnesteryModel?.tenuot = item.tenuot ?? ""
                }
            }

            clickModelToPage(
                with: mnesteryModel,
                republicanModel: republicanModel,
                productID: productID,
                viewModel: viewModel
            )

        } catch {
            
        }
    }
}

// MARK: - Page Router
extension BaseViewController {

    func clickModelToPage(
        with model: mnesteryModel?,
        republicanModel: republicanModel?,
        productID: String,
        viewModel: ProductViewModel
    ) {

        let type = model?.gymnhelparian ?? ""

        switch type {

        case "seraneous":
            let vc = PhotoViewController()
            vc.mnesteryModel = model
            vc.productID = productID
            vc.republicanModel = republicanModel
            navigationController?.pushViewController(vc, animated: true)

        case "volitosity":
            let vc = PersonalViewController()
            vc.mnesteryModel = model
            vc.productID = productID
            vc.republicanModel = republicanModel
            navigationController?.pushViewController(vc, animated: true)

        case "vagauthorityier":
            let vc = PhonesViewController()
            vc.mnesteryModel = model
            vc.productID = productID
            vc.republicanModel = republicanModel
            navigationController?.pushViewController(vc, animated: true)

        case "philefeelition":
            let vc = PaysViewController()
            vc.mnesteryModel = model
            vc.productID = productID
            vc.republicanModel = republicanModel
            navigationController?.pushViewController(vc, animated: true)

        case "":
            starteight = String(Int(Date().timeIntervalSince1970))
            Task {
                if let republicanModel = republicanModel {
                    await orderToPage(with: republicanModel, viewModel: viewModel)
                }
            }

        default:
            break
        }
    }
}

// MARK: - Order
extension BaseViewController {

    private func orderToPage(
        with model: republicanModel,
        viewModel: ProductViewModel
    ) async {

        let parameters = [
            "moneyetic": model.receivester ?? "",
            "epish": model.epish ?? "",
            "willior": model.willior ?? "",
            "shouldarian": model.shouldarian ?? "",
            "necessary": model.wideious ?? ""
        ]

        let productID = model.allosion ?? ""

        do {
            let result = try await viewModel.applyReallyInfo(with: parameters)
            let taxant = result.taxant ?? ""

            guard ["0", "00"].contains(taxant) else { return }

            let pageUrl = result.standee?.howeveracy ?? ""

            if pageUrl.hasPrefix(scheme_url) {
                DeepLinkNavigator.navigate(to: pageUrl, from: self)
            } else if pageUrl.hasPrefix("http") {
                goContentWebVc(with: pageUrl)
            }

            Task {
                let endeight = String(Int(Date().timeIntervalSince1970))
                try? await Task.sleep(nanoseconds: 3_000_000_000)

                await suddenlyalBeaconingInfo(
                    with: viewModel,
                    productID: productID,
                    type: "8",
                    orderID: model.receivester ?? "",
                    start: starteight,
                    end: endeight
                )
            }

        } catch {
           
        }
    }
}

// MARK: - Beacon
extension BaseViewController {

    func suddenlyalBeaconingInfo(
        with viewModel: ProductViewModel,
        productID: String,
        type: String,
        orderID: String,
        start: String,
        end: String
    ) async {

        guard languageCode == .indonesian else { return }

        let parameters = [
            "thyresevenary": productID,
            "flect": type,
            "receivester": orderID,
            "munoain": SecurityVault.shared.getIDFV(),
            "lectity": SecurityVault.shared.getIDFA(),
            "pickics": LocationStorage.storedLongitude,
            "phaey": LocationStorage.storedLatitude,
            "catention": start,
            "noan": end
        ]

        do {
            let model = try await viewModel.suddenlyalBeaconingInfo(with: parameters)
            let taxant = model.taxant ?? ""

            if ["0", "00"].contains(taxant), type == "1" {
                UserDefaults.standard.removeObject(forKey: "start")
                UserDefaults.standard.removeObject(forKey: "end")
            }

        } catch {
            
        }
    }
}
