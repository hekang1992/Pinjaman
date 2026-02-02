//
//  PhotoViewController.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher
import BRPickerView
import TYAlertController

class PhotoViewController: BaseViewController {
    
    var productID: String = ""
    
    var republicanModel: republicanModel?
    
    var mnesteryModel: mnesteryModel?
    
    var model: BaseModel?
    
    private let viewModel = ProductViewModel()
    
    private let cameraManager = CameraManager()
    
    private let locationService = LocationService()
    
    private var photostart: String = ""
    
    private var photoend: String = ""
    
    private var facestart: String = ""
    
    private var faceend: String = ""
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = languageCode == .indonesian ? UIImage(named: "he_id_au_image") : UIImage(named: "he_eb_au_image")
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#FCD43E")
        bgView.layer.cornerRadius = 35
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 4
        bgView.layer.borderColor = UIColor.white.cgColor
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
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
        oneListView.peopleImageView.image = UIImage(named: "pho_place_image")
        return oneListView
    }()
    
    lazy var twoListView: PhotoListView = {
        let twoListView = PhotoListView()
        twoListView.descLabel.text = LStr("Face recognition")
        twoListView.peopleImageView.image = UIImage(named: "face_place_image")
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
            self.alertLeaveView()
        }
        
        view.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 311.pix(), height: 54.pix()))
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(clickBtn.snp.top).offset(-13.pix())
        }
        
        scrollView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 333.pix(), height: 76.pix()))
        }
        
        scrollView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.width.height.equalTo(70)
            make.left.equalToSuperview().offset(16)
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
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
        
        oneListView.tapClickBlock = { [weak self] in
            guard let self = self, let model = model else { return }
            self.judgePhotoOrFaceInfo(with: model, type: "0")
        }
        
        twoListView.tapClickBlock = { [weak self] in
            guard let self = self, let model = model else { return }
            self.judgePhotoOrFaceInfo(with: model, type: "0")
        }
        
        clickBtn.rx.tap
            .throttle(.milliseconds(250), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self, let model = model else { return }
                self.judgePhotoOrFaceInfo(with: model, type: "1")
            })
            .disposed(by: disposeBag)
        
        locationService.requestCurrentLocation { locationDict in }
        
        photostart = String(Int(Date().timeIntervalSince1970))
        
        logoImageView.kf.setImage(with: URL(string: mnesteryModel?.tenuot ?? ""))
        
        Task {
            await self.photoInfo()
        }
        
    }
    
}

extension PhotoViewController {
    
    private func judgePhotoOrFaceInfo(with model: BaseModel, type: String) {
        let idUrl = model.standee?.olivory?.howeveracy ?? ""
        let faceUrl = model.standee?.lovefaction?.howeveracy ?? ""
        if idUrl.isEmpty {
            self.popAuthPageView()
            return
        }
        if faceUrl.isEmpty {
            locationService.requestCurrentLocation { locationDict in }
            facestart = String(Int(Date().timeIntervalSince1970))
            self.popFacePageView()
            return
        }
        if type == "1" {
            Task {
                await self.productdetilInfo(with: productID, viewModel: viewModel)
            }
        }
        
    }
    
    private func popAuthPageView() {
        let popView = PopAlertPhotoView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        popView.bgImageView.image = languageCode == .indonesian ? UIImage(named: "alert_de_ph_id_image") : UIImage(named: "alert_de_ph_en_image")
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                cameraManager.presentCamera(from: self, device: .rear)
                cameraManager.onImageCaptured = { [weak self] data in
                    guard let imageData = data else { return }
                    Task {
                        await self?.uploadImageInfo(with: imageData, type: "11")
                    }
                }
            }
        }
    }
    
    private func popFacePageView() {
        let popView = PopAlertPhotoView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        popView.bgImageView.image = languageCode == .indonesian ? UIImage(named: "alert_de_face_id_image") : UIImage(named: "alert_de_face_en_image")
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                cameraManager.presentCamera(from: self, device: .front)
                cameraManager.onImageCaptured = { [weak self] data in
                    guard let imageData = data else { return }
                    Task {
                        await self?.uploadImageInfo(with: imageData, type: "10")
                    }
                }
            }
        }
    }
    
}

extension PhotoViewController {
    
    private func sheetView(with model: standeeModel) {
        photoend = String(Int(Date().timeIntervalSince1970))
        let popView = SavePhotoMessageView(frame: self.view.bounds)
        popView.model = model
        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        
        popView.timeBlock = { [weak self] tx in
            guard let self = self else { return }
            self.tapTimeClick(dateTx: tx)
        }
        
        popView.saveBlock = { [weak self] in
            guard let self = self else { return }
            let name = popView.oneFiled.text ?? ""
            let idnum = popView.twoFiled.text ?? ""
            let dateTime = popView.threeFiled.text ?? ""
            Task {
                let parameters = ["pentecostate": dateTime,
                                  "neverful": idnum,
                                  "tomoeconomyet": name,
                                  "novendecevidenceeer": UserManager.shared.getPhone() ?? "",
                                  "moneyetic": self.republicanModel?.receivester ?? "",
                                  "ideaical": self.productID]
                await self.savePhotoInfo(with: parameters)
            }
        }
        
    }
    
    private func tapTimeClick(dateTx: UITextField) {
        let selectedDate = parseDate(from: dateTx.text)
        showDatePicker(for: dateTx, with: selectedDate)
    }
    
