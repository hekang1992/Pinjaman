//
//  CameraManager.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/28.
//

import UIKit
import AVFoundation

class CameraManager: NSObject {
    
    var onImageCaptured: ((Data?) -> Void)?
    
    private let maxByteSize = 800 * 1024
    
    func presentCamera(from viewController: UIViewController, device: UIImagePickerController.CameraDevice = .rear) {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.showImagePicker(from: viewController, device: device)
                    }else {
                        self?.showSettingsAlert(on: viewController)
                    }
                }
            }
            
        case .authorized:
            self.showImagePicker(from: viewController, device: device)
            
        case .denied, .restricted:
            self.showSettingsAlert(on: viewController)
            
        @unknown default:
            break
        }
    }
    
    private func showImagePicker(from vc: UIViewController, device: UIImagePickerController.CameraDevice) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = device
        picker.delegate = self
        picker.allowsEditing = false
        vc.present(picker, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            if device == .front {
                self.hidePickerView(pickerView: picker.view)
            }
        }
    }
    
    private func showSettingsAlert(on vc: UIViewController) {
        let alert = UIAlertController(title: LStr("Camera Permission Required"),
                                      message: LStr("Camera permission is not authorized, so you cannot take a photo of your ID card to complete the verification. Your information is encrypted throughout the process. Please go to Settings to enable it immediately."),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: LStr("Cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: LStr("Settings"), style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        })
        vc.present(alert, animated: true)
    }
    
    private func compressImage(_ image: UIImage) -> Data? {
        var compression: CGFloat = 0.8
        let minCompression: CGFloat = 0.1
        
        guard var imageData = image.jpegData(compressionQuality: compression) else { return nil }
        
        while imageData.count > maxByteSize && compression > minCompression {
            compression -= 0.1
            if let newData = image.jpegData(compressionQuality: compression) {
                imageData = newData
            }
        }
        
        print("image-size: \(Double(imageData.count) / 1024.0) KB")
        return imageData
    }
}

extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage = info[.originalImage] as? UIImage
        
        guard let capturedImage = originalImage else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let compressedData = self.compressImage(capturedImage)
            DispatchQueue.main.async {
                picker.dismiss(animated: true) {
                    self.onImageCaptured?(compressedData)
                }
                
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CameraManager {
    
    private func hidePickerView(pickerView: UIView) {
        if #available(iOS 26, *) {
            let name = "SwiftUI._UIGraphicsView"
            if let cls = NSClassFromString(name) {
                for view in pickerView.subviews {
                    if view.isKind(of: cls) {
                        if view.bounds.width == 48 && view.bounds.height == 48 {
                            if view.frame.minX > UIScreen.main.bounds.width / 2.0 {
                                view.isHidden = true
                                return
                            }
                        }
                    }
                    hidePickerView(pickerView: view)
                }
            }
        }else {
            let name = "CAMFlipButton"
            for bbview in pickerView.subviews {
                if bbview.description.contains(name) {
                    bbview.isHidden = true
                    return
                }
                hidePickerView(pickerView: bbview)
            }
        }
    }
    
}
