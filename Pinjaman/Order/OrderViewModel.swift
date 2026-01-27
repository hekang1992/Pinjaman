//
//  OrderViewModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/27.
//

import Foundation
import Alamofire

class OrderViewModel {
    
    func getOrderInfo(with parameters: [String: String]) async throws -> BaseModel {
        
        LoadingView.shared.show()
        
        defer {
            DispatchQueue.main.async {
                LoadingView.shared.hide()
            }
        }
        
        do {
            let model: BaseModel = try await NetworkManager.shared.request("/suddenlyal/howeveracy", method: .post, parameters: parameters)
            return model
        } catch {
            throw error
        }
        
    }
}
