//
//  RequestBiometricVerificationInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

final class RequestBiometricInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case cnic = "data.cnic"
        case accountNumber = "data.accountNo"
    }
    
    // MARK: - Model Properties
    
    var cnic: String?
    var accountNumber: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(cnic: String, accountNumber: String) {
        
        var dictionary = [String: Any]()
        dictionary[CodingKeys.cnic.rawValue] = cnic
        dictionary[CodingKeys.accountNumber.rawValue] = accountNumber
        
        self.cnic = cnic
        self.accountNumber = accountNumber
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        
        let dictionary = [String: Any]()
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        cnic <- map[CodingKeys.cnic.rawValue]
        accountNumber <- map[CodingKeys.accountNumber.rawValue]
    }
}
