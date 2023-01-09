//
//  UpdateAccountInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 12/04/2022.
//

import ObjectMapper

final class UpdateAccountInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case customerProfileID = "data.customerProfileId"
        case customerAccountInfoID = "data.customerAccountInfoId"
    }
    
    // MARK: - Model Properties
    
    var customerProfileID: Double?
    var customerAccountInfoID: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(customerProfileID: Double, customerAccountInfoID: Double) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.customerProfileID.rawValue] = customerProfileID
        dictionary[CodingKeys.customerAccountInfoID.rawValue] = customerAccountInfoID
        
        self.customerProfileID = customerProfileID
        self.customerAccountInfoID = customerAccountInfoID
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        customerProfileID <- map[CodingKeys.customerProfileID.rawValue]
        customerAccountInfoID <- map[CodingKeys.customerAccountInfoID.rawValue]
    }
}
