//
//  RegisterConsumerAccountInfoInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/04/2022.
//

import ObjectMapper

final class RegisterConsumerAccountInfoInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoID = "data.rdaCustomerAccInfoId"
        case rdaCustomerID = "data.rdaCustomerId"
        case customerTypeID = "data.customerTypeId"
        case physicalCardInd = "data.physicalCardInd"
        case bankingModeID = "data.bankingModeId"
        case customerBranch = "data.customerBranch"
        case customerAccountTypeID = "data.customerAccountTypeId"
        case purposeOfAccountID = "data.purposeOfAccountId"
        case proofOfIncomeInd = "data.proofOfIncomeInd"
        case accountVariantID = "data.accountVariantId"
        case atmTypeID = "data.atmTypeID"
        case transAlertInd = "data.transAlertInd"
        case chequeBookReqInd = "data.chequeBookReqInd"
        case transactionalAlertID = "data.transactionalAlertId"
        case natureOfAccountID = "data.natureOfAccountId"
        case pdaRemitterDetailList = "data.pdaRemitterDetailList"
        case noOfJointApplicants = "data.noOfJointApplicatns"
        case eSOAInd = "data.esoaInd"
        case genderId = "data.genderId"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoID: Any?
    var rdaCustomerID: Int?
    var bankingModeID: Double?
    var customerAccountTypeID: Double?
    var customerBranch: String?
    var customerTypeID: Double?
    var purposeOfAccountID: Double?
    var proofOfIncomeInd: Int?
    var accountVariantID: Double?
    var atmTypeID: Double?
    var transAlertInd: Int?
    var chequeBookReqInd: Int?
    var transactionalAlertID: Double?
    var natureOfAccountID: Double?
    var pdaRemitterDetailList: [PDARemitterDetailInputModel]?
    var noOfJointApplicants: Int?
    var eSOAInd: Int?
    var genderId: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoID: Any?,
        rdaCustomerID: Int,
        bankingModeID: Double,
        customerAccountTypeID: Double,
        customerBranch: String,
        customerTypeID: Double,
        purposeOfAccountID: Double,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoID.rawValue] = rdaCustomerAccInfoID
        dictionary[CodingKeys.rdaCustomerID.rawValue] = rdaCustomerID
        dictionary[CodingKeys.bankingModeID.rawValue] = bankingModeID
        dictionary[CodingKeys.customerAccountTypeID.rawValue] = customerAccountTypeID
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.purposeOfAccountID.rawValue] = purposeOfAccountID
        dictionary[CodingKeys.genderId.rawValue] = genderId
        
        self.rdaCustomerAccInfoID = rdaCustomerAccInfoID
        self.rdaCustomerID = rdaCustomerID
        self.bankingModeID = bankingModeID
        self.customerAccountTypeID = customerAccountTypeID
        self.customerBranch = customerBranch
        self.customerTypeID = customerTypeID
        self.purposeOfAccountID = purposeOfAccountID
        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoID: Any?,
        rdaCustomerID: Int,
        bankingModeID: Double,
        customerAccountTypeID: Double,
        customerBranch: String,
        customerTypeID: Double,
        proofOfIncomeInd: Int,
        accountVariantID: Double,
        genderId: Int
    ) {
        
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoID.rawValue] = rdaCustomerAccInfoID
        dictionary[CodingKeys.rdaCustomerID.rawValue] = rdaCustomerID
        dictionary[CodingKeys.bankingModeID.rawValue] = bankingModeID
        dictionary[CodingKeys.customerAccountTypeID.rawValue] = customerAccountTypeID
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.proofOfIncomeInd.rawValue] = proofOfIncomeInd
        dictionary[CodingKeys.accountVariantID.rawValue] = accountVariantID
        dictionary[CodingKeys.genderId.rawValue] = genderId
        print(dictionary)
        self.rdaCustomerAccInfoID = rdaCustomerAccInfoID
        self.rdaCustomerID = rdaCustomerID
        self.bankingModeID = bankingModeID
        self.customerAccountTypeID = customerAccountTypeID
        self.customerBranch = customerBranch
        self.customerTypeID = customerTypeID
        self.proofOfIncomeInd = proofOfIncomeInd
        self.accountVariantID = accountVariantID
        self.genderId = genderId
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoID: Any?,
        rdaCustomerID: Int,
        bankingModeID: Double,
        customerAccountTypeID: Double,
        customerBranch: String,
        customerTypeID: Double,
        proofOfIncomeInd: Int,
        purposeOfAccountID: Double,
        accountVariantID: Double,
        atmTypeID: Double?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertID: Double?,
        natureOfAccountID: Double?,
        pdaRemitterDetailList: [PDARemitterDetailInputModel],
        noOfJointApplicants: Int?,
        genderId: Int?
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoID.rawValue] = rdaCustomerAccInfoID
        dictionary[CodingKeys.rdaCustomerID.rawValue] = rdaCustomerID
        dictionary[CodingKeys.bankingModeID.rawValue] = bankingModeID
        dictionary[CodingKeys.customerAccountTypeID.rawValue] = customerAccountTypeID
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.proofOfIncomeInd.rawValue] = proofOfIncomeInd
        dictionary[CodingKeys.purposeOfAccountID.rawValue] = purposeOfAccountID
        dictionary[CodingKeys.accountVariantID.rawValue] = accountVariantID
        dictionary[CodingKeys.atmTypeID.rawValue] = atmTypeID
        dictionary[CodingKeys.transAlertInd.rawValue] = transAlertInd
        dictionary[CodingKeys.chequeBookReqInd.rawValue] = chequeBookReqInd
        dictionary[CodingKeys.transactionalAlertID.rawValue] = transactionalAlertID
        dictionary[CodingKeys.natureOfAccountID.rawValue] = natureOfAccountID
        dictionary[CodingKeys.pdaRemitterDetailList.rawValue] = pdaRemitterDetailList
        dictionary[CodingKeys.noOfJointApplicants.rawValue] = noOfJointApplicants
        dictionary[CodingKeys.genderId.rawValue] = genderId
        
        self.rdaCustomerAccInfoID = rdaCustomerAccInfoID
        self.rdaCustomerID = rdaCustomerID
        self.bankingModeID = bankingModeID
        self.customerAccountTypeID = customerAccountTypeID
        self.customerBranch = customerBranch
        self.customerTypeID = customerTypeID
        self.proofOfIncomeInd = proofOfIncomeInd
        self.purposeOfAccountID = purposeOfAccountID
        self.accountVariantID = accountVariantID
        self.atmTypeID = atmTypeID
        self.transAlertInd = transAlertInd
        self.chequeBookReqInd = chequeBookReqInd
        self.transactionalAlertID = transactionalAlertID
        self.natureOfAccountID = natureOfAccountID
        self.pdaRemitterDetailList = pdaRemitterDetailList
        self.noOfJointApplicants = noOfJointApplicants
        self.genderId = genderId
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoID: Any?,
        rdaCustomerID: Int,
        customerTypeID: Double,
        transAlertInd: Int,
        transactionalAlertID: Double,
        eSOAInd: Int,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoID.rawValue] = rdaCustomerAccInfoID
        dictionary[CodingKeys.rdaCustomerID.rawValue] = rdaCustomerID
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.transAlertInd.rawValue] = transAlertInd
        dictionary[CodingKeys.transactionalAlertID.rawValue] = transactionalAlertID
        dictionary[CodingKeys.eSOAInd.rawValue] = eSOAInd
        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoID = rdaCustomerAccInfoID
        self.rdaCustomerID = rdaCustomerID
        self.customerTypeID = customerTypeID
        self.transAlertInd = transAlertInd
        self.transactionalAlertID = transactionalAlertID
        self.eSOAInd = eSOAInd
        self.genderId = genderId
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        rdaCustomerAccInfoID <- map[CodingKeys.rdaCustomerAccInfoID.rawValue]
        rdaCustomerID <- map[CodingKeys.rdaCustomerID.rawValue]
        bankingModeID <- map[CodingKeys.bankingModeID.rawValue]
        customerAccountTypeID <- map[CodingKeys.customerAccountTypeID.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        purposeOfAccountID <- map[CodingKeys.purposeOfAccountID.rawValue]
        proofOfIncomeInd <- map[CodingKeys.proofOfIncomeInd.rawValue]
        accountVariantID <- map[CodingKeys.accountVariantID.rawValue]
        atmTypeID <- map[CodingKeys.atmTypeID.rawValue]
        transAlertInd <- map[CodingKeys.transAlertInd.rawValue]
        chequeBookReqInd <- map[CodingKeys.chequeBookReqInd.rawValue]
        transactionalAlertID <- map[CodingKeys.transactionalAlertID.rawValue]
        natureOfAccountID <- map[CodingKeys.natureOfAccountID.rawValue]
        pdaRemitterDetailList <- map[CodingKeys.pdaRemitterDetailList.rawValue]
        noOfJointApplicants <- map[CodingKeys.noOfJointApplicants.rawValue]
        eSOAInd <- map[CodingKeys.eSOAInd.rawValue]
        genderId <- map[CodingKeys.genderId.rawValue]
    }
}
