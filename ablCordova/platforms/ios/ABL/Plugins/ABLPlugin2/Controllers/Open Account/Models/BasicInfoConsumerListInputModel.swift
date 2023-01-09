//
//  BasicInfoConsumerListInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/13/22.
//

import ObjectMapper


final class BasicInfoConsumerListInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
//    enum CodingKeys: String {
//        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
//        case rdaCustomerProfileId = "rdaCustomerProfileId"
//        case fullName = "fullName"
//        case fatherHusbandName = "fatherHusbandName"
//        case motherMaidenName = "motherMaidenName"
//        case isPrimary = "isPrimary"
//        case isPrimaryRegistered = "isPrimaryRegistered"
//        case customerTypeId = "customerTypeId"
//        case occupationId = "occupationId"
//        case professionId = "professionId"
//        case kinName
//        case kinCNIC = "kinCnic"
//        case kinMobileNumber = "kinMobile"
//        case taxResidentInd
//        case genderId
//        case nationalityTypeId
//        case nationalities
//    }
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId
        case rdaCustomerId
        case accessToken
        case customerTitleId
        case customerTitle
        case emailAddress
        case fullName
        case mobileNo

        case mobileNoCountryCodeID = "mobileNoCountryCodeId"
        case fatherHusbandName
        case motherMaidenName
        case countryOfResidenceId
        case genderId
        case gender
        case maritalStatusID = "maritalStatusId"
        case dateOfBirth
        case countryOfBirthPlaceID = "countryOfBirthPlaceId"
        case cityOfBirth
        case customerNTN = "customerNtn"
        case taxResidentInd
        case employmentTypeID = "employmentTypeId"
        case professionId
        case profession
        case occupationId
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
        case nationalityTypeId
        case nationalities
        case natureOfAccountId
        case stepperSections
        case addresses
        case accountInformation
        case attachments
        case existingAccountInd
        case customerNonResidentInd
        case customerCity
        case customerBranch
        case customerTypeId
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
        case atmTypeId
        case physicalCardInd
        case transAlertInd
        case chequeBookReqInd
        case transactionalAlertId
        case reasonForVisaDebitCardRequestId
        case noOfJointApplicatns
        case nameOnPhysicalATM
        case modeOfMajorTransId
        case residentCountries = "residentCountries"
        case relationCode1
        case averageMonthlySalary
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var rdaCustomerId: Double?
    var fullName: String?
    var fatherHusbandName: String?
    var motherMaidenName: String?
    var isPrimary: Bool?
    var isPrimaryRegistered: Bool?
    var kinName: String?
    var kinCNIC: String?
    var kinMobileNumber: String?
    var taxResidentInd: Int?

    var genderId: Int?
    var nationalityTypeId: Double?
    var nationalities: [[String: Any]]?
    
    // MARK: - Model Properties
    //    var rdaCustomerAccInfoId: Any?
    //    var rdaCustomerProfileID: Double?
    var atmTypeId: Double?
    var physicalCardInd: Int?
    var transAlertInd: Int?
    var chequeBookReqInd: Int?
    var transactionalAlertId: Double?
    var reasonForVisaDebitCardRequestId: Double?
    var customerTypeId: Double?

    var accessToken: String?
    var customerTitleId: Double?
    var customerTitle: String?
    var emailAddress: String?
    //    var fullName: String?
    var mobileNo: String?
    var mobileNoCountryCodeID: Double?
    //    var fatherHusbandName: String?
    //    var motherMaidenName: String?
    var countryOfResidenceId: Double?
    var gender: String?
    var maritalStatusID: Int?
    var dateOfBirth: String?
    var countryOfBirthPlaceID: Int?
    var cityOfBirth: String?
    var customerNTN: String?
    //    var taxResidentInd: Int?
    var occupationId: Double?
    var professionId: Double?
    
    var employmentTypeID: Int?
    var profession: String?
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
    //    var nationalities: [[String: Any]]?
    var natureOfAccountId: Double?
    var stepperSections: StepperSectionsModel?
    var addresses: [AddressesModel]?
    var accountInformation: AccountInformationModel?
    var attachments: [[String : Any]]?
    var existingAccountInd: Bool?
    var customerNonResidentInd: Int?
    var customerCity: String?
    var customerBranch: String?
    var bankingModeId: Double?
    //    var kinName: String?
    var kinMobile: String?
    var kinAddress: String?
    //    var kinCNIC: String?
    var kinRelation: String?
    var referredBy: String?
    var referrerCp: String?
    var relationshipWithMinorID: Int?
    var suggestedPlaceOfBirth: [String]?
    var suggestedMotherNames: [String]?
    var mobileNetworkID: Double?
    var portedMobileNetwork: Bool?
    var noOfJointApplicatns: Int?
    var nameOnPhysicalATM: String?
    var modeOfMajorTransId: [Double]?
    var residentCountries: [BasicInfoResidentCountriesInputModel]?
    var relationCode1: Double?
    var averageMonthlySalary: String?

    required init?(
        rdaCustomerAccInfoId: Double? = nil,
        rdaCustomerProfileId: Double? = nil,
        rdaCustomerId: Double? = nil,
        fullName: String? = nil,
        fatherHusbandName: String? = nil,
        motherMaidenName: String? = nil,
        isPrimary: Bool? = nil,
        isPrimaryRegistered: Bool? = nil,
        kinName: String? = nil,
        kinCNIC: String? = nil,
//        kinMobileNumber: String? = nil,
        taxResidentInd: Int? = nil,
        customerTypeId: Double? = nil,
        genderId: Int? = nil,
        nationalityTypeId: Double? = nil,
        nationalities: [[String: Any]]? = nil,
        accessToken: String? = nil,
        customerTitleId: Double? = nil,
        customerTitle: String? = nil,
        emailAddress: String? = nil,
        mobileNo: String? = nil,
        mobileNoCountryCodeID: Double? = nil,
        countryOfResidenceId: Double? = nil,
        gender: String? = nil,
        maritalStatusID: Int? = nil,
        dateOfBirth: String? = nil,
        countryOfBirthPlaceID: Int? = nil,
        cityOfBirth: String? = nil,
        customerNTN: String? = nil,
        employmentTypeID: Int? = nil,
        professionId: Double? = nil,
        profession: String? = nil,
        occupationId: Double? = nil,
        occupation: String? = nil,
        nearestLandmark: String? = nil,
        natureOfBusiness: String? = nil,
        nameOfOrganization: String? = nil,
        employedSince: String? = nil,
        employerAddress: String? = nil,
        employerPhone: String? = nil,
        employerPostalCode: String? = nil,
        employerEmail: String? = nil,
        educationID: Int? = nil,
        designation: String? = nil,
        placeOfIssue: String? = nil,
        dateOfIssue: String? = nil,
        expiryDate: String? = nil,
        adcFlagID: Int? = nil,
        existingCustomerInd: Bool? = nil,
        idTypeID: Double? = nil,
        idNumber: String? = nil,
        statusID: Double? = nil,
        nationalityTypeID: Double? = nil,
        natureOfAccountId: Double? = nil,
        stepperSections: StepperSectionsModel? = nil,
        addresses: [AddressesModel]? = nil,
        accountInformation: AccountInformationModel? = nil,
        attachments:  [[String : Any]]? = nil,
        existingAccountInd: Bool? = nil,
        customerNonResidentInd: Int? = nil,
        customerCity: String? = nil,
        customerBranch: String? = nil,
        bankingModeId: Double? = nil,
        kinMobile: String? = nil,
        kinAddress: String? = nil,
        kinRelation: String? = nil,
        referredBy: String? = nil,
        referrerCp: String? = nil,
        relationshipWithMinorID: Int? = nil,
        suggestedPlaceOfBirth: [String]? = nil,
        suggestedMotherNames: [String]? = nil,
        mobileNetworkID: Double? = nil,
        portedMobileNetwork: Bool? = nil,
        atmTypeId: Double? = nil,
        physicalCardInd: Int? = nil,
        transAlertInd: Int? = nil,
        chequeBookReqInd: Int? = nil,
        transactionalAlertId: Double? = nil,
        reasonForVisaDebitCardRequestId: Double? = nil,
        noOfJointApplicatns: Int? = nil,
        nameOnPhysicalATM: String? = nil,
        modeOfMajorTransId: [Double]? = nil,
        residentCountries: [BasicInfoResidentCountriesInputModel]? = nil,
        relationCode1: Double? = nil,
        averageMonthlySalary: String? = nil

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        dictionary[CodingKeys.kinName.rawValue] = kinName
        dictionary[CodingKeys.kinCNIC.rawValue] = kinCNIC
//        dictionary[CodingKeys.kinMobile.rawValue] = kinMobileNumber
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        dictionary[CodingKeys.genderId.rawValue] = genderId
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.nationalities.rawValue] = nationalities
//        dictionary[CodingKeys.accessToken.rawValue] = accessToken
        dictionary[CodingKeys.customerTitleId.rawValue] = customerTitleId
        dictionary[CodingKeys.customerTitle.rawValue] = customerTitle
        dictionary[CodingKeys.emailAddress.rawValue] = emailAddress
        dictionary[CodingKeys.mobileNo.rawValue] = mobileNo
        dictionary[CodingKeys.mobileNoCountryCodeID.rawValue] = mobileNoCountryCodeID
        dictionary[CodingKeys.countryOfResidenceId.rawValue] = countryOfResidenceId
        dictionary[CodingKeys.gender.rawValue] = gender
        dictionary[CodingKeys.maritalStatusID.rawValue] = maritalStatusID
        dictionary[CodingKeys.dateOfBirth.rawValue] = dateOfBirth
        dictionary[CodingKeys.countryOfBirthPlaceID.rawValue] = countryOfBirthPlaceID
        dictionary[CodingKeys.cityOfBirth.rawValue] = cityOfBirth
        dictionary[CodingKeys.customerNTN.rawValue] = customerNTN
        dictionary[CodingKeys.employmentTypeID.rawValue] = employmentTypeID
        dictionary[CodingKeys.professionId.rawValue] = professionId
        dictionary[CodingKeys.profession.rawValue] = profession
        dictionary[CodingKeys.occupationId.rawValue] = occupationId
        dictionary[CodingKeys.occupation.rawValue] = occupation
        dictionary[CodingKeys.nearestLandmark.rawValue] = nearestLandmark
        dictionary[CodingKeys.natureOfBusiness.rawValue] = natureOfBusiness
        dictionary[CodingKeys.nameOfOrganization.rawValue] = nameOfOrganization
        dictionary[CodingKeys.employedSince.rawValue] = employedSince
        dictionary[CodingKeys.employerAddress.rawValue] = employerAddress
        dictionary[CodingKeys.employerPhone.rawValue] = employerPhone
        dictionary[CodingKeys.employerPostalCode.rawValue] = employerPostalCode
        dictionary[CodingKeys.employerEmail.rawValue] = employerEmail
        dictionary[CodingKeys.educationID.rawValue] = educationID
        dictionary[CodingKeys.designation.rawValue] = designation
        dictionary[CodingKeys.placeOfIssue.rawValue] = placeOfIssue
        dictionary[CodingKeys.dateOfIssue.rawValue] = dateOfIssue
        dictionary[CodingKeys.expiryDate.rawValue] = expiryDate
        dictionary[CodingKeys.adcFlagID.rawValue] = adcFlagID
        dictionary[CodingKeys.existingCustomerInd.rawValue] = existingCustomerInd
        dictionary[CodingKeys.idTypeID.rawValue] = idTypeID
        dictionary[CodingKeys.idNumber.rawValue] = idNumber
        dictionary[CodingKeys.statusID.rawValue] = statusID
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.natureOfAccountId.rawValue] = natureOfAccountId
        dictionary[CodingKeys.stepperSections.rawValue] = stepperSections
        dictionary[CodingKeys.addresses.rawValue] = addresses
        dictionary[CodingKeys.accountInformation.rawValue] = accountInformation
        dictionary[CodingKeys.attachments.rawValue] = attachments
        dictionary[CodingKeys.existingAccountInd.rawValue] = existingAccountInd
        dictionary[CodingKeys.customerNonResidentInd.rawValue] = customerNonResidentInd
        dictionary[CodingKeys.customerCity.rawValue] = customerCity
        dictionary[CodingKeys.customerBranch.rawValue] = customerBranch
        dictionary[CodingKeys.bankingModeId.rawValue] = bankingModeId
        dictionary[CodingKeys.kinMobile.rawValue] = kinMobile
        dictionary[CodingKeys.kinAddress.rawValue] = kinAddress
        dictionary[CodingKeys.kinRelation.rawValue] = kinRelation
        dictionary[CodingKeys.referredBy.rawValue] = referredBy
        dictionary[CodingKeys.referrerCp.rawValue] = referrerCp
        dictionary[CodingKeys.relationshipWithMinorID.rawValue] = relationshipWithMinorID
        dictionary[CodingKeys.suggestedPlaceOfBirth.rawValue] = suggestedPlaceOfBirth
        dictionary[CodingKeys.suggestedMotherNames.rawValue] = suggestedMotherNames
        dictionary[CodingKeys.mobileNetworkID.rawValue] = mobileNetworkID
        dictionary[CodingKeys.portedMobileNetwork.rawValue] = portedMobileNetwork
        dictionary[CodingKeys.atmTypeId.rawValue] = atmTypeId
        dictionary[CodingKeys.physicalCardInd.rawValue] = physicalCardInd
        dictionary[CodingKeys.transAlertInd.rawValue] = transAlertInd
        
        dictionary[CodingKeys.chequeBookReqInd.rawValue] = chequeBookReqInd
        dictionary[CodingKeys.transactionalAlertId.rawValue] = transactionalAlertId
        dictionary[CodingKeys.reasonForVisaDebitCardRequestId.rawValue] = reasonForVisaDebitCardRequestId
        dictionary[CodingKeys.noOfJointApplicatns.rawValue] = noOfJointApplicatns
        dictionary[CodingKeys.nameOnPhysicalATM.rawValue] = nameOnPhysicalATM
        dictionary[CodingKeys.modeOfMajorTransId.rawValue] = modeOfMajorTransId
        dictionary[CodingKeys.residentCountries.rawValue] = residentCountries
        dictionary[CodingKeys.relationCode1.rawValue] = relationCode1
        dictionary[CodingKeys.averageMonthlySalary.rawValue] = averageMonthlySalary

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.rdaCustomerId = rdaCustomerId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.isPrimary = isPrimary
        self.isPrimaryRegistered = isPrimaryRegistered
        self.kinName = kinName
        self.kinCNIC = kinCNIC
        self.taxResidentInd = taxResidentInd
        self.customerTypeId = customerTypeId
        self.genderId = genderId
        self.nationalityTypeId = nationalityTypeId
        self.nationalities = nationalities
        self.accessToken = accessToken
        self.customerTitleId = customerTitleId
        self.customerTitle = customerTitle
        self.emailAddress = emailAddress
        self.mobileNo = mobileNo
        self.mobileNoCountryCodeID = mobileNoCountryCodeID
        self.countryOfResidenceId = countryOfResidenceId
        self.gender = gender
        self.maritalStatusID = maritalStatusID
        self.dateOfBirth = dateOfBirth
        self.countryOfBirthPlaceID = countryOfBirthPlaceID
        self.cityOfBirth = cityOfBirth
        self.customerNTN = customerNTN
        self.employmentTypeID = employmentTypeID
        self.professionId = professionId
        self.profession = profession
        self.occupationId = occupationId
        self.occupation = occupation
        self.nearestLandmark = nearestLandmark
        self.natureOfBusiness = natureOfBusiness
        self.nameOfOrganization = nameOfOrganization
        self.employedSince = employedSince
        self.employerAddress = employerAddress
        self.employerPhone = employerPhone
        self.employerPostalCode = employerPostalCode
        self.employerEmail = employerEmail
        self.educationID = educationID
        self.designation = designation
        self.placeOfIssue = placeOfIssue
        self.dateOfIssue = dateOfIssue
        self.expiryDate = expiryDate
        self.adcFlagID = adcFlagID
        self.existingCustomerInd = existingCustomerInd
        self.idTypeID = idTypeID
        self.idNumber = idNumber
        self.statusID = statusID
        self.nationalityTypeID = nationalityTypeID
        self.natureOfAccountId = natureOfAccountId
        self.stepperSections = stepperSections
        self.addresses = addresses
        self.accountInformation = accountInformation
        self.attachments = attachments
        self.existingAccountInd = existingAccountInd
        self.customerNonResidentInd = 0
        self.customerCity = customerCity
        self.customerBranch = customerBranch
        self.bankingModeId = bankingModeId
        self.kinMobile = kinMobile
        self.kinAddress = kinAddress
        self.kinRelation = kinRelation
        self.referredBy = referredBy
        self.referrerCp = referrerCp
        self.relationshipWithMinorID = relationshipWithMinorID
        self.suggestedPlaceOfBirth = suggestedPlaceOfBirth
        self.suggestedMotherNames = suggestedMotherNames
        self.mobileNetworkID = mobileNetworkID
        self.portedMobileNetwork = portedMobileNetwork
        self.atmTypeId = atmTypeId
        self.physicalCardInd = physicalCardInd
        self.transAlertInd = transAlertInd
        self.chequeBookReqInd = chequeBookReqInd
        self.transactionalAlertId = transactionalAlertId
        self.reasonForVisaDebitCardRequestId = reasonForVisaDebitCardRequestId
        self.noOfJointApplicatns = noOfJointApplicatns
        self.nameOnPhysicalATM = nameOnPhysicalATM
        self.modeOfMajorTransId = modeOfMajorTransId
        self.residentCountries = residentCountries
        self.relationCode1 = relationCode1
        self.averageMonthlySalary = averageMonthlySalary
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    
    // MARK- Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        fullName: String? = nil,
        fatherHusbandName: String? = nil,
        motherMaidenName: String? = nil,
        isPrimary: Bool,
        isPrimaryRegistered: Bool = false,
        nationalityTypeId: Double? = nil,
        nationalities: [[String: Any]]? = []
