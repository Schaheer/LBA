//
//  PurposeOfAccountInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/04/2022.
//

import ObjectMapper

final class PurposeOfAccountInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case codeTypeID = "data.codeTypeId"
    }
    
    // MARK: - Model Properties
    
    var codeTypeID: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(codeTypeID: Int) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.codeTypeID.rawValue] = codeTypeID
        
        self.codeTypeID = codeTypeID
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        codeTypeID <- map[CodingKeys.codeTypeID.rawValue]
    }
}
