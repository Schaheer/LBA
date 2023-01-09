//
//  RegisterConsumerAccountInfoResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/04/2022.
//

import ObjectMapper

final class RegisterConsumerAccountInfoResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case data
    }
    
    // MARK: - Model Properties
    
    var data: AccountInformationModel?
    
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
        
        data <- map[CodingKeys.data.rawValue]
    }
}
