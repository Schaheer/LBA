//
//  ViewAppGenerateOTPInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 24/03/2022.
//

import ObjectMapper

final class ViewAppGenerateOTPInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case customerTypeID = "data.customerTypeId"
        case cnicNumber = "data.idNumber"
        case mobileNumber = "data.mobileNo"
//        case mobileNetwork = "data.mobileNetwork"
        case isPortedMobileNetwork = "data.isPortedMobileNetwork"
        case generateOTP = "data.generateOtp"
        case attachments = "data.attachments"
        case dateofExpiry = "data.dateofExpiry"
        case dateOfIssue = "data.dateOfIssue"
        case dateOfBirth = "data.dateOfBirth"
    }
    
    // MARK: - Model Properties
    
    var customerTypeID: Double?
    var cnicNumber: String?
    var mobileNumber: String?
    var isPortedMobileNetwork: Bool?
    var generateOTP: Bool?
    var attachments: [CNICAttachmentInputModel]?
    var dateofExpiry: String?
    var dateOfIssue: String?
    var dateOfBirth: String?

    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        customerTypeID: Double,
        mobileNumber: String,
        generateOTP: Bool
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.generateOTP.rawValue] = generateOTP
        
        self.customerTypeID = customerTypeID
        self.mobileNumber = mobileNumber
        self.generateOTP = generateOTP
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        customerTypeID: Double,
        mobileNumber: String,
        generateOTP: Bool,
        attachments: [CNICAttachmentInputModel],
        isPortedMobileNetwork: Bool
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.generateOTP.rawValue] = generateOTP
        dictionary[CodingKeys.attachments.rawValue] = attachments
        dictionary[CodingKeys.isPortedMobileNetwork.rawValue] = isPortedMobileNetwork
        
        self.customerTypeID = customerTypeID
        self.mobileNumber = mobileNumber
        self.generateOTP = generateOTP
        self.attachments = attachments
        self.isPortedMobileNetwork = isPortedMobileNetwork
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        customerTypeID: Double,
        mobileNumber: String,
        generateOTP: Bool,
        cnicNumber: String,
        isPortedMobileNetwork: Bool
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.generateOTP.rawValue] = generateOTP
        dictionary[CodingKeys.cnicNumber.rawValue] = cnicNumber
        dictionary[CodingKeys.isPortedMobileNetwork.rawValue] = isPortedMobileNetwork
        
        self.customerTypeID = customerTypeID
        self.mobileNumber = mobileNumber
        self.generateOTP = generateOTP
        self.cnicNumber = cnicNumber
        self.isPortedMobileNetwork = isPortedMobileNetwork
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        customerTypeID: Double,
        mobileNumber: String,
        generateOTP: Bool,
        cnicNumber: String,
        dateOfIssue: String,
        dateOfBirth: String,
        isPortedMobileNetwork: Bool
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.generateOTP.rawValue] = generateOTP
        dictionary[CodingKeys.cnicNumber.rawValue] = cnicNumber
        dictionary[CodingKeys.dateOfIssue.rawValue] = dateOfIssue
        dictionary[CodingKeys.dateOfBirth.rawValue] = dateOfBirth
        dictionary[CodingKeys.isPortedMobileNetwork.rawValue] = isPortedMobileNetwork
        
        self.customerTypeID = customerTypeID
        self.mobileNumber = mobileNumber
        self.generateOTP = generateOTP
        self.cnicNumber = cnicNumber
        self.dateOfIssue = dateOfIssue
        self.dateOfBirth = dateOfBirth
        self.isPortedMobileNetwork = isPortedMobileNetwork
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        mobileNumber <- map[CodingKeys.mobileNumber.rawValue]
        generateOTP <- map[CodingKeys.generateOTP.rawValue]
        cnicNumber <- map[CodingKeys.cnicNumber.rawValue]
        attachments <- map[CodingKeys.attachments.rawValue]
        isPortedMobileNetwork <- map[CodingKeys.isPortedMobileNetwork.rawValue]
        dateofExpiry <- map[CodingKeys.dateofExpiry.rawValue]
        dateOfIssue <- map[CodingKeys.dateOfIssue.rawValue]
        dateOfBirth <- map[CodingKeys.dateOfBirth.rawValue]

    }
}
