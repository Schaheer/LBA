//
//  MobileNetworkResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 29/03/2022.
//

import ObjectMapper

final class MobileNetworkResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case data
    }
    
    // MARK: - Model Properties
    
    var data: [MobileNetworkDataModel]?
    
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
