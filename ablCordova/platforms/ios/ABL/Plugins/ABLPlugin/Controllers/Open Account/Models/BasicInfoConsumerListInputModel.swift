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
//        case customerTypeID = "customerTypeId"
//        case occupationID = "occupationId"
//        case professionID = "professionId"
//        case kinName
//        case kinCNIC = "kinCnic"
//        case kinMobileNumber = "kinMobile"
//        case taxResidentInd
//        case genderId
//        case nationalityTypeId
//        case nationalities
//    }
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "accountInformation.rdaCustomerAccInfoId"
        case rdaCustomerProfileId
        case accessToken
        case customerTitleId
        case customerTitle
        case emailAddress
        case fullName
        case mobileNo
        case mobileNoCountryCodeID = "mobileNoCountryCodeId"
        case fatherHusbandName
        case motherMaidenName
        case countryOfResidenceID = "countryOfResidenceId"
        case genderId
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
        case nationalityTypeId
        case nationalities
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
    var customerTypeID: Double?
    var genderId: Int?
    var nationalityTypeId: Double?
    var nationalities: [[String: Any]]?
    
    // MARK: - Model Properties
    //    var rdaCustomerAccInfoId: Any?
    //    var rdaCustomerProfileID: Double?
    var accessToken: String?
    var customerTitleId: Double?
    var customerTitle: String?
    var emailAddress: String?
    //    var fullName: String?
    var mobileNo: String?
    var mobileNoCountryCodeID: Double?
    //    var fatherHusbandName: String?
    //    var motherMaidenName: String?
    var countryOfResidenceID: Double?
    var genderID: Int?
    var gender: String?
    var maritalStatusID: Int?
    var dateOfBirth: String?
    var countryOfBirthPlaceID: Int?
    var cityOfBirth: String?
    var customerNTN: String?
    //    var taxResidentInd: Int?
    var employmentTypeID: Int?
    var professionID: Int?
    var profession: String?
    var occupationID: Int?
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
    var natureOfAccountID: Double?
    var stepperSections: StepperSectionsModel?
    var addresses: [AddressesModel]?
    var accountInformation: AccountInformationModel?
    var attachments: [CNICAttachmentResponseModel]?
    var existingAccountInd: Bool?
    var customerNonResidentInd: Bool?
    var customerCity: String?
    var customerBranch: String?
    //    var customerTypeID: Double?
    var bankingModeId: Double?
    //    var kinName: String?
    var kinMobile: String?
    var kinAddress: String?
    //    var kinCNIC: String?
    var kinRelation: String?
    //    var isPrimary: Bool?
    //    var isPrimaryRegistered: Bool?
    var referredBy: String?
    var referrerCp: String?
    var relationshipWithMinorID: Int?
    var suggestedPlaceOfBirth: [String]?
    var suggestedMotherNames: [String]?
    var mobileNetworkID: Double?
    var portedMobileNetwork: Bool?
    
    required init?(
        rdaCustomerAccInfoId: Double? = nil,
        rdaCustomerProfileId: Double? = nil,
        fullName: String? = nil,
        fatherHusbandName: String? = nil,
        motherMaidenName: String? = nil,
        isPrimary: Bool? = nil,
        isPrimaryRegistered: Bool? = nil,
        kinName: String? = nil,
        kinCNIC: String? = nil,
//        kinMobileNumber: String? = nil,
        taxResidentInd: Int? = nil,
        customerTypeID: Double? = nil,
        genderId: Int? = nil,
        nationalityTypeId: Double? = nil,
        nationalities: [[String: Any]]? = nil,
        accessToken: String? = nil,
        customerTitleId: Double? = nil,
        customerTitle: String? = nil,
        emailAddress: String? = nil,
        mobileNo: String? = nil,
        mobileNoCountryCodeID: Double? = nil,
        countryOfResidenceID: Double? = nil,
//        genderID: Int? = nil,
        gender: String? = nil,
        maritalStatusID: Int? = nil,
        dateOfBirth: String? = nil,
        countryOfBirthPlaceID: Int? = nil,
        cityOfBirth: String? = nil,
        customerNTN: String? = nil,
        employmentTypeID: Int? = nil,
        professionID: Int? = nil,
        profession: String? = nil,
        occupationID: Int? = nil,
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
        natureOfAccountID: Double? = nil,
        stepperSections: StepperSectionsModel? = nil,
        addresses: [AddressesModel]? = nil,
        accountInformation: AccountInformationModel? = nil,
        attachments: [CNICAttachmentResponseModel]? = nil,
        existingAccountInd: Bool? = nil,
        customerNonResidentInd: Bool? = nil,
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
        portedMobileNetwork: Bool? = nil
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        dictionary[CodingKeys.kinName.rawValue] = kinName
        dictionary[CodingKeys.kinCNIC.rawValue] = kinCNIC
//        dictionary[CodingKeys.kinMobile.rawValue] = kinMobileNumber
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.genderId.rawValue] = genderId
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.nationalities.rawValue] = nationalities
//        dictionary[CodingKeys.accessToken.rawValue] = accessToken
        dictionary[CodingKeys.customerTitleId.rawValue] = customerTitleId
        dictionary[CodingKeys.customerTitle.rawValue] = customerTitle
        dictionary[CodingKeys.emailAddress.rawValue] = emailAddress
        dictionary[CodingKeys.mobileNo.rawValue] = mobileNo
        dictionary[CodingKeys.mobileNoCountryCodeID.rawValue] = mobileNoCountryCodeID
        dictionary[CodingKeys.countryOfResidenceID.rawValue] = countryOfResidenceID
