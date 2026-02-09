//
//  NetworkManager.swift
//  UangCair
//
//  Created by Daniel Thomas Miller on 2026/1/26.
//

import Foundation
import Alamofire

let base_url = "http://8.215.86.57:9803/trixoon"
let h5_base_url = "http://8.215.86.57:9803"
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Codable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: [String: String]? = nil,
        multipartData: [String: Data]? = nil
    ) async throws -> T {
        
        let imageKey = generateRandomString()
        
        let timeout: TimeInterval = (method == .get) ? 20.0 : 30.0
        
        let dataTask: DataTask<T>
        
        let apiUrl = (base_url + url).appendingQueryParameters(DeviceProfile.assembleAuditParams())
        
        if method == .get {
            dataTask = AF.request(
                apiUrl,
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
                        multipart.append(data, withName: key, fileName: "\(imageKey).jpg", mimeType: "image/jpeg")
                    }
                },
                to: apiUrl,
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

extension NetworkManager {
    
    func generateRandomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let alphanumeric = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let firstChar = String(letters.randomElement()!)
        
        let middleChars = (0..<14).map { _ in
            String(alphanumeric.randomElement()!)
        }.joined()
        
        let lastChar = String(letters.randomElement()!)
        
        return firstChar + middleChars + lastChar
    }
    
}
