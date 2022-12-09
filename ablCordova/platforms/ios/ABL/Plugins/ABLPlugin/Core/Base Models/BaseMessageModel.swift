//
//  BaseMessageModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

class BaseMessageModel: Mappable {
    
    // MARK: - Model Keys
    
    enum CodingKeys: String {
        case status
        case description
    }
    
    // MARK: - Model Properties
    
    var status: String?
    var description: String?
    
    // MARK: - Initializers
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // MARK: - Model Mapping
    
    func mapping(map: Map) {
        status <- map[CodingKeys.status.rawValue]
        description <- map[CodingKeys.description.rawValue]
    }
    
    // MARK: - Helper Functions
    
    func dictionaryRepresentation() -> [String: Any] {
        return toJSON()
    }
}
