//
//  AddressesModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 06/04/2022.
//

import ObjectMapper

final class AddressesModel: BaseResponseModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerProfileAddrID = "rdaCustomerProfileAddrId"
        case rdaCustomerID = "rdaCustomerId"
        case postalCode
        case phone
        case nearestLandMark
        case mobileNo
        case customerTown
        case customerAddress
        case countryCodeMobile
        case city
        case countryID = "countryId"
        case country
        case addressTypeForeignInd
        case addressTypeID = "addressTypeId"
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerProfileAddrID: Double?
    var rdaCustomerID: Double?
    var postalCode: String?
    var phone: String?
    var nearestLandMark: String?
    var mobileNo: String?
    var customerTown: String?
    var customerAddress: String?
    var countryCodeMobile: String?
    var city: String?
    var countryID: Double?
    var country: String?
    var addressTypeForeignInd: Bool?
    var addressTypeID: Double?
    
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
        
        rdaCustomerProfileAddrID <- map[CodingKeys.rdaCustomerProfileAddrID.rawValue]
        rdaCustomerID <- map[CodingKeys.rdaCustomerID.rawValue]
        postalCode <- map[CodingKeys.postalCode.rawValue]
        phone <- map[CodingKeys.phone.rawValue]
        nearestLandMark <- map[CodingKeys.nearestLandMark.rawValue]
        mobileNo <- map[CodingKeys.mobileNo.rawValue]
        customerTown <- map[CodingKeys.customerTown.rawValue]
        customerAddress <- map[CodingKeys.customerAddress.rawValue]
        countryCodeMobile <- map[CodingKeys.countryCodeMobile.rawValue]
        city <- map[CodingKeys.city.rawValue]
        countryID <- map[CodingKeys.countryID.rawValue]
        country <- map[CodingKeys.country.rawValue]
        addressTypeForeignInd <- map[CodingKeys.addressTypeForeignInd.rawValue]
        addressTypeID <- map[CodingKeys.addressTypeID.rawValue]
    }
}
