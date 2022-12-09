//
//  RegisterVerifyOTPInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class RegisterVerifyOTPInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"
        case noOfJointApplicants = "data.noOfJointApplicatns"
        case bioMetricVerificationNadraMobileReq = "data.bioMetricVerificationNadraMobileReq"
        case channelId = "data.channelId"
        case customerTypeId = "data.customerTypeId"
    }
    
    // MARK: - Model Properties
    
    var consumerList: [ConsumerListInputModel]?
    var noOfJointApplicants: Int?
    var bioMetricVerificationNadraMobileReq: VerifyBiometricNadraInputData?
    var channelId: Double?
    var customerTypeId: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [ConsumerListInputModel],
        noOfJointApplicants: Int,
        bioMetricVerificationNadraMobileReq: VerifyBiometricNadraInputData?,
        channelId: Double,
        customerTypeId: Double
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.consumerList.rawValue] = consumerList
        dictionary[CodingKeys.noOfJointApplicants.rawValue] = noOfJointApplicants
        dictionary[CodingKeys.bioMetricVerificationNadraMobileReq.rawValue] = bioMetricVerificationNadraMobileReq
        dictionary[CodingKeys.channelId.rawValue] = channelId
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        
        self.consumerList = consumerList
        self.noOfJointApplicants = noOfJointApplicants
        self.bioMetricVerificationNadraMobileReq = bioMetricVerificationNadraMobileReq
        self.channelId = channelId
        self.customerTypeId = customerTypeId
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
        noOfJointApplicants <- map[CodingKeys.noOfJointApplicants.rawValue]
        bioMetricVerificationNadraMobileReq <- map[CodingKeys.bioMetricVerificationNadraMobileReq.rawValue]
        channelId <- map[CodingKeys.channelId.rawValue]
        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
    }
}
