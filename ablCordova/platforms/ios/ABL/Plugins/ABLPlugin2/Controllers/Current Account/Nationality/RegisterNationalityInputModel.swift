//
//  RegisterNationalityInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 5/24/22.
//

import ObjectMapper

final class RegisterNationalityInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case consumerList = "data.consumerList"

    }
    
    // MARK: - Model Properties
    
    var consumerList: [RegisterNationalityConsumerListInputModel]?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        consumerList: [RegisterNationalityConsumerListInputModel]?

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



final class RegisterNationalityConsumerListInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerAccInfoId = "rdaCustomerAccInfoId"
        case rdaCustomerProfileId = "rdaCustomerProfileId"
        case customerTypeId = "customerTypeId"
        case fullName = "fullName"
        case fatherHusbandName = "fatherHusbandName"
        case motherMaidenName = "motherMaidenName"
        case cityOfBirth = "cityOfBirth"
        case isPrimary = "isPrimary"
        case emailAddress = "emailAddress"
        case taxResidentInd = "taxResidentInd"
        case occupationId = "occupationId"
        case professionId = "professionId"
        case customerNtn = "customerNtn"
        case rdaCustomerCountryId = "rdaCustomerCountryId"
        case kinName = "kinName"
        case kinCnic = "kinCnic"
        case kinMobile = "kinMobile"
        case nationalityTypeId = "nationalityTypeId"
        case nationalities = "nationalities"
        case residentCountries = "residentCountries"
        case isPrimaryRegistered = "isPrimaryRegistered"

    }
    
    // MARK: - Model Properties
    
    var rdaCustomerAccInfoId: Double?
    var rdaCustomerProfileId: Double?
    var customerTypeId: Double?
    var fullName: String?
    var fatherHusbandName: String?
    var motherMaidenName: String?
    var cityOfBirth: String?
    var isPrimary: Int?
    var isPrimaryRegistered: Bool?
    var emailAddress: String?
    var taxResidentInd: Int?
    var occupationId: Double?
    var professionId: Double?
    var customerNtn: String?
    var rdaCustomerCountryId: Double?
    var kinName: String?
    var kinCnic: String?
    var kinMobile: String?
    var nationalityTypeId: Double?
    var nationalities: [[String: Any]]?
    var residentCountries: [ResidentCountryInputModel]?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerAccInfoId: Double?,
        rdaCustomerProfileId: Double?,
        customerTypeId: Double?,
        fullName: String?,
        fatherHusbandName: String?,
        motherMaidenName: String?,
        cityOfBirth: String?,
        isPrimary: Int?,
        isPrimaryRegistered: Int?,
        emailAddress: String?,
        taxResidentInd: Int?,
        occupationId: Double?,
        professionId: Double?,
        customerNtn: String?,
        chequeBookReqInd: Int?,
        rdaCustomerCountryId: Double?,
        kinName: String?,
        kinCnic: String?,
        kinMobile: String?,
        nationalityTypeId: Double?,
        nationalities: [[String: Any]]?,
        residentCountries: [ResidentCountryInputModel]?
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerAccInfoId.rawValue] = rdaCustomerAccInfoId
        dictionary[CodingKeys.rdaCustomerProfileId.rawValue] = rdaCustomerProfileId
        dictionary[CodingKeys.customerTypeId.rawValue] = customerTypeId
        dictionary[CodingKeys.fullName.rawValue] = fullName
        dictionary[CodingKeys.fatherHusbandName.rawValue] = fatherHusbandName
        dictionary[CodingKeys.motherMaidenName.rawValue] = motherMaidenName
        dictionary[CodingKeys.cityOfBirth.rawValue] = cityOfBirth
        dictionary[CodingKeys.isPrimary.rawValue] = isPrimary
        dictionary[CodingKeys.isPrimaryRegistered.rawValue] = isPrimaryRegistered
        dictionary[CodingKeys.emailAddress.rawValue] = emailAddress
        dictionary[CodingKeys.taxResidentInd.rawValue] = taxResidentInd
        dictionary[CodingKeys.occupationId.rawValue] = occupationId
        dictionary[CodingKeys.professionId.rawValue] = professionId
        dictionary[CodingKeys.customerNtn.rawValue] = customerNtn
        dictionary[CodingKeys.rdaCustomerCountryId.rawValue] = rdaCustomerCountryId
        dictionary[CodingKeys.kinName.rawValue] = kinName
        dictionary[CodingKeys.kinCnic.rawValue] = kinCnic
        dictionary[CodingKeys.kinMobile.rawValue] = kinMobile
        dictionary[CodingKeys.nationalityTypeId.rawValue] = nationalityTypeId
        dictionary[CodingKeys.nationalities.rawValue] = nationalities
        dictionary[CodingKeys.residentCountries.rawValue] = residentCountries
        
        self.rdaCustomerAccInfoId = rdaCustomerAccInfoId
        self.rdaCustomerProfileId = rdaCustomerProfileId
        self.customerTypeId = customerTypeId
        self.fullName = fullName
        self.fatherHusbandName = fatherHusbandName
        self.motherMaidenName = motherMaidenName
        self.cityOfBirth = cityOfBirth
        self.isPrimary = isPrimary
        self.isPrimaryRegistered = isPrimaryRegistered == 1 ? true : false
        self.emailAddress = emailAddress
        self.taxResidentInd = taxResidentInd
        self.occupationId = occupationId
        self.professionId = professionId
        self.customerNtn = customerNtn
        self.rdaCustomerCountryId = rdaCustomerCountryId
        self.kinName = kinName
        self.kinCnic = kinCnic
        self.kinMobile = kinMobile
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
        customerTypeId <- map[CodingKeys.customerTypeId.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        fatherHusbandName <- map[CodingKeys.fatherHusbandName.rawValue]
        motherMaidenName <- map[CodingKeys.motherMaidenName.rawValue]
        cityOfBirth <- map[CodingKeys.cityOfBirth.rawValue]
        isPrimary <- map[CodingKeys.isPrimary.rawValue]
        isPrimaryRegistered <- map[CodingKeys.isPrimaryRegistered.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        taxResidentInd <- map[CodingKeys.taxResidentInd.rawValue]
        occupationId <- map[CodingKeys.occupationId.rawValue]
        professionId <- map[CodingKeys.professionId.rawValue]
        customerNtn <- map[CodingKeys.customerNtn.rawValue]
        rdaCustomerCountryId <- map[CodingKeys.rdaCustomerCountryId.rawValue]
        kinName <- map[CodingKeys.kinName.rawValue]
        kinCnic <- map[CodingKeys.kinCnic.rawValue]
        kinMobile <- map[CodingKeys.kinMobile.rawValue]
        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        residentCountries <- map[CodingKeys.residentCountries.rawValue]

    }
}

