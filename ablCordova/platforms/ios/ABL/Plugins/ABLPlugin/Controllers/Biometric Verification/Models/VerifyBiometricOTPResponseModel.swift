//
//  VerifyOTPResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

final class VerifyBiometricOTPResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerProfileID = "data.rdaCustomerProfileId"
        case rdaCustomerAccInfoID = "data.rdaCustomerAccInfoId"
        case otp = "data.otp"
        case customerTypeID = "data.customerTypeId"
        case messageData = "data.message"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerProfileID: Int?
    var rdaCustomerAccInfoID: Double?
    var otp: String?
    var customerTypeID: Int?
    var messageData: String?
    
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
        
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
        rdaCustomerAccInfoID <- map[CodingKeys.rdaCustomerAccInfoID.rawValue]
        otp <- map[CodingKeys.otp.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        messageData <- map[CodingKeys.messageData.rawValue]
    }
}
