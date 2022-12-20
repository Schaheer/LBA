//
//  AccountInformationModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class AccountInformationModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoID = "rdaCustomerAccInfoId"
        case rdaCustomerID = "rdaCustomerId"
        case purposeOfAccountID = "purposeOfAccountId"
        case purposeOfAccount
        case physicalCardInd
        case operatingInstID = "operatingInstId"
        case noOfChequeBookLeavesID = "noOfChequeBookLeavesId"
        case nameOnPhysicalATM
        case nameOnPhysicalAtmStr
        case modeOfMajorTransID = "modeOfMajorTransId"
        case mailingAddrPrefID = "mailingAddrPrefId"
        case expectTypeOfCountParty
        case chequeBookReqInd
        case beneficialOwnerAccount
        case areaOfBusinessActivityID = "areaOfBusinessActivityId"
        case antiAnnualSalaryID = "antiAnnualSalaryId"
        case antiAnnualSalary
        case noOfJointApplicants = "noOfJointApplicatns"
        case rdaCustomerJointAccountID = "rdaCustomerJointAccountId"
        case natureOfAccountID = "natureOfAccountId"
        case natureOfAccount
        case accountVariantID = "accountVariantId"
        case accountVariant
        case currencyTypeID = "currencyTypeId"
        case currencyType
        case accountTypeID = "accountTypeId"
        case accountStatusID = "accountStatusId"
        case atmTypeID = "atmTypeId"
        case atmType
        case customerTypeID = "cunstomerTypeId"
        case transAlertInd
        case activationType
        case alertActivation
        case packageType
        case esoaInd
        case internetBankingInd
        case referredBy
        case referrerCp
        case customerCity
        case customerBranch
        case remitterName
        case relationshipWithRemitter
        case relationshipWithMinorID = "relationshipWithMinorId"
        case debitCardCollectionModeID = "debitCardCollectionModeId"
        case refereeName
        case refereeMobileNumber
        case bankingModeID = "bankingModeId"
        case bankingMode
        case transactionalAlertID = "transactionalAlertId"
        case transactionalAlert
        case customerAccountTypeID = "customerAccountTypeId"
        case customerAccountType
        case proofOfIncomeInd
        case averageMonthlySalary
        case pdaRemitterDetailList
        case genderId
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoID: Double?
    var rdaCustomerID: Double?
    var purposeOfAccountID: Double?
    var purposeOfAccount: String?
    var physicalCardInd: Bool?
    var operatingInstID: Double?
    var noOfChequeBookLeavesID: Double?
    var nameOnPhysicalATM: String?
    var nameOnPhysicalAtmStr: String?
    var modeOfMajorTransID: Double?
    var mailingAddrPrefID: Double?
    var expectTypeOfCountParty: String?
    var chequeBookReqInd: Bool?
    var beneficialOwnerAccount: String?
    var areaOfBusinessActivityID: Double?
    var antiAnnualSalaryID: Double?
    var antiAnnualSalary: String?
    var noOfJointApplicants: Int?
    var rdaCustomerJointAccountID: Double?
    var natureOfAccountID: Double?
    var natureOfAccount: String?
    var accountVariantID: Double?
    var accountVariant: String?
    var currencyTypeID: Double?
    var currencyType: String?
    var accountTypeID: Double?
    var accountStatusID: Double?
    var atmTypeID: Double?
    var atmType: String?
    var customerTypeID: Double?
    var transAlertInd: Bool?
    var activationType: String?
    var alertActivation: String?
    var packageType: String?
    var esoaInd: Bool?
    var internetBankingInd: Bool?
    var referredBy: String?
    var referrerCp: String?
    var customerCity: String?
    var customerBranch: String?
    var remitterName: String?
    var relationshipWithRemitter: String?
    var relationshipWithMinorID: Double?
    var debitCardCollectionModeID: Double?
    var refereeName: String?
    var refereeMobileNumber: String?
    var bankingModeID: Double?
    var bankingMode: String?
    var transactionalAlertID: Double?
    var transactionalAlert: String?
    var customerAccountTypeID: Double?
    var customerAccountType: String?
    var proofOfIncomeInd: Bool?
    var averageMonthlySalary: String?
    var pdaRemitterDetailList: [Any]?
    var genderId: Int?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: MappingType.fromJSON, JSON: dictionary))
//        print(dictionary)
    }
    
    // MARK: Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
