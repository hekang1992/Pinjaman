//
//  ContactManager.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/28.
//

import Foundation
import Contacts
import ContactsUI
import UIKit

struct ContactModel: Codable {
    let tellard: String
    let tomoeconomyet: String
}

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    private let contactStore = CNContactStore()
    
    private var selectionHandler: ((ContactModel?) -> Void)?
    
    func fetchAllContacts(completion: @escaping ([ContactModel]) -> Void) {
        checkPermission { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                var results = [ContactModel]()
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                
                do {
                    try self.contactStore.enumerateContacts(with: request) { (contact, stop) in
                        let name = "\(contact.givenName)-\(contact.familyName)".trimmingCharacters(in: .whitespaces)

                        let phones = contact.phoneNumbers.map { $0.value.stringValue }.joined(separator: ",")
                        
                        if !phones.isEmpty {
                            results.append(ContactModel(tellard: phones, tomoeconomyet: name))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(results)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
        }
    }
    
    func showPicker(from vc: UIViewController, completion: @escaping (ContactModel?) -> Void) {
        self.selectionHandler = completion
        
        checkPermission { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                let picker = CNContactPickerViewController()
                picker.delegate = self
                picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
                vc.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    private func checkPermission(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        
        switch status {
        case .authorized, .limited:
            completion(true)
            
        case .notDetermined:
            DispatchQueue.global(qos: .userInitiated).async {
                self.contactStore.requestAccess(for: .contacts) { (granted, _) in
                    DispatchQueue.main.async {
                        completion(granted)
                    }
                }
            }
            
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.showPermissionAlert()
                completion(false)
            }
            
        @unknown default:
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    private func showPermissionAlert() {
        guard let rootVC = getTopViewController() else { return }
        
        let alert = UIAlertController(
            title: "权限受限",
            message: "请在设置中允许访问通讯录，以便选择联系人",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        rootVC.present(alert, animated: true)
    }
    
    private func getTopViewController() -> UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            
            var topVC = rootVC
            while let presentedVC = topVC.presentedViewController {
                topVC = presentedVC
            }
            return topVC
        }
        return nil
    }
}

extension ContactManager: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = "\(contact.givenName)-\(contact.familyName)".trimmingCharacters(in: .whitespaces)
        
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        
        if !phoneNumber.isEmpty {
            let model = ContactModel(tellard: phoneNumber, tomoeconomyet: name)
            selectionHandler?(model)
        } else {
            selectionHandler?(nil)
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        selectionHandler?(nil)
    }
}
