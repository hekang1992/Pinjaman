//
//  BaseModel.swift
//  Pinjaman
//
//  Created by hekang on 2026/1/26.
//

class BaseModel: Codable {
    var taxant: String?
    var troubleably: String?
    var standee: standeeModel?
    
    private enum CodingKeys: String, CodingKey {
        case taxant, troubleably, standee
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .taxant) {
            taxant = String(intValue)
        } else {
            taxant = try? container.decode(String.self, forKey: .taxant)
        }
        
        troubleably = try? container.decode(String.self, forKey: .troubleably)
        standee = try? container.decode(standeeModel.self, forKey: .standee)
    }
}

class standeeModel: Codable {
    var horm: String?
    var angumedicalwise: String?
    var anaorderade: String?
    var variousing: [variousingModel]?
}

class variousingModel: Codable {
    var histrieastlike: String?
    var misceeer: [misceeerModel]?
}

class misceeerModel: Codable {
    var allosion: Int?
    var wideious: String?
    var spicly: String?
    var powerability: String?
    
    var megfinishern: String?
    var nuchine: String?
    var putitive: String?
    var pinndataad: String?
    
    var gentture: String?
    var morning: String?
    var butly: String?
    
}
