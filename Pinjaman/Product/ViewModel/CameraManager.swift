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
    }
    
    private func showSettingsAlert(on vc: UIViewController) {
        let alert = UIAlertController(title: "需要相机权限",
                                      message: "您已禁用相机权限，请前往设置开启，以便正常拍照。",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        })
        vc.present(alert, animated: true)
    }
    
    private func showAlert(on vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        vc.present(alert, animated: true)
    }
    
    private func compressImage(_ image: UIImage) -> Data? {
        var compression: CGFloat = 0.9
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
        
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self, let capturedImage = originalImage else { return }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let compressedData = self.compressImage(capturedImage)
                DispatchQueue.main.async {
                    self.onImageCaptured?(compressedData)
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
