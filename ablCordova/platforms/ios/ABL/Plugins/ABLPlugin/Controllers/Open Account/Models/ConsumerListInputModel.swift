//
//  ConsumerListModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class ConsumerListInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case cnicNumber = "idNumber"
        case mobileNumber = "mobileNo"
        case isPrimary = "isPrimary"
        case customerTypeID = "customerTypeId"
        case customerBranch = "customerBranch"
        case bankingModeID = "bankingModeId"
        case dateOfIssue = "dateOfIssue"
        case dateOfBirth = "dateOfBirth"
        case isPrimaryRegistered = "isPrimaryRegistered"
        case portedMobileNetwork = "portedMobileNetwork"
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case attachments

    }
    

    
    // MARK: - Model Properties
    
    var cnicNumber: String?
    var mobileNumber: String?
    var isPrimary: Bool?
    var customerTypeID: Double?
    var customerBranch: String?
    var bankingModeID: Double?
    var dateOfBirth: String?
    var dateOfIssue: String?
    var isPrimaryRegistered: Bool?
    var portedMobileNetwork: Bool?
    var rdaCustomerAccInfoId: Double?
    var attachments: [[String : Any]]?

    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        cnicNumber: String,
        mobileNumber: String,
        isPrimary: Bool,
        customerTypeID: Double,
        customerBranch: String,
        bankingModeID: Double,
        rdaCustomerAccInfoId: Double,
        attachments: [[String : Any]],
        isPrimaryRegistered: Bool
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.cnicNumber.rawValue] = cnicNumber
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.bankingModeID.rawValue] = bankingModeID
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.attachments.rawValue] = attachments
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        
        self.cnicNumber = cnicNumber
        self.mobileNumber = mobileNumber
        self.isPrimary = isPrimary
        self.customerTypeID = customerTypeID
        self.customerBranch = customerBranch
        self.bankingModeID = bankingModeID
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.attachments = attachments
        self.isPrimaryRegistered = isPrimaryRegistered

        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        cnicNumber: String,
        mobileNumber: String,
        isPrimary: Bool,
        customerTypeID: Double,
        customerBranch: String,
        bankingModeID: Double? = nil,
        dateOfBirth: String,
        dateOfIssue: String,
        isPrimaryRegistered: Bool? = nil,
        portedMobileNetwork: Bool? = nil,
        rdaCustomerAccInfoId: Double? = 0,
        attachments: [[String : Any]]
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.cnicNumber.rawValue] = cnicNumber
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.bankingModeID.rawValue] = bankingModeID
        dictionary[CodingKeys.dateOfBirth.rawValue] = dateOfBirth
        dictionary[CodingKeys.dateOfIssue.rawValue] = dateOfIssue
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        dictionary[CodingKeys.portedMobileNetwork.rawValue] = portedMobileNetwork
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId == 0 ? "" : rdaCustomerAccInfoId
        dictionary[CodingKeys.attachments.rawValue] = attachments

//        print(dictionary)
        
        self.cnicNumber = cnicNumber
        self.mobileNumber = mobileNumber
        self.isPrimary = isPrimary
        self.customerTypeID = customerTypeID
        self.customerBranch = customerBranch
        self.bankingModeID = bankingModeID
        self.dateOfIssue = dateOfIssue
        self.dateOfBirth = dateOfBirth
        self.isPrimaryRegistered = isPrimaryRegistered
        self.portedMobileNetwork = portedMobileNetwork
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.attachments = attachments
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        cnicNumber <- map[CodingKeys.cnicNumber.rawValue]
        mobileNumber <- map[CodingKeys.mobileNumber.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        bankingModeID <- map[CodingKeys.bankingModeID.rawValue]
        dateOfIssue <- map[CodingKeys.dateOfIssue.rawValue]
        dateOfBirth <- map[CodingKeys.dateOfBirth.rawValue]
        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
        attachments <- map[CodingKeys.attachments.rawValue]
        isPrimaryRegistered <- map[CodingKeys.isPrimaryRegistered.rawValue]
        portedMobileNetwork <- map[CodingKeys.portedMobileNetwork.rawValue]
    }
}
