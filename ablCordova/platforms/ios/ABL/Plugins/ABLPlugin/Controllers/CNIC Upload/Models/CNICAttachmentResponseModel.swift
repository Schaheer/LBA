//
//  CNICAttachmentResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 15/04/2022.
//

import ObjectMapper

final class CNICAttachmentResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case fileName
        case base64Content
        case attachmentTypeID = "attachmentTypeId"
    }
    
    // MARK: - Model Properties
    
    var fileName: String?
    var base64Content: String?
    var attachmentTypeID: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        fileName <- map[CodingKeys.fileName.rawValue]
        base64Content <- map[CodingKeys.base64Content.rawValue]
        attachmentTypeID <- map[CodingKeys.attachmentTypeID.rawValue]
    }
}
