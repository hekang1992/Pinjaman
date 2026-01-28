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
    var veriid: [veriidModel]?
    var howeveracy: String?
    var mnestery: [mnesteryModel]?
    var annsureist: mnesteryModel?
    var republican: republicanModel?
    var olivory: olivoryModel?
    var lovefaction: olivoryModel?
    var pentecostate: String?
    var neverful: String?
    var tomoeconomyet: String?
    var individualster: [individualsterModel]?
    var ticmost: ticmostModel?
}

class individualsterModel: Codable {
    var asform: String?
    var betterern: String?
    var taxant: String?
    var colfy: String?/// 枚举类型
    var windowfication: String?
    var histrieastlike: String?
    var enough: String?
    var trachyify: [trachyifyModel]?
}

class olivoryModel: Codable {
    var howeveracy: String?
    var tedi: tediModel?
}

class tediModel: Codable {
    var tomoeconomyet: String?
    var neverful: String?
    var pentecostate: String?
}

class variousingModel: Codable {
    var histrieastlike: String?
    var misceeer: [misceeerModel]?
    var secrfier: String?
    var tomoeconomyet: String?
    var novendecevidenceeer: String?
    var gel: String?
    var punctious: String?
    var payous: String?
    var tomoous: String?
    var fire: String?
    var zyg: String?
    var tonightture: [trachyifyModel]?
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

class veriidModel: Codable {
    var asform: String?
    var dreamorium: String?
    var wish: String?
}

class longadeModel: Codable {
    var adibility: adibilityModel?
    var stateth: adibilityModel?
}

class adibilityModel: Codable {
    var asform: String?
    var punctious: String?
}

class ticmostModel: Codable {
    var variousing: [variousingModel]?
}

class trachyifyModel: Codable {
    var tomoeconomyet: String?
    var histrieastlike: String?
    
    enum CodingKeys: String, CodingKey {
        case tomoeconomyet, histrieastlike
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .tomoeconomyet) {
            tomoeconomyet = String(intValue)
        } else {
            tomoeconomyet = try? container.decode(String.self, forKey: .tomoeconomyet)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .histrieastlike) {
            histrieastlike = String(intValue)
        } else {
            histrieastlike = try? container.decode(String.self, forKey: .histrieastlike)
        }
    }
    
}

class mnesteryModel: Codable {
    var gymnhelparian: String?
    var asform: String?
    var nascorium: String?
    var tenuot: String?
    var thymspecificet: String?
    
    enum CodingKeys: String, CodingKey {
        case gymnhelparian, asform, nascorium, tenuot, thymspecificet
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .gymnhelparian) {
            gymnhelparian = String(intValue)
        } else {
            gymnhelparian = try? container.decode(String.self, forKey: .gymnhelparian)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .asform) {
            asform = String(intValue)
        } else {
            asform = try? container.decode(String.self, forKey: .asform)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .nascorium) {
            nascorium = String(intValue)
        } else {
            nascorium = try? container.decode(String.self, forKey: .nascorium)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .tenuot) {
            tenuot = String(intValue)
        } else {
            tenuot = try? container.decode(String.self, forKey: .tenuot)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .thymspecificet) {
            thymspecificet = String(intValue)
        } else {
            thymspecificet = try? container.decode(String.self, forKey: .thymspecificet)
        }
    }
}

class republicanModel: Codable {
    var receivester: String?
    var epish: String?
    var willior: String?
    var shouldarian: String?
    var controwho: String?
    var wideious: String?
    var spicly: String?
    var powerability: String?
    var longade: longadeModel?
    
    enum CodingKeys: String, CodingKey {
        case receivester, epish, willior, shouldarian, controwho
        case wideious, spicly, powerability, longade
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .receivester) {
            receivester = String(intValue)
        } else {
            receivester = try? container.decode(String.self, forKey: .receivester)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .epish) {
            epish = String(intValue)
        } else {
            epish = try? container.decode(String.self, forKey: .epish)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .willior) {
            willior = String(intValue)
        } else {
            willior = try? container.decode(String.self, forKey: .willior)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .shouldarian) {
            shouldarian = String(intValue)
        } else {
            shouldarian = try? container.decode(String.self, forKey: .shouldarian)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .controwho) {
            controwho = String(intValue)
        } else {
            controwho = try? container.decode(String.self, forKey: .controwho)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .wideious) {
            wideious = String(intValue)
        } else {
            wideious = try? container.decode(String.self, forKey: .wideious)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .spicly) {
            spicly = String(intValue)
        } else {
            spicly = try? container.decode(String.self, forKey: .spicly)
        }
        
        if let intValue = try? container.decode(Int.self, forKey: .powerability) {
            powerability = String(intValue)
        } else {
            powerability = try? container.decode(String.self, forKey: .powerability)
        }
        
        longade = try? container.decode(longadeModel.self, forKey: .longade)
    }
    
}