//        genderId: Int
    ) {
        
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.nationalities.rawValue] = nationalities
        
//        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.isPrimary = isPrimary
        self.isPrimaryRegistered = isPrimaryRegistered
        self.nationalityTypeId = nationalityTypeId
        self.nationalities = nationalities
//        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        kinName: String,
        kinCNIC: String,
        kinMobileNumber: String,
        isPrimary: Bool

//        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.kinName.rawValue] = kinName
        dictionary[CodingKeys.kinCNIC.rawValue] = kinCNIC
        dictionary[CodingKeys.kinMobile.rawValue] = kinMobileNumber
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
//        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.kinName = kinName
        self.kinCNIC = kinCNIC
        self.kinMobileNumber = kinMobileNumber
        self.isPrimary = isPrimary
//        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        customerTypeId: Double,
        taxResidentInd: Int,
        isPrimary: Bool
//        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
//        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.customerTypeId = customerTypeId
        self.taxResidentInd = taxResidentInd
        self.isPrimary = isPrimary
//        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.genderId = genderId
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//
//        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
//        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
//        fullName <- map[CodingKeys.fullName.rawValue]
//        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
//        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
//        isPrimary <- map[CodingKeys.isPrimary.rawValue]
//        isPrimaryRegistered <- map[CodingKeys.isPrimary.rawValue]
//        kinName <- map[CodingKeys.kinName.rawValue]
//        kinCNIC <- map[CodingKeys.kinCNIC.rawValue]
//        kinMobileNumber <- map[CodingKeys.kinMobile.rawValue]
//        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
//        genderId <- map[CodingKeys.genderId.rawValue]
//        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
//        nationalities <- map[CodingKeys.nationalities.rawValue]
//
//        print(nationalities)
//        print(genderId)
//        print(nationalityTypeId)
//        print(nationalityTypeId)
//        print(nationalityTypeId)
//    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
        rdaCustomerId <- map[CodingKeys.rdaCustomerId.rawValue]
        customerTitleId <- map[CodingKeys.customerTitleId.rawValue]
        
        //        accessToken <- map[CodingKeys.accessToken.rawValue]
        customerTitle <- map[CodingKeys.customerTitle.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        mobileNo <- map[CodingKeys.mobileNo.rawValue]
        mobileNoCountryCodeID <- map[CodingKeys.mobileNoCountryCodeID.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        countryOfResidenceId <- map[CodingKeys.countryOfResidenceId.rawValue]
        genderId <- map[CodingKeys.genderId.rawValue]
        gender <- map[CodingKeys.gender.rawValue]
        maritalStatusID <- map[CodingKeys.maritalStatusID.rawValue]
        dateOfBirth <- map[CodingKeys.dateOfBirth.rawValue]
        countryOfBirthPlaceID <- map[CodingKeys.countryOfBirthPlaceID.rawValue]
        cityOfBirth <- map[CodingKeys.cityOfBirth.rawValue]
        customerNTN <- map[CodingKeys.customerNTN.rawValue]
        taxResidentInd <- map[CodingKeys.taxResidentInd.rawValue]
        employmentTypeID <- map[CodingKeys.employmentTypeID.rawValue]
        professionId <- map[CodingKeys.professionId.rawValue]
        profession <- map[CodingKeys.profession.rawValue]
        occupationId <- map[CodingKeys.occupationId.rawValue]
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
        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        natureOfAccountId <- map[CodingKeys.natureOfAccountId.rawValue]
        stepperSections <- map[CodingKeys.stepperSections.rawValue]
        addresses <- map[CodingKeys.addresses.rawValue]
        accountInformation <- map[CodingKeys.accountInformation.rawValue]
        attachments <- map[CodingKeys.attachments.rawValue]
        existingAccountInd <- map[CodingKeys.existingAccountInd.rawValue]
        customerNonResidentInd <- map[CodingKeys.customerNonResidentInd.rawValue]
        customerCity <- map[CodingKeys.customerCity.rawValue]
        customerBranch <- map[CodingKeys.customerBranch.rawValue]
        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
        kinName <- map[CodingKeys.kinName.rawValue]
        kinMobile <- map[CodingKeys.kinMobile.rawValue]
        kinAddress <- map[CodingKeys.kinAddress.rawValue]
        kinCNIC <- map[CodingKeys.kinCNIC.rawValue]
        kinRelation <- map[CodingKeys.kinRelation.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        isPrimaryRegistered <- map[CodingKeys.isPrimaryRegistered.rawValue]
        referredBy <- map[CodingKeys.referredBy.rawValue]
        referrerCp <- map[CodingKeys.referrerCp.rawValue]
        relationshipWithMinorID <- map[CodingKeys.relationshipWithMinorID.rawValue]
        suggestedPlaceOfBirth <- map[CodingKeys.suggestedPlaceOfBirth.rawValue]
        suggestedMotherNames <- map[CodingKeys.suggestedMotherNames.rawValue]
        mobileNetworkID <- map[CodingKeys.mobileNetworkID.rawValue]
        portedMobileNetwork <- map[CodingKeys.portedMobileNetwork.rawValue]
        bankingModeId <- map[CodingKeys.bankingModeId.rawValue]
        atmTypeId <- map[CodingKeys.atmTypeId.rawValue]
        physicalCardInd <- map[CodingKeys.physicalCardInd.rawValue]
        transAlertInd <- map[CodingKeys.transAlertInd.rawValue]
        
        chequeBookReqInd <- map[CodingKeys.chequeBookReqInd.rawValue]
        transactionalAlertId <- map[CodingKeys.transactionalAlertId.rawValue]
        reasonForVisaDebitCardRequestId <- map[CodingKeys.reasonForVisaDebitCardRequestId.rawValue]
        noOfJointApplicatns <- map[CodingKeys.noOfJointApplicatns.rawValue]
        nameOnPhysicalATM <- map[CodingKeys.nameOnPhysicalATM.rawValue]
        modeOfMajorTransId <- map[CodingKeys.modeOfMajorTransId.rawValue]
        residentCountries <- map[CodingKeys.residentCountries.rawValue]
        relationCode1 <- map[CodingKeys.relationCode1.rawValue]
        averageMonthlySalary <- map[CodingKeys.averageMonthlySalary.rawValue]
    }
}

import Foundation
import ObjectMapper
final class BasicInfoConsumerListInputModelForNationality: Mappable {
    
    // MARK: - Coding Keys
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case fullName = "fullName"
        case fatherHusbandName = "fatherHusbandName"
        case motherMaidenName = "motherMaidenName"
        case isPrimary = "isPrimary"
        case isPrimaryRegistered = "isPrimaryRegistered"
        case customerTypeId
        case occupationId
        case professionId
        case kinName
        case kinCNIC = "kinCnic"
        case kinMobileNumber = "kinMobile"
        case taxResidentInd
        case genderId
        case nationalityTypeId
        case nationalities = "nationalities"
    }
    
    // MARK: - Model Properties
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var fullName: String?
    var fatherHusbandName: String?
    var motherMaidenName: String?
    var isPrimary: Bool?
    var isPrimaryRegistered: Bool?
    var kinName: String?
    var kinCNIC: String?
    var kinMobileNumber: String?
    var taxResidentInd: Int?
    var customerTypeId: Double?
    var genderId: Int?
    var nationalityTypeId: Double?
    var nationalities: [[String: Any]]?

    // MARK: - Model Initializers
    init?(map: Map) {

    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        fullName: String? = nil,
        fatherHusbandName: String? = nil,
        motherMaidenName: String? = nil,
        isPrimary: Bool,
        isPrimaryRegistered: Bool = false,
        nationalityTypeId: Double? = nil,
        nationalities: [[String: Any]]? = []
//        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.nationalities.rawValue] = nationalities
        
//        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.isPrimary = isPrimary
        self.isPrimaryRegistered = isPrimaryRegistered
        self.nationalityTypeId = nationalityTypeId
        self.nationalities = nationalities
//        self.genderId = genderId
        //super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    
    
    // MARK: - Model Mapping
    
    func mapping(map: Map) {
        
        rdaCustomerAccInfoId <- map[CodingKeys.rdaCustomerAccInfoId.rawValue]
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        isPrimaryRegistered <- map[CodingKeys.isPrimary.rawValue]
        kinName <- map[CodingKeys.kinName.rawValue]
        kinCNIC <- map[CodingKeys.kinCNIC.rawValue]
        kinMobileNumber <- map[CodingKeys.kinMobileNumber.rawValue]
        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
        genderId <- map[CodingKeys.genderId.rawValue]
        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        
        print(nationalities)
        print(genderId)
        print(nationalityTypeId)
        print(nationalityTypeId)
        print(nationalityTypeId)
    }
}


