//
//  BaseInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

class BaseInputModel: Mappable {
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // MARK: - Model Mapping
    
    func mapping(map: Map) {}
    
    // MARK: - Model Helper Methods
    
    func dictionaryRepresentation() -> [String: Any] {
        return toJSON()
    }
    
//    func toJsonArray() -> [String: Any] {
//        return toJSONArrayWithTransform(<#T##[Transform.Object]?#>, transform: <#T##Transform#>)
//    }
    
//    func toJsonArrayRepresentation() -> [[String: Any]] {
//        
//        return toJsonArrayRepresentation()
//    }
}
