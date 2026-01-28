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
    
}