final class NationalityInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerId = "rdaCustomerId"
        case nationalityId = "nationalityId"
        case idNumber = "idNumber"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerId: Double?
    var nationalityId: Double?
    var idNumber: String?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerId: Double?,
        nationalityId: Double?,
        idNumber: String?

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.nationalityId.rawValue] = nationalityId
        dictionary[CodingKeys.nationalityId.rawValue] = nationalityId

        self.rdaCustomerId = rdaCustomerId
        self.nationalityId = nationalityId
        self.idNumber = idNumber

        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        rdaCustomerId <- map[CodingKeys.rdaCustomerId.rawValue]
        nationalityId <- map[CodingKeys.nationalityId.rawValue]
        idNumber <- map[CodingKeys.idNumber.rawValue]

    }
}


final class ResidentCountryInputModel: BaseInputModel {
    
    // MARK: Coding Keys
    
    enum CodingKeys: String {
        case countryOfTaxResidenceId = "countryOfTaxResidenceId"
        case rdaCustomerId = "rdaCustomerId"
        case taxIdentityNo = "taxIdentityNo"
        case tinReasonId = "tinReasonId"
        case explanation = "explanation"
        
    }

    // MARK: - Model Properties
    
    var countryOfTaxResidenceId: Double?
    var rdaCustomerId: Double?
    var taxIdentityNo: String?
    var tinReasonId: Double?
    var explanation: String?

    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        countryOfTaxResidenceId: Double?,
        rdaCustomerId: Double?,
        taxIdentityNo: String?,
        tinReasonId: Double?,
        explanation: String?

    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.countryOfTaxResidenceId.rawValue] = countryOfTaxResidenceId
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.taxIdentityNo.rawValue] = taxIdentityNo
        dictionary[CodingKeys.tinReasonId.rawValue] = tinReasonId
        dictionary[CodingKeys.explanation.rawValue] = explanation

        
        self.countryOfTaxResidenceId = countryOfTaxResidenceId
        self.rdaCustomerId = rdaCustomerId
        self.taxIdentityNo = taxIdentityNo
        self.tinReasonId = tinReasonId
        self.explanation = explanation

        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        countryOfTaxResidenceId <- map[CodingKeys.countryOfTaxResidenceId.rawValue]
        rdaCustomerId <- map[CodingKeys.rdaCustomerId.rawValue]
        taxIdentityNo <- map[CodingKeys.taxIdentityNo.rawValue]
        tinReasonId <- map[CodingKeys.tinReasonId.rawValue]
        explanation <- map[CodingKeys.explanation.rawValue]

    }
}
