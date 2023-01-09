//
//  CodeTypeDataModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/04/2022.
//

import ObjectMapper

final class CodeTypeDataModel: BaseResponseModel {
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case description
        case id
        case name
    }
    
    // MARK: - Model Properties
    
    var description: String?
    var id: Double?
    var name: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: MappingType.fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        description <- map[CodingKeys.description.rawValue]
        id <- map[CodingKeys.id.rawValue]
        name <- map[CodingKeys.name.rawValue]
    }
}