//        dictionary[CodingKeys.genderID.rawValue] = genderID
        dictionary[CodingKeys.gender.rawValue] = gender
        dictionary[CodingKeys.maritalStatusID.rawValue] = maritalStatusID
        dictionary[CodingKeys.dateOfBirth.rawValue] = dateOfBirth
        dictionary[CodingKeys.countryOfBirthPlaceID.rawValue] = countryOfBirthPlaceID
        dictionary[CodingKeys.cityOfBirth.rawValue] = cityOfBirth
        dictionary[CodingKeys.customerNTN.rawValue] = customerNTN
        dictionary[CodingKeys.employmentTypeID.rawValue] = employmentTypeID
        dictionary[CodingKeys.professionID.rawValue] = professionID
        dictionary[CodingKeys.profession.rawValue] = profession
        dictionary[CodingKeys.occupationID.rawValue] = occupationID
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
        dictionary[CodingKeys.natureOfAccountID.rawValue] = natureOfAccountID
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
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.isPrimary = isPrimary
        self.isPrimaryRegistered = isPrimaryRegistered
        self.kinName = kinName
        self.kinCNIC = kinCNIC
        self.taxResidentInd = taxResidentInd
        self.customerTypeID = customerTypeID
        self.genderId = genderId
        self.nationalityTypeId = nationalityTypeId
        self.nationalities = nationalities
        self.accessToken = accessToken
        self.customerTitleId = customerTitleId
        self.customerTitle = customerTitle
        self.emailAddress = emailAddress
        self.mobileNo = mobileNo
        self.mobileNoCountryCodeID = mobileNoCountryCodeID
        self.countryOfResidenceID = countryOfResidenceID
        self.gender = gender
        self.maritalStatusID = maritalStatusID
        self.dateOfBirth = dateOfBirth
        self.countryOfBirthPlaceID = countryOfBirthPlaceID
        self.cityOfBirth = cityOfBirth
        self.customerNTN = customerNTN
        self.employmentTypeID = employmentTypeID
        self.professionID = professionID
        self.profession = profession
        self.occupationID = occupationID
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
        self.natureOfAccountID = natureOfAccountID
        self.stepperSections = stepperSections
        self.addresses = addresses
        self.accountInformation = accountInformation
        self.attachments = attachments
        self.existingAccountInd = existingAccountInd
        self.customerNonResidentInd = customerNonResidentInd
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
        customerTypeID: Double,
        taxResidentInd: Int,
        isPrimary: Bool
