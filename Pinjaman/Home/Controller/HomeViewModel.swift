//
//  HomeViewModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    func getHomeInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/troubleably")
            return model
        } catch {
            throw error
        }
        
    }
    
    func clickProductInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/lapsmeetingoon", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
}

extension HomeViewModel {
    
    func getInitInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let parameters = DeviceInspector.getAuditParams()
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/television", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func uploadIDFAInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/megfinishern", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func uploadLocationInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/spicly", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func uploadMacInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/powerability", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
}
