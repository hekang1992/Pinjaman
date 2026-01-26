//
//  NetworkManager.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Codable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: [String: String]? = nil,
        multipartData: [String: Data]? = nil
    ) async throws -> T {
        
        let timeout: TimeInterval = (method == .get) ? 10.0 : 30.0
        
        let dataTask: DataTask<T>
        
        if method == .get {
            dataTask = AF.request(
                url,
                method: .get,
                parameters: parameters,
                requestModifier: { $0.timeoutInterval = timeout }
            ).serializingDecodable(T.self)
            
        } else {
            dataTask = AF.upload(
                multipartFormData: { multipart in
                    parameters?.forEach { key, value in
                        if let data = value.data(using: .utf8) {
                            multipart.append(data, withName: key)
                        }
                    }
                    multipartData?.forEach { key, data in
                        multipart.append(data, withName: key, fileName: "\(key).jpg", mimeType: "image/jpeg")
                    }
                },
                to: url,
                method: .post,
                requestModifier: { $0.timeoutInterval = timeout }
            ).serializingDecodable(T.self)
        }
        
        let response = await dataTask.response
        
        switch response.result {
        case .success(let model):
            return model
        case .failure(let error):
            throw error
        }
    }
}
