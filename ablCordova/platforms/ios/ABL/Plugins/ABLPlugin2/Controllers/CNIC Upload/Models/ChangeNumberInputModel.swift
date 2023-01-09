//
//  ChangeNumberInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 19/04/2022.
//

import ObjectMapper

final class ChangeNumberInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case mobileNumber = "data.mobileNo"
        case rdaCustomerProfileID = "data.rdaCustomerProfileId"
    }
    
    // MARK: - Model Properties
    
    var mobileNumber: String?
    var rdaCustomerProfileID: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        mobileNumber: String,
        rdaCustomerProfileID: Double
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.rdaCustomerProfileID.rawValue] = rdaCustomerProfileID
        
        self.mobileNumber = mobileNumber
        self.rdaCustomerProfileID = rdaCustomerProfileID
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        mobileNumber <- map[CodingKeys.mobileNumber.rawValue]
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
    }
}
