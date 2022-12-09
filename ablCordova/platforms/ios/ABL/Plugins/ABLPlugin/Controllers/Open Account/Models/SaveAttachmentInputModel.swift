//
//  SaveAttachmentInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/19/22.
//

import ObjectMapper

final class SaveAttachmentInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "data.rdaCustomerAccInfoId"
        case attachmentTypeId = "data.attachmentTypeId"
        case entityId = "data.entityId"
        case fileName = "data.fileName"
        case mimeType = "data.mimeType"
        case path = "data.path"
        case base64Content = "data.base64Content"

    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var attachmentTypeId: Double?
    var entityId: Double?
    var fileName: String?
    var mimeType: String?
    var path: String?
    var base64Content: String?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        attachmentTypeId: Double,
        entityId: Double,
        fileName: String,
        mimeType: String,
        path: String,
        base64Content: String

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.attachmentTypeId.rawValue] = attachmentTypeId
        dictionary[CodingKeys.entityId.rawValue] = entityId
        dictionary[CodingKeys.fileName.rawValue] = fileName
        dictionary[CodingKeys.mimeType.rawValue] = mimeType
        dictionary[CodingKeys.path.rawValue] = path
        dictionary[CodingKeys.base64Content.rawValue] = base64Content

        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.attachmentTypeId = attachmentTypeId
        self.entityId = entityId
        self.fileName = fileName
        self.mimeType = mimeType
        self.path = path
        self.base64Content = base64Content

        
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
        attachmentTypeId <- map[CodingKeys.attachmentTypeId.rawValue]
        entityId <- map[CodingKeys.entityId.rawValue]
        fileName <- map[CodingKeys.fileName.rawValue]
        mimeType <- map[CodingKeys.mimeType.rawValue]
        path <- map[CodingKeys.path.rawValue]
        base64Content <- map[CodingKeys.base64Content.rawValue]

    }
}
