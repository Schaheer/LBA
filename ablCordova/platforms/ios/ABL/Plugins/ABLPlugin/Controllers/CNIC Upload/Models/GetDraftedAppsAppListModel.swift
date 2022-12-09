//
//  GetDraftedAppsAppListModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/03/2022.
//

import ObjectMapper

final class GetDraftedAppsAppListModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoID = "rdaCustomerAccInfoId"
        case purposeOfAccountID = "purposeOfAccountId"
        case purposeOfAccount
        case currencyTypeID = "currencyTypeId"
        case currencyType
        case accountVariantID = "accountVariantId"
        case accountVariant
        case antiAnnualSalaryID = "antiAnnualSalaryId"
        case antiAnnualSalary
        case accountTypeID = "accountTypeId"
        case accountType
        case noOfJointApplicants = "noOfJointApplicatns"
        case natureOfAccountID = "natureOfAccountId"
        case natureOfAccount
        case accountNumber
        case accountStatusID = "accountStatusId"
        case accountStatus
        case rdaCustomerProfileID = "rdaCustomerProfileId"
        case fullName
        case idTypeID = "idTypeId"
        case idType
        case expiryDate
        case idNumber
        case professionID = "professionId"
        case profession
        case educationID = "educationId"
        case education
        case dateOfBirth
        case existingCustomerInd
        case cpNumber
        case comments
        case createdDateTime = "createDatetime"
        case createdBy
        case modifiedBy
        case modifiedDateTime = "modifiedDatetime"
        case customerNonResidentInd
        case customerCity
        case customerBranch
        case customerTypeID = "customerTypeId"
        case emailAddress
        case customerAccountTypeID = "customerAccountTypeId"
        case customerAccountType
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoID: Double?
    var purposeOfAccountID: Double?
    var purposeOfAccount: String?
    var currencyTypeID: Double?
    var currencyType: String?
    var accountVariantID: Double?
    var accountVariant: String?
    var antiAnnualSalaryID: Double?
    var antiAnnualSalary: String?
    var accountTypeID: Double?
    var accountType: String?
    var noOfJointApplicants: Int?
    var natureOfAccountID: Double?
    var natureOfAccount: String?
    var accountNumber: String?
    var accountStatusID: Double?
    var accountStatus: String?
    var rdaCustomerProfileID: Double?
    var fullName: String?
    var idTypeID: Double?
    var idType: String?
    var expiryDate: String?
    var idNumber: String?
    var professionID: Double?
    var profession: String?
    var educationID: Double?
    var education: String?
    var dateOfBirth: String?
    var existingCustomerInd: String?
    var cpNumber: String?
    var comments: String?
    var createdDateTime: String?
    var createdBy: String?
    var modifiedBy: String?
    var modifiedDateTime: String?
    var customerNonResidentInd: String?
    var customerCity: String?
    var customerBranch: String?
    var customerTypeID: Double?
    var emailAddress: String?
    var customerAccountTypeID: Double?
    var customerAccountType: String?

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
        
        rdaCustomerAccInfoID <- map[CodingKeys.rdaCustomerAccInfoID.rawValue]
        purposeOfAccountID <- map[CodingKeys.purposeOfAccountID.rawValue]
        purposeOfAccount <- map[CodingKeys.purposeOfAccount.rawValue]
        currencyTypeID <- map[CodingKeys.currencyTypeID.rawValue]
        currencyType <- map[CodingKeys.currencyType.rawValue]
        accountVariantID <- map[CodingKeys.accountVariantID.rawValue]
        accountVariant <- map[CodingKeys.accountVariant.rawValue]
        antiAnnualSalaryID <- map[CodingKeys.antiAnnualSalaryID.rawValue]
        antiAnnualSalary <- map[CodingKeys.antiAnnualSalary.rawValue]
        accountTypeID <- map[CodingKeys.accountTypeID.rawValue]
        accountType <- map[CodingKeys.accountType.rawValue]
        noOfJointApplicants <- map[CodingKeys.noOfJointApplicants.rawValue]
        natureOfAccountID <- map[CodingKeys.natureOfAccountID.rawValue]
        natureOfAccount <- map[CodingKeys.natureOfAccount.rawValue]
        accountNumber <- map[CodingKeys.accountNumber.rawValue]
        accountStatusID <- map[CodingKeys.accountStatusID.rawValue]
        accountStatus <- map[CodingKeys.accountStatus.rawValue]
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        idTypeID <- map[CodingKeys.idTypeID.rawValue]
        idType <- map[CodingKeys.idType.rawValue]
        expiryDate <- map[CodingKeys.expiryDate.rawValue]
        idNumber <- map[CodingKeys.idNumber.rawValue]
        professionID <- map[CodingKeys.professionID.rawValue]
        profession <- map[CodingKeys.profession.rawValue]
        educationID <- map[CodingKeys.educationID.rawValue]
        education <- map[CodingKeys.education.rawValue]
        dateOfBirth <- map[CodingKeys.dateOfBirth.rawValue]
        existingCustomerInd <- map[CodingKeys.existingCustomerInd.rawValue]
        cpNumber <- map[CodingKeys.cpNumber.rawValue]
        comments <- map[CodingKeys.comments.rawValue]
        createdDateTime <- map[CodingKeys.createdDateTime.rawValue]
        createdBy <- map[CodingKeys.createdBy.rawValue]
        modifiedBy <- map[CodingKeys.modifiedBy.rawValue]
        modifiedDateTime <- map[CodingKeys.modifiedDateTime.rawValue]
        customerNonResidentInd <- map[CodingKeys.customerNonResidentInd.rawValue]
        customerCity <- map[CodingKeys.customerCity.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        customerAccountTypeID <- map[CodingKeys.customerAccountTypeID.rawValue]
        customerAccountType <- map[CodingKeys.customerAccountType.rawValue]
    }
}