//        print(map)
        rdaCustomerAccInfoID <- map[CodingKeys.rdaCustomerAccInfoID.rawValue]
        rdaCustomerID <- map[CodingKeys.rdaCustomerID.rawValue]
        purposeOfAccountID <- map[CodingKeys.purposeOfAccountID.rawValue]
        purposeOfAccount <- map[CodingKeys.purposeOfAccount.rawValue]
        physicalCardInd <- map[CodingKeys.physicalCardInd.rawValue]
        operatingInstID <- map[CodingKeys.operatingInstID.rawValue]
        noOfChequeBookLeavesID <- map[CodingKeys.noOfChequeBookLeavesID.rawValue]
        nameOnPhysicalATM <- map[CodingKeys.nameOnPhysicalATM.rawValue]
        nameOnPhysicalAtmStr <- map[CodingKeys.nameOnPhysicalAtmStr.rawValue]
        modeOfMajorTransID <- map[CodingKeys.modeOfMajorTransID.rawValue]
        mailingAddrPrefID <- map[CodingKeys.mailingAddrPrefID.rawValue]
        expectTypeOfCountParty <- map[CodingKeys.expectTypeOfCountParty.rawValue]
        chequeBookReqInd <- map[CodingKeys.chequeBookReqInd.rawValue]
        beneficialOwnerAccount <- map[CodingKeys.beneficialOwnerAccount.rawValue]
        areaOfBusinessActivityID <- map[CodingKeys.areaOfBusinessActivityID.rawValue]
        antiAnnualSalaryID <- map[CodingKeys.antiAnnualSalaryID.rawValue]
        antiAnnualSalary <- map[CodingKeys.antiAnnualSalary.rawValue]
        noOfJointApplicants <- map[CodingKeys.noOfJointApplicants.rawValue]
        rdaCustomerJointAccountID <- map[CodingKeys.rdaCustomerJointAccountID.rawValue]
        natureOfAccountID <- map[CodingKeys.natureOfAccountID.rawValue]
        natureOfAccount <- map[CodingKeys.natureOfAccount.rawValue]
        accountVariantID <- map[CodingKeys.accountVariantID.rawValue]
        accountVariant <- map[CodingKeys.accountVariant.rawValue]
        currencyTypeID <- map[CodingKeys.currencyTypeID.rawValue]
        currencyType <- map[CodingKeys.currencyType.rawValue]
        accountTypeID <- map[CodingKeys.accountTypeID.rawValue]
        accountStatusID <- map[CodingKeys.accountStatusID.rawValue]
        atmTypeID <- map[CodingKeys.atmTypeID.rawValue]
        atmType <- map[CodingKeys.atmType.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        transAlertInd <- map[CodingKeys.transAlertInd.rawValue]
        activationType <- map[CodingKeys.activationType.rawValue]
        alertActivation <- map[CodingKeys.alertActivation.rawValue]
        packageType <- map[CodingKeys.packageType.rawValue]
        esoaInd <- map[CodingKeys.esoaInd.rawValue]
        internetBankingInd <- map[CodingKeys.internetBankingInd.rawValue]
        referredBy <- map[CodingKeys.referredBy.rawValue]
        referrerCp <- map[CodingKeys.referrerCp.rawValue]
        customerCity <- map[CodingKeys.customerCity.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        remitterName <- map[CodingKeys.remitterName.rawValue]
        relationshipWithRemitter <- map[CodingKeys.relationshipWithRemitter.rawValue]
        relationshipWithMinorID <- map[CodingKeys.relationshipWithMinorID.rawValue]
        debitCardCollectionModeID <- map[CodingKeys.debitCardCollectionModeID.rawValue]
        refereeName <- map[CodingKeys.refereeName.rawValue]
        refereeMobileNumber <- map[CodingKeys.refereeMobileNumber.rawValue]
        bankingModeID <- map[CodingKeys.bankingModeID.rawValue]
        bankingMode <- map[CodingKeys.bankingMode.rawValue]
        transactionalAlertID <- map[CodingKeys.transactionalAlertID.rawValue]
        transactionalAlert <- map[CodingKeys.transactionalAlert.rawValue]
        customerAccountTypeID <- map[CodingKeys.customerAccountTypeID.rawValue]
        customerAccountType <- map[CodingKeys.customerAccountType.rawValue]
        proofOfIncomeInd <- map[CodingKeys.proofOfIncomeInd.rawValue]
        averageMonthlySalary <- map[CodingKeys.averageMonthlySalary.rawValue]
        
        genderId <- map[CodingKeys.genderId.rawValue]
//        print(proofOfIncomeInd)
//        print(genderId)
        pdaRemitterDetailList <- map[CodingKeys.pdaRemitterDetailList.rawValue]
        
    }
}
