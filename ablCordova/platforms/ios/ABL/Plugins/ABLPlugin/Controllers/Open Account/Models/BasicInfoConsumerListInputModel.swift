//
//  BasicInfoConsumerListInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/13/22.
//

import ObjectMapper


final class BasicInfoConsumerListInputModel: BaseInputModel {
    
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
        case nationalities
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
        dictionary[CodingKeys.kinMobileNumber.rawValue] = kinMobileNumber
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
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
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
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        customerNtn <- map[CodingKeys.customerNtn.rawValue]
        rdaCustomerCountryId <- map[CodingKeys.rdaCustomerCountryId.rawValue]
        nationalityTypeId <- map[CodingKeys.nationalityTypeId.rawValue]
        nationalities <- map[CodingKeys.nationalities.rawValue]
        residentCountries <- map[CodingKeys.residentCountries.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        
    }
}
