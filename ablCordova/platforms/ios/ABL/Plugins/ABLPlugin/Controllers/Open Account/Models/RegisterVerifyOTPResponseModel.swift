//
//  RegisterVerifyOTPResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class RegisterVerifyOTPResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"
        case noOfJointApplicants = "data.noOfJointApplicatns"
        case sessionTimeout = "data.sessionTimeout"
        case pdaRemitterDetailList = "data.pdaRemitterDetailList"
    }
    
    // MARK: - Model Properties
    
    var consumerList: [ConsumerListResponseModel]?
    var noOfJointApplicants: Int?
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
        consumerList?.first?.rdaCustomerProfileID
        noOfJointApplicants <- map[CodingKeys.noOfJointApplicants.rawValue]
        sessionTimeout <- map[CodingKeys.sessionTimeout.rawValue]
        pdaRemitterDetailList <- map[CodingKeys.pdaRemitterDetailList.rawValue]
    }
}
