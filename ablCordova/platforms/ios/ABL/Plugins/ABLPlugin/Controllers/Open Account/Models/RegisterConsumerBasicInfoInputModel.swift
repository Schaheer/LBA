//
//  RegisterConsumerBasicInfoInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/13/22.
//

import ObjectMapper

final class RegisterConsumerBasicInfoInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"
        case residentCountries = "data.residentCountries"
    }
    
    // MARK: - Model Properties
    
    var consumerList: [BasicInfoConsumerListInputModel]?
    var residentCountries: [BasicInfoResidentCountriesInputModel]?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [BasicInfoConsumerListInputModel]
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.consumerList.rawValue] = consumerList
        
        self.consumerList = consumerList
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        consumerList: [BasicInfoConsumerListInputModel],
        residentCountries: [BasicInfoResidentCountriesInputModel]
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.consumerList.rawValue] = consumerList
        dictionary[CodingKeys.residentCountries.rawValue] = residentCountries
        
        self.consumerList = consumerList
        self.residentCountries = residentCountries
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        consumerList <- map[CodingKeys.consumerList.rawValue]
        residentCountries <- map[CodingKeys.residentCountries.rawValue]
    }
}


