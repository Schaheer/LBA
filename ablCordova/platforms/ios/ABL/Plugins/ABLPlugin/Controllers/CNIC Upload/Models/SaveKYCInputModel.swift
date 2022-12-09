//
//  SaveKYCInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 5/11/22.
//

import Foundation
import ObjectMapper

//{
//"data": [
//{
//"isPrimary": true,
//"rdaCustomerProfileId": 6502,
//"rdaCustomerAccInfoId": 6328,
//"averageMonthlySalary": "520000",
//"relationCode1": null
//},
//{
//"isPrimary": false,
//"rdaCustomerProfileId": 6504,
//"rdaCustomerAccInfoId": 6328,
//"averageMonthlySalary": "20000",
//"relationCode1": "108804"
//}
//]
//}


final class SaveKYCInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case data = "data.data"
    }
    
    // MARK: - Model Properties
    
    var data: [saveKYCObject]?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        data: [saveKYCObject]
    ) {
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


final class saveKYCObject: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case isPrimary = "isPrimary"
        case averageMonthlySalary = "averageMonthlySalary"
        case relationCode1 = "relationCode1"

    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var isPrimary: Bool?
    var averageMonthlySalary: String?
    var relationCode1: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double?,
        rdaCustomerProfileId: Double?,
        isPrimary: Bool?,
        relationCode1: Double?,
        averageMonthlySalary: String?
        
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.averageMonthlySalary.rawValue] = averageMonthlySalary
        dictionary[CodingKeys.relationCode1.rawValue] = relationCode1
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.averageMonthlySalary = averageMonthlySalary
        self.relationCode1 = relationCode1
        self.isPrimary = isPrimary
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        averageMonthlySalary <- map[CodingKeys.averageMonthlySalary.rawValue]
        relationCode1 <- map[CodingKeys.relationCode1.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
    }
}
