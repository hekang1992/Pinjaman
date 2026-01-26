//
//  StartViewModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import Foundation
import Alamofire

class StartViewModel {
    
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
    
}
