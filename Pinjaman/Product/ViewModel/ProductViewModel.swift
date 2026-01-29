//
//  ProductViewModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import Foundation
import Alamofire

class ProductViewModel {
    
    func productInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/tableaneous", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
    }
    
}

extension ProductViewModel {
    
    func photoInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/courseesque", method: .get, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func uploadImageInfo(with parameters: [String: String], multipartData: [String: Data]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/bedose", method: .post, parameters: parameters, multipartData: multipartData)
            return model
        } catch {
            throw error
        }
        
    }
    
    func savePhotoInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        var apiUrl: String = ""
        if LanguageManager.shared.currentType == .indonesian {
            apiUrl = "/suddenlyal/nascorium"
        }else {
            apiUrl = "/suddenlyal/pulchristic"
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request(apiUrl, method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
}

extension ProductViewModel {
    
    func personalInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/sugfold", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func savepersonalInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/carcerful", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
}

extension ProductViewModel {
    
    func phonesInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/dreamorium", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func savephonesInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/wish", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func uploadphonesInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/nuchine", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
}

extension ProductViewModel {
    
    func paysInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/variousing", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func savepaysInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/histrieastlike", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
}

extension ProductViewModel {
    
    func applyReallyInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/misceeer", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
}
