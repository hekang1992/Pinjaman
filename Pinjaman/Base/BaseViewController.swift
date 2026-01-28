//
//  BaseViewController.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let languageCode = LanguageManager.shared.currentType
    
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
        NotificationCenter.default.post(name: NSNotification.Name("changeRootVc"), object: nil)
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
    
    func productdetilInfo(with productID: String, viewModel: ProductViewModel) async {
        let parameters = ["ideaical": productID]
        do {
            let model = try await viewModel.productInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                if let mnesteryModel = model.standee?.annsureist, let republicanModel = model.standee?.republican {
                    self.clickModelToPage(with: mnesteryModel,
                                          republicanModel: republicanModel,
                                          productID: productID)
                }
            }
        } catch {
            
        }
    }
    
    func clickModelToPage(with model: mnesteryModel, republicanModel: republicanModel, productID: String) {
        let type = model.gymnhelparian ?? ""
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
            break
            
        default:
            break
        }
    }
    
}
