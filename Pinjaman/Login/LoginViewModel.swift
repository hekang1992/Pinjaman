//
//  LoginViewModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import Foundation
import Alamofire

class LoginViewModel {
    
    func codeInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/tellard", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func loginInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/todayical", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
    
    func logoutInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/todayical")
            return model
        } catch {
            throw error
        }
        
    }
    
    func deleteInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/putitive")
            return model
        } catch {
            throw error
        }
        
    }
    
}
