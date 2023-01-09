//
//  OccupationsListInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/15/22.
//

import ObjectMapper


final class OccupationsListInputModel: BaseInputModel {
    
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
