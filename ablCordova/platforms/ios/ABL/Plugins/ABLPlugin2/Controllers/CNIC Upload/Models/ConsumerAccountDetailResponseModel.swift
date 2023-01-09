//
//  ConsumerAccountDetailResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 11/04/2022.
//

import ObjectMapper

final class ConsumerAccountDetailResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"
        case noOfJointApplicants = "data.noOfJointApplicatns"
        case channelID = "data.channelId"
        case sessionTimeout = "data.sessionTimeout"
        case pdaRemitterDetailList = "data.pdaRemitterDetailList"
    }
    
    // MARK: - Model Properties
    
    var consumerList: [ConsumerListResponseModel]?
    var noOfJointApplicants: Int?
    var channelID: Double?
    var sessionTimeout: Int?
    var pdaRemitterDetailList: [Any]?
    
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
        
        consumerList <- map[CodingKeys.consumerList.rawValue]
        noOfJointApplicants <- map[CodingKeys.noOfJointApplicants.rawValue]
        channelID <- map[CodingKeys.channelID.rawValue]
        sessionTimeout <- map[CodingKeys.sessionTimeout.rawValue]
        pdaRemitterDetailList <- map[CodingKeys.pdaRemitterDetailList.rawValue]
    }
}
