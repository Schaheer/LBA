//
//  CountryLookupDataModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 24/05/2022.
//

import ObjectMapper

final class CountryLookupDataModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case code
        case dialingCode
        case description
        case id
        case name
    }
    
    // MARK: - Model Properties
    
    var code: String?
    var dialingCode: String?
    var description: String?
    var id: Int?
    var name: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: MappingType.fromJSON, JSON: dictionary))
    }
    
    // MARK: Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        code <- map[CodingKeys.code.rawValue]
        dialingCode <- map[CodingKeys.dialingCode.rawValue]
        description <- map[CodingKeys.description.rawValue]
        id <- map[CodingKeys.id.rawValue]
        name <- map[CodingKeys.name.rawValue]
    }
}
