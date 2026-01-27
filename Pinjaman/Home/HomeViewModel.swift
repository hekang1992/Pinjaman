//
//  HomeViewModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import Foundation

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
    
}
