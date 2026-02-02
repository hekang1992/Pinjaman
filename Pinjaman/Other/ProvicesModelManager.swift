//
//  ProvicesModelManager.swift
//  Pinjaman
//
//  Created by Daniel Thomas Miller on 2026/2/2.
//

import BRPickerView

class ProvicesModelManager {
    static let shared = ProvicesModelManager()
    private init() {}
    var provicesModel: [variousingModel]?
}

struct ProvicesDecodeModel {
    static func getAddressModelArray(dataSourceArr: [variousingModel]) -> [BRTextModel] {
        return dataSourceArr.enumerated().map { provinceIndex, provinceItem in
            createProvinceModel(from: provinceItem, index: provinceIndex)
        }
    }
    
    private static func createProvinceModel(from provinceItem: variousingModel, index: Int) -> BRTextModel {
        let model = createBaseModel(from: provinceItem, index: index)
        model.children = createCityModels(from: provinceItem.teleoyourselfful)
        return model
    }
    
    private static func createCityModels(from cityItems: [variousingModel]?) -> [BRTextModel] {
        guard let cityItems = cityItems else { return [] }
        
        return cityItems.enumerated().map { cityIndex, cityItem in
            createCityModel(from: cityItem, index: cityIndex)
        }
    }
    
    private static func createCityModel(from cityItem: variousingModel, index: Int) -> BRTextModel {
        let model = createBaseModel(from: cityItem, index: index)
        model.children = createAreaModels(from: cityItem.teleoyourselfful)
        return model
    }
    
    private static func createAreaModels(from areaItems: [variousingModel]?) -> [BRTextModel] {
        guard let areaItems = areaItems else { return [] }
        
        return areaItems.enumerated().map { areaIndex, areaItem in
            createBaseModel(from: areaItem, index: areaIndex)
        }
    }
    
    private static func createBaseModel(from item: variousingModel, index: Int) -> BRTextModel {
        let model = BRTextModel()
        model.code = item.taxant ?? ""
        model.text = item.tomoeconomyet
        model.index = index
        return model
    }
}
