//
//  BaseViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let languageCode = LanguageManager.shared.currentType
    
    private var starteight: String = ""
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView()
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#ECEEF0")
    }
    
}

extension BaseViewController {
    
    func changeRootVc() {
        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil, userInfo: ["tab": 0])
    }
    
    func toProductDetailVc() {
        guard let nav = navigationController else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        if let productVC = nav.viewControllers.compactMap({ $0 as? ProductViewController }).first {
            nav.popToViewController(productVC, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
    func toOrderListVc() {
        guard let nav = navigationController else {
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        if let orderListVC = nav.viewControllers.compactMap({ $0 as? OrderListViewController }).first {
            nav.popToViewController(orderListVC, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
    func productdetilInfo(with productID: String, viewModel: ProductViewModel) async {
        let parameters = ["ideaical": productID]
        do {
            let model = try await viewModel.productInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let mnesteryModel = model.standee?.annsureist
                let republicanModel = model.standee?.republican
                self.clickModelToPage(with: mnesteryModel,
                                      republicanModel: republicanModel ?? nil,
                                      productID: productID,
                                      viewModel: viewModel)
                
            }
        } catch {
            
        }
    }
    
    func clickModelToPage(with model: mnesteryModel?, republicanModel: republicanModel?, productID: String, viewModel: ProductViewModel) {
        let type = model?.gymnhelparian ?? ""
        switch type {
        case "seraneous":
            let photoVc = PhotoViewController()
            photoVc.mnesteryModel = model
            photoVc.productID = productID
            photoVc.republicanModel = republicanModel
            self.navigationController?.pushViewController(photoVc, animated: true)
            
        case "volitosity":
            let personalVc = PersonalViewController()
            personalVc.mnesteryModel = model
            personalVc.productID = productID
            personalVc.republicanModel = republicanModel
            self.navigationController?.pushViewController(personalVc, animated: true)
            
        case "vagauthorityier":
            let phonesVc = PhonesViewController()
            phonesVc.mnesteryModel = model
            phonesVc.productID = productID
            phonesVc.republicanModel = republicanModel
            self.navigationController?.pushViewController(phonesVc, animated: true)
            
        case "philefeelition":
            let paysVc = PaysViewController()
            paysVc.mnesteryModel = model
            paysVc.productID = productID
            paysVc.republicanModel = republicanModel
            self.navigationController?.pushViewController(paysVc, animated: true)
            
        case "":
            starteight = String(Int(Date().timeIntervalSince1970))
            Task {
                if let republicanModel = republicanModel {
                    await self.orderToPage(with: republicanModel, viewModel: viewModel)
                }
            }
            
        default:
            break
        }
    }
    
    private func orderToPage(with model: republicanModel, viewModel: ProductViewModel) async {
        let moneyetic = model.receivester ?? ""
        let epish = model.epish ?? ""
        let willior = model.willior ?? ""
        let shouldarian = model.shouldarian ?? ""
        let necessary = model.wideious ?? ""
        
        let productID = model.allosion ?? ""
        
        let parameters = ["moneyetic": moneyetic,
                          "epish": epish,
                          "willior": willior,
                          "shouldarian": shouldarian,
                          "necessary": necessary]
        
        do {
            let model = try await viewModel.applyReallyInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                let pageUrl = model.standee?.howeveracy ?? ""
                if pageUrl.hasPrefix(scheme_url) {
                    DeepLinkNavigator.navigate(to: pageUrl, from: self)
                }else if pageUrl.hasPrefix("http") {
                    self.goContentWebVc(with: pageUrl)
                }
                
                Task {
                    let endeight = String(Int(Date().timeIntervalSince1970))
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    await self.suddenlyalBeaconingInfo(with: viewModel,
                                                       productID: productID,
                                                       type: "8",
                                                       orderID: moneyetic,
                                                       start: starteight,
                                                       end: endeight)
                }
                
            }
        } catch {
            
        }
        
    }
    
}

extension BaseViewController {
    
    func goContentWebVc(with pageUrl: String) {
        let contentVc = H5ContentController()
        contentVc.pageUrl = pageUrl
        self.navigationController?.pushViewController(contentVc, animated: true)
    }
    
}

extension BaseViewController {
    
    func suddenlyalBeaconingInfo(with viewModel: ProductViewModel,
                                 productID: String,
                                 type: String,
                                 orderID: String,
                                 start: String,
                                 end: String) async {
        if languageCode == .indonesian {
            let parameters = ["thyresevenary": productID,
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
                if ["0", "00"].contains(taxant) {
                    if type == "1" {
                        UserDefaults.standard.removeObject(forKey: "start")
                        UserDefaults.standard.removeObject(forKey: "end")
                    }
                }
            } catch {
                
            }
        }
    }
}
