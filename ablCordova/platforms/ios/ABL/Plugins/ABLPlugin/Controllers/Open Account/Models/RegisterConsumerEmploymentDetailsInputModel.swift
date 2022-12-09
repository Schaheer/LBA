//
//  RegisterConsumerEmploymentDetailsInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/15/22.
//

import ObjectMapper

final class RegisterConsumerEmploymentDetailsInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"

    }
    
    // MARK: - Model Properties
    
    var consumerList: [EmploymentDetailsInputModel]?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [EmploymentDetailsInputModel]

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

final class EmploymentDetailsInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case occupationId = "occupationId"
        case professionId = "professionId"
        case isPrimary = "isPrimary"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var occupationId: Double?
    var professionId: Double?
    var isPrimary: Bool?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        occupationId: Double,
        professionId: Double,
        isPrimary: Bool
        
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.occupationId.rawValue] = occupationId
        dictionary[CodingKeys.professionId.rawValue] = professionId
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.occupationId = occupationId
        self.professionId = professionId
        self.isPrimary = isPrimary
        
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
        occupationId <- map[CodingKeys.occupationId.rawValue]
        professionId <- map[CodingKeys.professionId.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
    }
}
