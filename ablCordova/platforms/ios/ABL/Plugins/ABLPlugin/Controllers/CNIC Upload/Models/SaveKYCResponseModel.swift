//
//  SaveKYCResponseModel.swift
//  ABL
//
//  Created by Hamza Amin on 5/11/22.
//

import Foundation
import ObjectMapper


final class SaveKYCResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case fullName = "data.fullName"
        case customerNonResidentInd = "data.customerNonResidentInd"
        case rdaCustomerProfileID = "data.rdaCustomerProfileId"
        case emailAddress = "data.emailAddress"
        case accountVariantID = "data.accountVariantId"
        case currencyTypeID = "data.currencyTypeId"
        case accountTypeID = "data.accountTypeId"
        case customerInstructions = "data.customerInstructions"
        case customerOtpExpiration = "data.customerOtpExpiration"
        case idTypeID = "data.idTypeId"
        case idNumber = "data.idNumber"
        case nationalityTypeID = "data.nationalityTypeId"
        case natureOfAccountID = "data.natureOfAccountId"
        case otpExpiryMinutes = "data.otpExpiryMinutes"
        case nationalities = "data.nationalities"
        case otpCounter = "data.otpCounter"
        case isPrimary = "data.isPrimary"
        case customerTypeID = "data.customerTypeId"
        case mobileNo = "data.mobileNo"
        case dateOfBirth = "data.dateOfBirth"
        case mobileNetworkID = "data.mobileNetworkId"
        case portedMobileNetwork = "data.portedMobileNetwork"
        case attachments = "data.attachments"
        case primary = "data.primary"
        case alreadyExist = "data.alreadyExist"
    }
    
    // MARK: - Model Properties
    
    var fullName: String?
    var customerNonResidentInd: String?
    var rdaCustomerProfileID: Double?
    var emailAddress: String?
    var accountVariantID: Double?
    var currencyTypeID: Double?
    var accountTypeID: Double?
    var customerInstructions: String?
    var customerOtpExpiration: String?
    var idTypeID: Double?
    var idNumber: String?
    var nationalityTypeID: Double?
    var natureOfAccountID: Double?
    var otpExpiryMinutes: Int?
    var nationalities: String?
    var otpCounter: String?
    var isPrimary: Bool?
    var customerTypeID: Double?
    var mobileNo: String?
    var dateOfBirth: String?
    var mobileNetworkID: Double?
    var portedMobileNetwork: Bool?
//    var attachments: [CNICAttachmentInputModel]?
    var primary: String?
    var alreadyExist: Bool?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: MappingType.fromJSON, JSON: dictionary))
    }
    
    // MARK: Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        fullName <- map[CodingKeys.fullName.rawValue]
        customerNonResidentInd <- map[CodingKeys.customerNonResidentInd.rawValue]
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        accountVariantID <- map[CodingKeys.accountVariantID.rawValue]
        currencyTypeID <- map[CodingKeys.currencyTypeID.rawValue]
        accountTypeID <- map[CodingKeys.accountTypeID.rawValue]
        customerInstructions <- map[CodingKeys.customerInstructions.rawValue]
        customerOtpExpiration <- map[CodingKeys.customerOtpExpiration.rawValue]
        idTypeID <- map[CodingKeys.idTypeID.rawValue]
        idNumber <- map[CodingKeys.idNumber.rawValue]
        nationalityTypeID <- map[CodingKeys.nationalityTypeID.rawValue]
        natureOfAccountID <- map[CodingKeys.natureOfAccountID.rawValue]
        otpExpiryMinutes <- map[CodingKeys.otpExpiryMinutes.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        otpCounter <- map[CodingKeys.otpCounter.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        mobileNo <- map[CodingKeys.mobileNo.rawValue]
        dateOfBirth <- map[CodingKeys.dateOfBirth.rawValue]
        mobileNetworkID <- map[CodingKeys.mobileNetworkID.rawValue]
        portedMobileNetwork <- map[CodingKeys.portedMobileNetwork.rawValue]
//        attachments <- map[CodingKeys.attachments.rawValue]
        primary <- map[CodingKeys.primary.rawValue]
        alreadyExist <- map[CodingKeys.alreadyExist.rawValue]
    }
}
