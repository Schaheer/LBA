//
//  RegisterConsumerEmailInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/14/22.
//

import ObjectMapper


final class RegisterConsumerEmailInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"
    }
    
    // MARK: - Model Properties
    
    var consumerList: [EmailConsumerListInputModel]?
    

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [EmailConsumerListInputModel]
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.consumerList.rawValue] = consumerList
        
        self.consumerList = consumerList
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        consumerList <- map[CodingKeys.consumerList.rawValue]
    }
}


final class EmailConsumerListInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case emailAddress = "emailAddress"
        case isPrimary = "isPrimary"
        case customerNonResidentInd
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var emailAddress: String?
    var isPrimary: Bool?
    var customerNonResidentInd: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        emailAddress: String,
        isPrimary: Bool,
        customerNonResidentInd: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.emailAddress.rawValue] = emailAddress
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.customerNonResidentInd.rawValue] = customerNonResidentInd
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.emailAddress = emailAddress
        self.isPrimary = isPrimary
        self.customerNonResidentInd = 0
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        customerNonResidentInd <- map[CodingKeys.customerNonResidentInd.rawValue]
    }
}

