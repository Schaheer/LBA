//
//  ConsumerListResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class ConsumerListResponseModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "accountInformation.rdaCustomerAccInfoId"
        case rdaCustomerProfileID = "rdaCustomerProfileId"
        case accountTypeId = "accountInformation.accountTypeId"
        case customerAccountTypeId = "accountInformation.customerAccountTypeId"
        case residentCountries
        case accessToken
        case customerTitleID = "customerTitleId"
        case customerTitle
        case emailAddress
        case fullName
        case mobileNo
        case mobileNoCountryCodeID = "mobileNoCountryCodeId"
        case fatherHusbandName
        case motherMaidenName
        case countryOfResidenceId
        case genderID = "genderId"
        case gender
        case maritalStatusID = "maritalStatusId"
        case dateOfBirth
        case countryOfBirthPlaceID = "countryOfBirthPlaceId"
        case cityOfBirth
        case customerNTN = "customerNtn"
        case taxResidentInd
        case employmentTypeID = "employmentTypeId"
        case professionID = "professionId"
        case profession
        case occupationID = "occupationId"
        case occupation
        case nearestLandmark
        case natureOfBusiness
        case nameOfOrganization
        case employedSince
        case employerAddress
        case employerPhone
        case employerPostalCode
        case employerEmail
        case educationID = "educationId"
        case designation
        case placeOfIssue
        case dateOfIssue
        case expiryDate
        case adcFlagID = "adcFlagId"
        case existingCustomerInd
        case idTypeID = "idTypeId"
        case idNumber
        case statusID = "statusId"
        case nationalityTypeID = "nationalityTypeId"
        case nationalities
        case natureOfAccount
        case natureOfAccountID = "natureOfAccountId"
        case stepperSections
        case addresses
        case accountInformation
        case attachments
        case existingAccountInd
        case customerNonResidentInd
        case customerCity
        case customerBranch
        case customerTypeID = "customerTypeId"
        case kinName
        case kinMobile
        case kinAddress
        case kinCNIC = "kinCnic"
        case kinRelation
        case isPrimary
        case isPrimaryRegistered
        case referredBy
        case referrerCp
        case relationshipWithMinorID = "relationshipWithMinorId"
        case suggestedPlaceOfBirth = "suggestPlaceOfBirth"
        case suggestedMotherNames = "suggestMotherNames"
        case mobileNetworkID = "mobileNetworkId"
        case portedMobileNetwork
        case bankingModeId
        case alreadyExist
    }
    
    // MARK: - Model Properties
    var rdaCustomerAccInfoId: Any?
    var rdaCustomerProfileID: Double?
    var accountTypeId: Double?
    var customerAccountTypeId: Double?
    var accessToken: String?
    var customerTitleID: Double?
    var customerTitle: String?
    var emailAddress: String?
    var fullName: String?
    var mobileNo: String?
    var mobileNoCountryCodeID: Double?
    var fatherHusbandName: String?
    var motherMaidenName: String?
    var countryOfResidenceId: Double?
    var genderID: Int?
    var gender: String?
    var maritalStatusID: Int?
    var dateOfBirth: String?
    var countryOfBirthPlaceID: Int?
    var cityOfBirth: String?
    var customerNTN: String?
    var taxResidentInd: Int?
    var employmentTypeID: Int?
    var professionID: Double?
    var profession: String?
    var occupationID: Double?
    var occupation: String?
    var nearestLandmark: String?
    var natureOfBusiness: String?
    var nameOfOrganization: String?
    var employedSince: String?
    var employerAddress: String?
    var employerPhone: String?
    var employerPostalCode: String?
    var employerEmail: String?
    var educationID: Int?
    var designation: String?
    var placeOfIssue: String?
    var dateOfIssue: String?
    var expiryDate: String?
    var adcFlagID: Int?
    var existingCustomerInd: Bool?
    var idTypeID: Double?
    var idNumber: String?
    var statusID: Double?
    var nationalityTypeID: Double?
    var nationalities: [[String: Any]]?
    var natureOfAccount: String?
    var natureOfAccountID: Double?
    var stepperSections: StepperSectionsModel?
    var addresses: [AddressesModel]?
    var accountInformation: AccountInformationModel?
    var attachments: [CNICAttachmentResponseModel]?
    var residentCountries: [BasicInfoResidentCountriesInputModel]?
    var existingAccountInd: Bool?
    var customerNonResidentInd: Int?
    var customerCity: String?
    var customerBranch: String?
    var customerTypeID: Double?
    var bankingModeId: Double?
    var kinName: String?
    var kinMobile: String?
    var kinAddress: String?
    var kinCNIC: String?
    var kinRelation: String?
    var isPrimary: Bool?
    var isPrimaryRegistered: Bool?
    var referredBy: String?
    var referrerCp: String?
    var relationshipWithMinorID: Int?
    var suggestedPlaceOfBirth: [String]?
    var suggestedMotherNames: [String]?
    var mobileNetworkID: Double?
    var portedMobileNetwork: Bool?
    var alreadyExist: Bool?
    
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
        rdaCustomerProfileID <- map[CodingKeys.rdaCustomerProfileID.rawValue]
        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
        accountTypeId <- map[CodingKeys.accountTypeId.rawValue]
        customerAccountTypeId <- map[CodingKeys.customerAccountTypeId.rawValue]
        accessToken <- map[CodingKeys.accessToken.rawValue]
        customerTitleID <- map[CodingKeys.customerTitleID.rawValue]
        customerTitle <- map[CodingKeys.customerTitle.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        mobileNo <- map[CodingKeys.mobileNo.rawValue]
        mobileNoCountryCodeID <- map[CodingKeys.mobileNoCountryCodeID.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        countryOfResidenceId <- map[CodingKeys.countryOfResidenceId.rawValue]
        genderID <- map[CodingKeys.genderID.rawValue]
        gender <- map[CodingKeys.gender.rawValue]
        maritalStatusID <- map[CodingKeys.maritalStatusID.rawValue]
        dateOfBirth <- map[CodingKeys.dateOfBirth.rawValue]
        countryOfBirthPlaceID <- map[CodingKeys.countryOfBirthPlaceID.rawValue]
        cityOfBirth <- map[CodingKeys.cityOfBirth.rawValue]
        customerNTN <- map[CodingKeys.customerNTN.rawValue]
        taxResidentInd <- map[CodingKeys.taxResidentInd.rawValue]
        employmentTypeID <- map[CodingKeys.employmentTypeID.rawValue]
        professionID <- map[CodingKeys.professionID.rawValue]
        profession <- map[CodingKeys.profession.rawValue]
        occupationID <- map[CodingKeys.occupationID.rawValue]
        occupation <- map[CodingKeys.occupation.rawValue]
        nearestLandmark <- map[CodingKeys.nearestLandmark.rawValue]
        natureOfBusiness <- map[CodingKeys.natureOfBusiness.rawValue]
        nameOfOrganization <- map[CodingKeys.nameOfOrganization.rawValue]
        employedSince <- map[CodingKeys.employedSince.rawValue]
        employerAddress <- map[CodingKeys.employerAddress.rawValue]
        employerPhone <- map[CodingKeys.employerPhone.rawValue]
        employerPostalCode <- map[CodingKeys.employerPostalCode.rawValue]
        employerEmail <- map[CodingKeys.employerEmail.rawValue]
        educationID <- map[CodingKeys.educationID.rawValue]
        designation <- map[CodingKeys.designation.rawValue]
        placeOfIssue <- map[CodingKeys.placeOfIssue.rawValue]
        dateOfIssue <- map[CodingKeys.dateOfIssue.rawValue]
        expiryDate <- map[CodingKeys.expiryDate.rawValue]
        adcFlagID <- map[CodingKeys.adcFlagID.rawValue]
        existingCustomerInd <- map[CodingKeys.existingCustomerInd.rawValue]
        idTypeID <- map[CodingKeys.idTypeID.rawValue]
        idNumber <- map[CodingKeys.idNumber.rawValue]
        statusID <- map[CodingKeys.statusID.rawValue]
        nationalityTypeID <- map[CodingKeys.nationalityTypeID.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        natureOfAccount <- map[CodingKeys.natureOfAccount.rawValue]
        natureOfAccountID <- map[CodingKeys.natureOfAccountID.rawValue]
        stepperSections <- map[CodingKeys.stepperSections.rawValue]
        addresses <- map[CodingKeys.addresses.rawValue]
        accountInformation <- map[CodingKeys.accountInformation.rawValue]
        attachments <- map[CodingKeys.attachments.rawValue]
        residentCountries <- map[CodingKeys.residentCountries.rawValue]
        existingAccountInd <- map[CodingKeys.existingAccountInd.rawValue]
        customerNonResidentInd <- map[CodingKeys.customerNonResidentInd.rawValue]
        customerCity <- map[CodingKeys.customerCity.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        kinName <- map[CodingKeys.kinName.rawValue]
        kinMobile <- map[CodingKeys.kinMobile.rawValue]
        kinAddress <- map[CodingKeys.kinAddress.rawValue]
        kinCNIC <- map[CodingKeys.kinCNIC.rawValue]
        kinRelation <- map[CodingKeys.kinRelation.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        isPrimaryRegistered <- map[CodingKeys.isPrimary.rawValue]
        referredBy <- map[CodingKeys.referredBy.rawValue]
        referrerCp <- map[CodingKeys.referrerCp.rawValue]
        relationshipWithMinorID <- map[CodingKeys.relationshipWithMinorID.rawValue]
        suggestedPlaceOfBirth <- map[CodingKeys.suggestedPlaceOfBirth.rawValue]
        suggestedMotherNames <- map[CodingKeys.suggestedMotherNames.rawValue]
        mobileNetworkID <- map[CodingKeys.mobileNetworkID.rawValue]
        portedMobileNetwork <- map[CodingKeys.portedMobileNetwork.rawValue]
        bankingModeId <- map[CodingKeys.bankingModeId.rawValue]
        alreadyExist <- map[CodingKeys.bankingModeId.rawValue]
    }
}
