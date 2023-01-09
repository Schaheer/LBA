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
        case countryOfTaxResidenceId
    }
    
    // MARK: - Model Properties
    
    var explanation: String?
    var rdaCustomerID: Double?
    var taxIdentityNo: String?
    var tinReasonID: Double?
    var taxResidentInd: Int?
    var countryOfTaxResidenceId: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        explanation: String,
        rdaCustomerID: Double,
        taxIdentityNo: String,
        tinReasonID: Double,
        taxResidentInd: Int,
        countryOfTaxResidenceId: String
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.explanation.rawValue] = explanation
        dictionary[CodingKeys.rdaCustomerID.rawValue] = rdaCustomerID
        dictionary[CodingKeys.taxIdentityNo.rawValue] = taxIdentityNo
        dictionary[CodingKeys.tinReasonID.rawValue] = tinReasonID
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.countryOfTaxResidenceId.rawValue] = countryOfTaxResidenceId

        self.explanation = explanation
        self.rdaCustomerID = rdaCustomerID
        self.taxIdentityNo = taxIdentityNo
        self.tinReasonID = tinReasonID
        self.taxResidentInd = taxResidentInd
        self.countryOfTaxResidenceId = countryOfTaxResidenceId
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
        countryOfTaxResidenceId <- map[CodingKeys.countryOfTaxResidenceId.rawValue]
    }
}
