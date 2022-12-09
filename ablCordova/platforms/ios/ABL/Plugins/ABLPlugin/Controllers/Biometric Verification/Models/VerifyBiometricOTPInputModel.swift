//
//  VerifyOTPInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

final class VerifyBiometricOTPInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case otp = "data.otp"
        case rdaCustomerProfileID = "data.rdaCustomerProfileId"
    }
    
    // MARK: - Model Properties
    
    var otp: String?
    var rdaCustomerProfileID: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(otp: String, rdaCustomerProfileID: Double) {
        
        var dictionary = [String: Any]()
        dictionary[CodingKeys.otp.rawValue] = otp
        dictionary[CodingKeys.rdaCustomerProfileID.rawValue] = rdaCustomerProfileID
        
        self.otp = otp
        self.rdaCustomerProfileID = rdaCustomerProfileID
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        
        let dictionary = [String: Any]()
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        otp <- map[CodingKeys.otp.rawValue]
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
    }
}