    private func showDatePicker(for dateTx: UITextField, with selectedDate: Date) {
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = languageCode == .indonesian ? "Pemilihan tanggal" : "Date selection"
        datePickerView.selectDate = selectedDate
        datePickerView.pickerStyle = createPickerStyle()
        
        datePickerView.resultBlock = { [weak self] selectedDate, _ in
            self?.updateTime(dateTx: dateTx, with: selectedDate)
        }
        
        datePickerView.show()
    }
    
    private func parseDate(from timeString: String?) -> Date {
        guard let timeString = timeString, !timeString.isEmpty else {
            return defaultDate()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: timeString) ?? defaultDate()
    }
    
    private func defaultDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: "30/12/1992") ?? Date()
    }
    
    private func createPickerStyle() -> BRPickerStyle {
        let style = BRPickerStyle()
        style.rowHeight = 45
        style.language = "en"
        style.doneBtnTitle = languageCode == .indonesian ? "OKE" : "OK"
        style.cancelBtnTitle = languageCode == .indonesian ? "Batal" : "Cancel"
        style.doneTextColor = UIColor(hexString: "#333333")
        style.selectRowTextColor = UIColor(hexString: "#333333")
        style.pickerTextFont = UIFont.systemFont(ofSize: 16.pix(), weight: .bold)
        style.selectRowTextFont = UIFont.systemFont(ofSize: 16.pix(), weight: .bold)
        return style
    }
    
    private func updateTime(dateTx: UITextField, with date: Date?) {
        guard let date = date else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTx.text = dateFormatter.string(from: date)
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
                let idUrl = model.standee?.olivory?.howeveracy ?? ""
                let faceUrl = model.standee?.lovefaction?.howeveracy ?? ""
                if !idUrl.isEmpty {
                    oneListView.nameLabel.text = LStr("Finish")
                    oneListView.nameLabel.backgroundColor = UIColor.init(hexString: "#EF974D")
                    oneListView.layer.borderWidth = 1
                    oneListView.layer.borderColor = UIColor.white.cgColor
                    oneListView.trptImageView.isHidden = false
                    oneListView.peopleImageView.image = UIImage(named: "phoc_place_image")
//                    oneListView.peopleImageView.kf.setImage(with: URL(string: idUrl)) { result in
//                        switch result {
//                        case .success(_):
//                            DispatchQueue.main.async {
//                                self.oneListView.peopleImageView.layer.cornerRadius = 16
//                                self.oneListView.peopleImageView.layer.masksToBounds = true
//                            }
//                        case .failure(let error):
//                            print("error: \(error)")
//                        }
//                    }
                    
                }
                
                if !faceUrl.isEmpty {
                    twoListView.nameLabel.text = LStr("Finish")
                    twoListView.nameLabel.backgroundColor = UIColor.init(hexString: "#EF974D")
                    twoListView.layer.borderWidth = 1
                    twoListView.layer.borderColor = UIColor.white.cgColor
                    twoListView.trptImageView.isHidden = false
                    twoListView.peopleImageView.image = UIImage(named: "fac_place_image")
//                    twoListView.peopleImageView.kf.setImage(with: URL(string: faceUrl)) { result in
//                        switch result {
//                        case .success(_):
//                            DispatchQueue.main.async {
//                                self.twoListView.peopleImageView.layer.cornerRadius = 16
//                                self.twoListView.peopleImageView.layer.masksToBounds = true
//                            }
//                        case .failure(let error):
//                            print("error: \(error)")
//                        }
//                    }
                    
                }
            }
        } catch {
            
        }
    }
    
    private func uploadImageInfo(with data: Data, type: String) async {
        faceend = String(Int(Date().timeIntervalSince1970))
        do {
            let parameters = ["histrieastlike": type,
                              "activityaneity": "2",
                              "curvier": "",
                              "studentic": "1",
                              "pictoly": UserManager.shared.getPhone() ?? ""]
            let multipartData = ["experiblackair": data]
            let model = try await viewModel.uploadImageInfo(with: parameters, multipartData: multipartData)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                /// PHOTO
                if type == "11" {
                    if let standeeModel = model.standee {
                        self.sheetView(with: standeeModel)
                    }
                }else {
                    /// FACE
                    Task {
                        await self.photoInfo()
                        try? await Task.sleep(nanoseconds: 250_000_000)
                        await self.productdetilInfo(with: productID, viewModel: viewModel)
                    }
                    Task {
                        try? await Task.sleep(nanoseconds: 3_000_000_000)
                        await self.suddenlyalBeaconingInfo(with: viewModel,
                                                           productID: productID,
                                                           type: "3",
                                                           orderID: self.republicanModel?.receivester ?? "",
                                                           start: facestart,
                                                           end: faceend)
                    }
                }
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
        } catch {
            
        }
    }
    
    private func savePhotoInfo(with parameters: [String: String]) async {
        do {
            let model = try await viewModel.savePhotoInfo(with: parameters)
            let taxant = model.taxant ?? ""
            if ["0", "00"].contains(taxant) {
                self.dismiss(animated: true)
                Task {
                    await self.photoInfo()
                }
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    await self.suddenlyalBeaconingInfo(with: viewModel,
                                                       productID: productID,
                                                       type: "2",
                                                       orderID: self.republicanModel?.receivester ?? "",
                                                       start: photostart,
                                                       end: photoend)
                }
            }else {
                ToastManager.showLocal(model.troubleably ?? "")
            }
        } catch {
            
        }
    }
    
}
