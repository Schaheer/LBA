//
//  RegisterPicAndSignInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/19/22.
//

import ObjectMapper


final class RegisterPicAndSignInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"

    }
    
    // MARK: - Model Properties
    
    var consumerList: [RegisterPicAndSignConsumerInputModel]?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [RegisterPicAndSignConsumerInputModel]


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

final class RegisterPicAndSignConsumerInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerId = "rdaCustomerId"
        case customerTypeId = "customerTypeId"
        case natureOfAccountId = "natureOfAccountId"
        case noOfJointApplicatns = "noOfJointApplicatns"
        case modeOfMajorTransId = "modeOfMajorTransId"
        case nameOnPhysicalATM = "nameOnPhysicalATM"

    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerId: Double?
    var customerTypeId: Double?
    var natureOfAccountId: Double?
    var noOfJointApplicatns: Int?
    var rdaCustomerProfileId: Double?
    var nameOnPhysicalATM: String?
    var modeOfMajorTransId: [Double]?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerId: Double,
        customerTypeId: Double,
        natureOfAccountId: Double,
        noOfJointApplicatns: Int,
        rdaCustomerProfileId: Double,
        nameOnPhysicalATM: String,
        modeOfMajorTransId: [Double]

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        dictionary[CodingKeys.natureOfAccountId.rawValue] = natureOfAccountId
        dictionary[CodingKeys.noOfJointApplicatns.rawValue] = noOfJointApplicatns
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.nameOnPhysicalATM.rawValue] = nameOnPhysicalATM
        dictionary[CodingKeys.modeOfMajorTransId.rawValue] = modeOfMajorTransId

        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerId = rdaCustomerId
        self.customerTypeId = customerTypeId
        self.natureOfAccountId = natureOfAccountId
        self.noOfJointApplicatns = noOfJointApplicatns
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.nameOnPhysicalATM = nameOnPhysicalATM
        self.modeOfMajorTransId = modeOfMajorTransId
        
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
        rdaCustomerId <- map[CodingKeys.rdaCustomerId.rawValue]
        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
        natureOfAccountId <- map[CodingKeys.natureOfAccountId.rawValue]
        noOfJointApplicatns <- map[CodingKeys.noOfJointApplicatns.rawValue]
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        nameOnPhysicalATM <- map[CodingKeys.nameOnPhysicalATM.rawValue]
        modeOfMajorTransId <- map[CodingKeys.modeOfMajorTransId.rawValue]

    }
}
