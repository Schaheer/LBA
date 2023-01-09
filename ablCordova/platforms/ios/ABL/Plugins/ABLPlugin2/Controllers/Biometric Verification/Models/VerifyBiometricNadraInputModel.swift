//
//  VerifyBiometricNadraInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 3/15/22.
//

import Foundation
import ObjectMapper

class VerifyBiometricNadraInputModel: BaseInputModel {

    var data: VerifyBiometricNadraInputData?

    enum CodingKeys: String {
        case data = "data"

    }

    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(data: VerifyBiometricNadraInputData) {
        
        var dictionary = [String: Any]()
        dictionary[CodingKeys.data.rawValue] = data
        
        self.data = data
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        
        let dictionary = [String: Any]()
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        data <- map[CodingKeys.data.rawValue]
    }

}

class VerifyBiometricNadraInputData: BaseInputModel {

    enum CodingKeys: String {
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case rdaCustomerAccountInfoId = "rdaCustomerAccountInfoId"
        case cnic = "cnic"
        case fingerprints = "fingerprints"
        case templateType = "templateType"
        case contactNumber = "contactNumber"
        case areaName = "areaName"
        case accountType = "accountType"
        case latitude = "latitude"
        case longitude = "longitude"
        case imei = "imei"

    }
    
    
    var rdaCustomerProfileId: Double?
    var rdaCustomerAccountInfoId: Double?
    var cnic: String?
    var fingerprints: [Fingerprints]?
    var templateType: String?
    var contactNumber: String?
    var areaName: String?
    var accountType: String?
    var latitude: Double?
    var longitude: Double?
    var imei: String?

    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(rdaCustomerProfileId: Double?, rdaCustomerAccountInfoId: Double?, cnic: String, fingerprints: [Fingerprints]?, templateType: String, contactNumber: String, areaName: String, accountType: String, latitude: Double?, longitude: Double?, imei: String?) {
        
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.rdaCustomerAccountInfoId.rawValue] = rdaCustomerAccountInfoId
        dictionary[CodingKeys.cnic.rawValue] = cnic
        dictionary[CodingKeys.templateType.rawValue] = templateType
        dictionary[CodingKeys.contactNumber.rawValue] = contactNumber
        dictionary[CodingKeys.areaName.rawValue] = areaName
        dictionary[CodingKeys.accountType.rawValue] = accountType
        dictionary[CodingKeys.fingerprints.rawValue] = fingerprints
        dictionary[CodingKeys.latitude.rawValue] = latitude
        dictionary[CodingKeys.longitude.rawValue] = longitude
        dictionary[CodingKeys.imei.rawValue] = imei
        
        
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.rdaCustomerAccountInfoId = rdaCustomerAccountInfoId
        self.cnic = cnic
        self.fingerprints = fingerprints
        self.templateType = templateType
        self.contactNumber = contactNumber
        self.areaName = areaName
        self.accountType = accountType
        self.latitude = latitude
        self.longitude = longitude
        self.imei = imei
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        
        let dictionary = [String: Any]()
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        rdaCustomerAccountInfoId <- map[CodingKeys.rdaCustomerAccountInfoId.rawValue]
        cnic <- map[CodingKeys.cnic.rawValue]
        fingerprints <- map[CodingKeys.fingerprints.rawValue]
        templateType <- map[CodingKeys.templateType.rawValue]
        contactNumber <- map[CodingKeys.contactNumber.rawValue]
        areaName <- map[CodingKeys.areaName.rawValue]
        accountType <- map[CodingKeys.accountType.rawValue]
        latitude <- map[CodingKeys.latitude.rawValue]
        longitude <- map[CodingKeys.longitude.rawValue]
        imei <- map[CodingKeys.imei.rawValue]
    }
}


//struct Fingerprints {
//
//    var index: String
//    var template: String
//
//    var params: [String: Any] {
//
//        return [
//
//            "index": index,
//            "template": template
//
//        ]
//
//    }
//
//}

class Fingerprints: BaseInputModel {

    enum CodingKeys: String {
        case index = "index"
        case template = "template"

    }

    var index: String?
    var template: String?

    // MARK: - Model Initializers

    required init?(map: Map) {
        super.init(map: map)
        
    }

    required init?(index: String, template: String) {

        var dictionary = [String: Any]()
        dictionary[CodingKeys.index.rawValue] = index
        dictionary[CodingKeys.template.rawValue] = template

        self.index = index
        self.template = template

        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }

    required init?() {

        let dictionary = [String: Any]()

        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }

    // MARK: - Model Mapping

    override func mapping(map: Map) {
        super.mapping(map: map)

        index <- map[CodingKeys.index.rawValue]
        template <- map[CodingKeys.template.rawValue]
    }
}


