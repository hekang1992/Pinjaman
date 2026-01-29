//
//  CenterViewModel.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/1/27.
//

import Foundation

class CenterViewModel {
    
    func getCenterInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/angumedicalwise")
            return model
        } catch {
            throw error
        }
    }
}

extension CenterViewModel {
    
    func accountExitInfo() async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/taxant")
            return model
        } catch {
            throw error
        }
    }
    
    func accountDeleteInfo() async throws -> BaseModel {
        
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
