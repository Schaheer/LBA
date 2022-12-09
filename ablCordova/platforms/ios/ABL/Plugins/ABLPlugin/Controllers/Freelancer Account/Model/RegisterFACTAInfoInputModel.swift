//
//  RegisterFACTAInfoInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/27/22.
//

import ObjectMapper

final class RegisterFACTAInfoInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case fatcaReqDtoList = "data.fatcaReqDtoList"

    }
    
    // MARK: - Model Properties
    
    var fatcaReqDtoList: [FatcaReqDtoList]?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        fatcaReqDtoList: [FatcaReqDtoList]

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.fatcaReqDtoList.rawValue] = fatcaReqDtoList

        
        self.fatcaReqDtoList = fatcaReqDtoList

        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        fatcaReqDtoList <- map[CodingKeys.fatcaReqDtoList.rawValue]

    }
}


final class FatcaReqDtoList: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case attorneyInd = "attorneyInd"
        case birthUSInd = "birthUSInd"
        case careAddrInd = "careAddrInd"
        case greenCardHolderInd = "greenCardHolderInd"
        case rdaCustomerId = "rdaCustomerId"
        case usCitizenInd = "usCitizenInd"
        case usMailAddrInd = "usMailAddrInd"
        case usTaxResidentInd = "usTaxResidentInd"
    }
    
    // MARK: - Model Properties
    
    var attorneyInd: Int?
    var birthUSInd: Int?
    var careAddrInd: Int?
    var greenCardHolderInd: Int?
    var rdaCustomerId: Double?
    var usCitizenInd: Int?
    var usMailAddrInd: Int?
    var usTaxResidentInd: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
    attorneyInd: Int,
    birthUSInd: Int,
    careAddrInd: Int,
    greenCardHolderInd: Int,
    rdaCustomerId: Double,
    usCitizenInd: Int,
    usMailAddrInd: Int,
    usTaxResidentInd: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.attorneyInd.rawValue] = attorneyInd
        dictionary[CodingKeys.birthUSInd.rawValue] = birthUSInd
        dictionary[CodingKeys.careAddrInd.rawValue] = careAddrInd
        dictionary[CodingKeys.greenCardHolderInd.rawValue] = greenCardHolderInd
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.usCitizenInd.rawValue] = usCitizenInd
        dictionary[CodingKeys.usMailAddrInd.rawValue] = usMailAddrInd
        dictionary[CodingKeys.usTaxResidentInd.rawValue] = usTaxResidentInd
        
        self.attorneyInd = attorneyInd
        self.birthUSInd = birthUSInd
        self.careAddrInd = careAddrInd
        self.greenCardHolderInd = greenCardHolderInd
        self.rdaCustomerId = rdaCustomerId
        self.usCitizenInd = usCitizenInd
        self.usMailAddrInd = usMailAddrInd
        self.usTaxResidentInd = usTaxResidentInd
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        attorneyInd <- map[CodingKeys.attorneyInd.rawValue]
        birthUSInd <- map[CodingKeys.birthUSInd.rawValue]
        careAddrInd <- map[CodingKeys.careAddrInd.rawValue]
        greenCardHolderInd <- map[CodingKeys.greenCardHolderInd.rawValue]
        rdaCustomerId <- map[CodingKeys.rdaCustomerId.rawValue]
        usCitizenInd <- map[CodingKeys.usCitizenInd.rawValue]
        usMailAddrInd <- map[CodingKeys.usMailAddrInd.rawValue]
        usTaxResidentInd <- map[CodingKeys.usTaxResidentInd.rawValue]
    }
}
