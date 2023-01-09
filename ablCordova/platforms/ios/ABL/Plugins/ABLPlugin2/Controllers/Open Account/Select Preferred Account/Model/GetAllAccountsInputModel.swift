//
//  GetAllAccountsInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 6/13/22.
//

import ObjectMapper


final class GetAllAccountsInputModel: BaseInputModel {
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case codeTypeID = "data.codeTypeId"
        case codeDescription = "data.codeDescription"
        case codeOrder = "data.codeOrder"
    }
    
    // MARK: - Model Properties
    
    var codeTypeID: Int?
    var codeDescription: String?
    var codeOrder: Int?
    
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(codeTypeID: Int,
                   codeDescription: String,
                   codeOrder: Int) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.codeTypeID.rawValue] = codeTypeID
        dictionary[CodingKeys.codeDescription.rawValue] = codeDescription
        dictionary[CodingKeys.codeOrder.rawValue] = codeOrder
        
        self.codeTypeID = codeTypeID
        self.codeDescription = codeDescription
        self.codeOrder = codeOrder
        
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
        codeDescription <- map[CodingKeys.codeDescription.rawValue]
        codeOrder <- map[CodingKeys.codeOrder.rawValue]
    }
}
