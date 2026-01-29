//
//  BaseView.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import UIKit
import RxSwift
import RxCocoa

class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    
    let languageCode = LanguageManager.shared.currentType
}
