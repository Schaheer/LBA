//
//  PDARemitterDetailInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/04/2022.
//

import ObjectMapper

final class PDARemitterDetailInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case pdaRemitterDetailID = "pdaRemitterDetailId"
        case accountID = "accountId"
        case remitterName
        case relationshipWithRemitter
    }
    
    // MARK: - Model Properties
    
    var pdaRemitterDetailID: Double?
    var accountID: Double?
    var remitterName: String?
    var relationshipWithRemitter: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        pdaRemitterDetailID: Double,
        accountID: Double,
        remitterName: String,
        relationshipWithRemitter: String
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.pdaRemitterDetailID.rawValue] = pdaRemitterDetailID
        dictionary[CodingKeys.accountID.rawValue] = accountID
        dictionary[CodingKeys.remitterName.rawValue] = remitterName
        dictionary[CodingKeys.relationshipWithRemitter.rawValue] = relationshipWithRemitter
        
        self.pdaRemitterDetailID = pdaRemitterDetailID
        self.accountID = accountID
        self.remitterName = remitterName
        self.relationshipWithRemitter = relationshipWithRemitter
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        pdaRemitterDetailID <- map[CodingKeys.pdaRemitterDetailID.rawValue]
        accountID <- map[CodingKeys.accountID.rawValue]
        remitterName <- map[CodingKeys.remitterName.rawValue]
        relationshipWithRemitter <- map[CodingKeys.relationshipWithRemitter.rawValue]
    }
}
