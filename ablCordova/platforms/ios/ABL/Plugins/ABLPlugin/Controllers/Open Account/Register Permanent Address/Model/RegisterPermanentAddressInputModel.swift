//
//  RegisterPermanentAddressInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 5/24/22.
//

import ObjectMapper

final class RegisterMailAddressInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "data.rdaCustomerAccInfoId"
        case rdaCustomerId = "data.rdaCustomerId"
        case customerTypeId = "data.customerTypeId"
        case esoaInd = "data.esoaInd"
        case physicalCardInd = "data.physicalCardInd"
        case bankingModeId = "data.bankingModeId"
        case customerBranch = "data.customerBranch"
        case customerAccountTypeId = "data.customerAccountTypeId"
        case purposeOfAccountId = "data.purposeOfAccountId"
        case proofOfIncomeInd = "data.proofOfIncomeInd"
        case accountVariantId = "data.accountVariantId"
        case atmTypeId = "data.atmTypeId"
        case transAlertInd = "data.transAlertInd"
        case chequeBookReqInd = "data.chequeBookReqInd"
        case transactionalAlertId = "data.transactionalAlertId"
        case natureOfAccountId = "data.natureOfAccountId"
        case currencyTypeId = "data.currencyTypeId"
        case pdaRemitterDetailList = "data.pdaRemitterDetailList"
        case noOfJointApplicatns = "data.noOfJointApplicatns"
        case mailingAddrPrefId = "data.mailingAddrPrefId"
        case reasonForVisaDebitCardRequestId = "data.reasonForVisaDebitCardRequestId"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerId: Double?
    var customerTypeId: Double?
    var esoaInd: Int?
    var physicalCardInd: Int?
    var bankingModeId: Double?
    var customerBranch: String?
    var customerAccountTypeId: Double?
    var purposeOfAccountId: Double?
    var proofOfIncomeInd: Int?
    var accountVariantId: Double?
    var atmTypeId: Double?
    var transAlertInd: Int?
    var chequeBookReqInd: Int?
    var transactionalAlertId: Double?
    var natureOfAccountId: Double?
    var currencyTypeId: Double?
    var pdaRemitterDetailList: [Int]?
    var noOfJointApplicatns: Int?
    var mailingAddrPrefId: Double?
    var reasonForVisaDebitCardRequestId: Double?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double?,
        rdaCustomerId: Double?,
        customerTypeId: Double?,
        esoaInd: Int?,
        physicalCardInd: Int?,
        bankingModeId: Double?,
        customerBranch: String?,
        customerAccountTypeId: Double?,
        purposeOfAccountId: Double?,
        proofOfIncomeInd: Int?,
        accountVariantId: Double?,
        atmTypeId: Double?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertId: Double?,
        natureOfAccountId: Double?,
        currencyTypeId: Double?,
        pdaRemitterDetailList: [Int]?,
        noOfJointApplicatns: Int?,
        mailingAddrPrefId: Double?,
        reasonForVisaDebitCardRequestId: Double?
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        dictionary[CodingKeys.esoaInd.rawValue] = esoaInd
        dictionary[CodingKeys.physicalCardInd.rawValue] = physicalCardInd
        dictionary[CodingKeys.bankingModeId.rawValue] = bankingModeId
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.customerAccountTypeId.rawValue] = customerAccountTypeId
        dictionary[CodingKeys.purposeOfAccountId.rawValue] = purposeOfAccountId
        dictionary[CodingKeys.proofOfIncomeInd.rawValue] = proofOfIncomeInd
        dictionary[CodingKeys.accountVariantId.rawValue] = accountVariantId
        dictionary[CodingKeys.atmTypeId.rawValue] = atmTypeId
        dictionary[CodingKeys.transAlertInd.rawValue] = transAlertInd
        dictionary[CodingKeys.chequeBookReqInd.rawValue] = chequeBookReqInd
        dictionary[CodingKeys.transactionalAlertId.rawValue] = transactionalAlertId
        dictionary[CodingKeys.natureOfAccountId.rawValue] = natureOfAccountId
        dictionary[CodingKeys.currencyTypeId.rawValue] = currencyTypeId
        dictionary[CodingKeys.pdaRemitterDetailList.rawValue] = pdaRemitterDetailList
        dictionary[CodingKeys.noOfJointApplicatns.rawValue] = noOfJointApplicatns
        dictionary[CodingKeys.mailingAddrPrefId.rawValue] = mailingAddrPrefId
        dictionary[CodingKeys.reasonForVisaDebitCardRequestId.rawValue] = reasonForVisaDebitCardRequestId
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerId = rdaCustomerId
        self.customerTypeId = customerTypeId
        self.esoaInd = esoaInd
        self.physicalCardInd = physicalCardInd
        self.bankingModeId = bankingModeId
        self.customerBranch = customerBranch
        self.customerAccountTypeId = customerAccountTypeId
        self.purposeOfAccountId = purposeOfAccountId
        self.proofOfIncomeInd = proofOfIncomeInd
        self.accountVariantId = accountVariantId
        self.atmTypeId = atmTypeId
        self.transAlertInd = transAlertInd
        self.chequeBookReqInd = chequeBookReqInd
        self.transactionalAlertId = transactionalAlertId
        self.natureOfAccountId = natureOfAccountId
        self.currencyTypeId = currencyTypeId
        self.pdaRemitterDetailList = pdaRemitterDetailList
        self.noOfJointApplicatns = noOfJointApplicatns
        self.mailingAddrPrefId = mailingAddrPrefId
        self.reasonForVisaDebitCardRequestId = reasonForVisaDebitCardRequestId
        
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
        esoaInd <- map[CodingKeys.esoaInd.rawValue]
        physicalCardInd <- map[CodingKeys.physicalCardInd.rawValue]
        bankingModeId <- map[CodingKeys.bankingModeId.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        customerAccountTypeId <- map[CodingKeys.customerAccountTypeId.rawValue]
        purposeOfAccountId <- map[CodingKeys.purposeOfAccountId.rawValue]
        proofOfIncomeInd <- map[CodingKeys.proofOfIncomeInd.rawValue]
        accountVariantId <- map[CodingKeys.accountVariantId.rawValue]
        atmTypeId <- map[CodingKeys.atmTypeId.rawValue]
        transAlertInd <- map[CodingKeys.transAlertInd.rawValue]
        chequeBookReqInd <- map[CodingKeys.chequeBookReqInd.rawValue]
        transactionalAlertId <- map[CodingKeys.transactionalAlertId.rawValue]
        natureOfAccountId <- map[CodingKeys.natureOfAccountId.rawValue]
        currencyTypeId <- map[CodingKeys.currencyTypeId.rawValue]
        pdaRemitterDetailList <- map[CodingKeys.pdaRemitterDetailList.rawValue]
        noOfJointApplicatns <- map[CodingKeys.noOfJointApplicatns.rawValue]
        mailingAddrPrefId <- map[CodingKeys.mailingAddrPrefId.rawValue]
        reasonForVisaDebitCardRequestId <- map[CodingKeys.reasonForVisaDebitCardRequestId.rawValue]
    }
}
