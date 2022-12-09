//
//  SaveAttachmentResponseModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/19/22.
//

import ObjectMapper

final class SaveAttachmentResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case data
    }
    
    // MARK: - Model Properties
    
    var data: [PurposeOfAccountDataModel]?
    
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
