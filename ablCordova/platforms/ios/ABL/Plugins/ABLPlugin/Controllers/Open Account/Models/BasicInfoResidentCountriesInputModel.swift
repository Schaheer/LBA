//
//  BasicInfoResidentCountriesInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/04/2022.
//

import ObjectMapper

final class BasicInfoResidentCountriesInputModel: BaseInputModel {
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case explanation
        case rdaCustomerID = "rdaCustomerId"
        case taxIdentityNo
        case tinReasonID = "tinReasonId"
        case taxResidentInd
    }
    
    // MARK: - Model Properties
    
    var explanation: String?
    var rdaCustomerID: Double?
    var taxIdentityNo: String?
    var tinReasonID: Double?
    var taxResidentInd: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        explanation: String,
        rdaCustomerID: Double,
        taxIdentityNo: String,
        tinReasonID: Double,
        taxResidentInd: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.explanation.rawValue] = explanation
        dictionary[CodingKeys.rdaCustomerID.rawValue] = rdaCustomerID
        dictionary[CodingKeys.taxIdentityNo.rawValue] = taxIdentityNo
        dictionary[CodingKeys.tinReasonID.rawValue] = tinReasonID
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        
        self.explanation = explanation
        self.rdaCustomerID = rdaCustomerID
        self.taxIdentityNo = taxIdentityNo
        self.tinReasonID = tinReasonID
        self.taxResidentInd = taxResidentInd
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        explanation <- map[CodingKeys.explanation.rawValue]
        rdaCustomerID <- map[CodingKeys.rdaCustomerID.rawValue]
        taxIdentityNo <- map[CodingKeys.taxIdentityNo.rawValue]
        tinReasonID <- map[CodingKeys.tinReasonID.rawValue]
        taxResidentInd <- map[CodingKeys.taxResidentInd.rawValue]
    }
}
