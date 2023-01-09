//
//  BaseResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

class BaseResponseModel: Mappable {
    
    // MARK: - Model Keys
    
    enum CodingKeys: String {
        case message
    }
    
    // MARK: - Model Properties
    
    var message: BaseMessageModel?
    
    // MARK: - Initializers
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    // MARK: - Model Mapping
    
    func mapping(map: Map) {
        message <- map[CodingKeys.message.rawValue]
    }
    
    // MARK: - Helper Functions
    
    func dictionaryRepresentation() -> [String: Any] {
        return toJSON()
    }
}
