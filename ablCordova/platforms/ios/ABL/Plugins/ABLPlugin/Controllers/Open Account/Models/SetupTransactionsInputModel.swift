//
//  SetupTransactionsInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/18/22.
//

import ObjectMapper



final class SetupTransactionsInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"

    }
    
    // MARK: - Model Properties
    
    var consumerList: [SetupTransactionDataInputModel]?


    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [SetupTransactionDataInputModel]


    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.consumerList.rawValue] = consumerList
        
        self.consumerList = consumerList
        
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


    }
}

final class SetupTransactionDataInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerId = "rdaCustomerId"
        case customerTypeId = "customerTypeId"
        case atmTypeId = "atmTypeId"
        case transAlertInd = "transAlertInd"
        case chequeBookReqInd = "chequeBookReqInd"
        case transactionalAlertId = "transactionalAlertId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"

    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerId: Double?
    var customerTypeId: Double?
    var atmTypeId: Double?
    var transAlertInd: Int?
    var chequeBookReqInd: Int?
    var transactionalAlertId: Double?
    var rdaCustomerProfileId: Double?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerId: Double,
        customerTypeId: Double,
        atmTypeId: Double,
        transAlertInd: Int,
        chequeBookReqInd: Int,
        transactionalAlertId: Double,
        rdaCustomerProfileId: Double

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        dictionary[CodingKeys.atmTypeId.rawValue] = atmTypeId
        dictionary[CodingKeys.transAlertInd.rawValue] = transAlertInd
        dictionary[CodingKeys.chequeBookReqInd.rawValue] = chequeBookReqInd
        dictionary[CodingKeys.transactionalAlertId.rawValue] = transactionalAlertId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId

        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerId = rdaCustomerId
        self.customerTypeId = customerTypeId
        self.atmTypeId = atmTypeId
        self.transAlertInd = transAlertInd
        self.chequeBookReqInd = chequeBookReqInd
        self.transactionalAlertId = transactionalAlertId
        self.rdaCustomerProfileId = rdaCustomerProfileId

        
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
        rdaCustomerId <- map[CodingKeys.rdaCustomerId.rawValue]
        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
        atmTypeId <- map[CodingKeys.atmTypeId.rawValue]
        transAlertInd <- map[CodingKeys.transAlertInd.rawValue]
        chequeBookReqInd <- map[CodingKeys.chequeBookReqInd.rawValue]
        transactionalAlertId <- map[CodingKeys.transactionalAlertId.rawValue]
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]

    }
}
