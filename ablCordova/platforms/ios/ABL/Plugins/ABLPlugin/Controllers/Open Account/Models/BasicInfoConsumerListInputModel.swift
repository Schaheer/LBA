//
//  BasicInfoConsumerListInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/13/22.
//

import ObjectMapper


final class BasicInfoConsumerListInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case fullName = "fullName"
        case fatherHusbandName = "fatherHusbandName"
        case motherMaidenName = "motherMaidenName"
        case isPrimary = "isPrimary"
        case customerTypeID = "customerTypeId"
        case occupationID = "occupationId"
        case professionID = "professionId"
        case kinName
        case kinCNIC = "kinCnic"
        case kinMobileNumber = "kinMobile"
        case taxResidentInd
        case genderId
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var fullName: String?
    var fatherHusbandName: String?
    var motherMaidenName: String?
    var isPrimary: Bool?
    var kinName: String?
    var kinCNIC: String?
    var kinMobileNumber: String?
    var taxResidentInd: Int?
    var customerTypeID: Double?
    var genderId: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        fullName: String,
        fatherHusbandName: String,
        motherMaidenName: String,
        isPrimary: Bool,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.genderId.rawValue] = genderId

        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.isPrimary = isPrimary
        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        kinName: String,
        kinCNIC: String,
        kinMobileNumber: String,
        isPrimary: Bool,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.kinName.rawValue] = kinName
        dictionary[CodingKeys.kinCNIC.rawValue] = kinCNIC
        dictionary[CodingKeys.kinMobileNumber.rawValue] = kinMobileNumber
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.kinName = kinName
        self.kinCNIC = kinCNIC
        self.kinMobileNumber = kinMobileNumber
        self.isPrimary = isPrimary
        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        customerTypeID: Double,
        taxResidentInd: Int,
        isPrimary: Bool,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.customerTypeID = customerTypeID
        self.taxResidentInd = taxResidentInd
        self.isPrimary = isPrimary
        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.genderId = genderId
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
        fullName <- map[CodingKeys.fullName.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        kinName <- map[CodingKeys.kinName.rawValue]
        kinCNIC <- map[CodingKeys.kinCNIC.rawValue]
        kinMobileNumber <- map[CodingKeys.kinMobileNumber.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        genderId <- map[CodingKeys.genderId.rawValue]
    }
}
