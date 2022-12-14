//
//  ConsumerAccountDetailInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 11/04/2022.
//

import ObjectMapper

final class ConsumerAccountDetailInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerProfileID = "data.rdaCustomerProfileId"
        case rdaCustomerAccInfoID = "data.rdaCustomerAccInfoId"
        case customerTypeID = "data.customerTypeId"
        case statusId = "data.statusId"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerProfileID: Double?
    var rdaCustomerAccInfoID: Double?
    var customerTypeID: Double?
    var statusId: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerProfileID: Double,
        rdaCustomerAccInfoID: Double,
        customerTypeID: Double? = nil,
        statusId: Double? = nil
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerProfileID.rawValue] = rdaCustomerProfileID
        dictionary[CodingKeys.rdaCustomerAccInfoID.rawValue] = rdaCustomerAccInfoID
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.statusId.rawValue] = statusId

        self.rdaCustomerProfileID = rdaCustomerProfileID
        self.rdaCustomerAccInfoID = rdaCustomerAccInfoID
        self.customerTypeID = customerTypeID
        self.statusId = statusId
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
        rdaCustomerAccInfoID <- map[CodingKeys.rdaCustomerAccInfoID.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        statusId <- map[CodingKeys.customerTypeID.rawValue]
    }
}