//        genderId: Int
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
//        dictionary[CodingKeys.genderId.rawValue] = genderId

        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.customerTypeID = customerTypeID
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
//        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
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
        customerTitleId <- map[CodingKeys.customerTitleId.rawValue]
        
        //        accessToken <- map[CodingKeys.accessToken.rawValue]
        customerTitle <- map[CodingKeys.customerTitle.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        mobileNo <- map[CodingKeys.mobileNo.rawValue]
        mobileNoCountryCodeID <- map[CodingKeys.mobileNoCountryCodeID.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        countryOfResidenceID <- map[CodingKeys.countryOfResidenceID.rawValue]
        genderId <- map[CodingKeys.genderId.rawValue]
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
        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        natureOfAccountID <- map[CodingKeys.natureOfAccountID.rawValue]
        stepperSections <- map[CodingKeys.stepperSections.rawValue]
        addresses <- map[CodingKeys.addresses.rawValue]
        accountInformation <- map[CodingKeys.accountInformation.rawValue]
        attachments <- map[CodingKeys.attachments.rawValue]
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
        case customerTypeID = "customerTypeId"
        case occupationID = "occupationId"
        case professionID = "professionId"
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
    var customerTypeID: Double?
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
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
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


final class BasicInfoConsumerListInputModelForAll: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case fullName = "fullName"
        case fatherHusbandName = "fatherHusbandName"
        case motherMaidenName = "motherMaidenName"
        case isPrimary = "isPrimary"
        case isPrimaryRegistered = "isPrimaryRegistered"
        case customerTypeID = "customerTypeId"
        case occupationID = "occupationId"
        case professionID = "professionId"
        case kinName
        case kinCNIC = "kinCnic"
        case kinMobileNumber = "kinMobile"
        case taxResidentInd
        case genderId
        case cityOfBirth = "cityOfBirth"
        case emailAddress = "emailAddress"
        case customerNtn = "customerNtn"
        case rdaCustomerCountryId = "rdaCustomerCountryId"
        case nationalityTypeId = "nationalityTypeId"
        case nationalities = "nationalities"
        case residentCountries = "residentCountries"
        
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
    var customerTypeID: Double?
    var genderId: Int?
    var cityOfBirth: String?
    var emailAddress: String?
    var customerNtn: String?
    var rdaCustomerCountryId: Double?
    var occupationID: Double?
    var professionID: Double?
    var nationalityTypeId: Double?
    var nationalities: [[String: Any]]?
    var residentCountries: [ResidentCountryInputModel]?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double,
        rdaCustomerProfileId: Double,
        fullName: String,
        fatherHusbandName: String,
        motherMaidenName: String,
        isPrimary: Bool,
        isPrimaryRegistered: Bool? = false,
        genderId: Int? = nil,
        cityOfBirth: String? = nil,
        emailAddress: String? = nil,
        customerNtn: String? = nil,
        rdaCustomerCountryId: Double? = nil,
        nationalityTypeId: Double? = nil,
        nationalities: [[String: Any]]? = [],
        residentCountries: [ResidentCountryInputModel]? = nil,
        kinName: String? = nil,
        kinCNIC: String? = nil,
        kinMobileNumber: String? = nil,
        customerTypeID: Double? = nil,
        taxResidentInd: Int? = nil,
        
        
        occupationID: Double? = nil,
        professionID: Double? = nil
        
        
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        
        dictionary[CodingKeys.kinName.rawValue] = kinName
        dictionary[CodingKeys.kinCNIC.rawValue] = kinCNIC
        dictionary[CodingKeys.kinMobileNumber.rawValue] = kinMobileNumber
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.occupationID.rawValue] = occupationID
        
        dictionary[CodingKeys.professionID.rawValue] = professionID
        dictionary[CodingKeys.genderId.rawValue] = genderId
        dictionary[CodingKeys.cityOfBirth.rawValue] = cityOfBirth
        
        dictionary[CodingKeys.professionID.rawValue] = professionID
        dictionary[CodingKeys.emailAddress.rawValue] = emailAddress
        dictionary[CodingKeys.customerNtn.rawValue] = customerNtn
        dictionary[CodingKeys.rdaCustomerCountryId.rawValue] = rdaCustomerCountryId
        
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.nationalities.rawValue] = nationalities
        dictionary[CodingKeys.residentCountries.rawValue] = residentCountries
        
        
        
        
        //        dictionary[CodingKeys.genderId.rawValue] = genderId
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.isPrimary = isPrimary
        self.isPrimaryRegistered = isPrimaryRegistered
        
        self.kinName = kinName
        self.kinCNIC = kinCNIC
        self.kinMobileNumber = kinMobileNumber
        self.customerTypeID = customerTypeID
        self.occupationID = occupationID
        self.professionID = professionID
        self.taxResidentInd = taxResidentInd
        self.genderId = genderId
        self.cityOfBirth = cityOfBirth
        self.emailAddress = emailAddress
        self.customerNtn = customerNtn
        self.rdaCustomerCountryId = rdaCustomerCountryId
        self.nationalityTypeId = nationalityTypeId
        self.nationalities = nationalities
        self.residentCountries = residentCountries
        
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
        rdaCustomerProfileId <- map[CodingKeys.rdaCustomerProfileId.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        isPrimaryRegistered <- map[CodingKeys.isPrimary.rawValue]
        occupationID <- map[CodingKeys.occupationID.rawValue]
        professionID <- map[CodingKeys.professionID.rawValue]
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        kinName <- map[CodingKeys.kinName.rawValue]
        kinCNIC <- map[CodingKeys.kinCNIC.rawValue]
        kinMobileNumber <- map[CodingKeys.kinMobileNumber.rawValue]
        taxResidentInd <- map[CodingKeys.kinMobileNumber.rawValue]
        genderId <- map[CodingKeys.genderId.rawValue]
        cityOfBirth <- map[CodingKeys.cityOfBirth.rawValue]
        customerNtn <- map[CodingKeys.customerNtn.rawValue]
        rdaCustomerCountryId <- map[CodingKeys.rdaCustomerCountryId.rawValue]
        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        residentCountries <- map[CodingKeys.residentCountries.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]

    }
   
    
    
}
