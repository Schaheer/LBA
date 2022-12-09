//
//  RequestBiometricVerificationResponseModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import ObjectMapper

final class RequestBiometricResponseModel: BaseResponseModel {
    
    //  MARK: Coding Keys
    
    enum CodingKeys: String {
        case userID = "data.userId"
        case entityID = "data.entityId"
        case fullName = "data.fullName"
        case profilePicture = "data.profilePicture"
        case mobileNumber = "data.mobileNo"
        case username = "data.username"
        case userTypeID = "data.userTypeId"
        case helpDeskUserTypeID = "data.helpDeskUserTypeId"
        case statusID = "data.statusId"
        case accessToken = "data.accessToken"
        case existingCustomer = "data.existingCustomer"
        case guestConsumer = "data.guestConsumer"
        case accountInfoID = "data.accountInfoId"
        case sessionTimeout = "data.sessionTimeout"
        case menus = "data.menus"
        case area = "data.area"
        case accountType = "data.accountType"
    }
    
    // MARK: - Model Properties
    
    var userID: Int?
    var entityID: Double?
    var fullName: String?
    var profilePicture: String?
    var mobileNumber: String?
    var username: String?
    var userTypeID: Int?
    var helpDeskUserTypeID: Int?
    var statusID: Int?
    var accessToken: String?
    var existingCustomer: Bool?
    var guestConsumer: Bool?
    var accountInfoID: Double?
    var sessionTimeout: Int?
    var area: String?
    var accountType: String?
    
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
        
        userID <- map[CodingKeys.userID.rawValue]
        entityID <- map[CodingKeys.entityID.rawValue]
        fullName <- map[CodingKeys.fullName.rawValue]
        profilePicture <- map[CodingKeys.profilePicture.rawValue]
        mobileNumber <- map[CodingKeys.mobileNumber.rawValue]
        username <- map[CodingKeys.username.rawValue]
        userTypeID <- map[CodingKeys.userTypeID.rawValue]
        helpDeskUserTypeID <- map[CodingKeys.helpDeskUserTypeID.rawValue]
        statusID <- map[CodingKeys.statusID.rawValue]
        accessToken <- map[CodingKeys.accessToken.rawValue]
        existingCustomer <- map[CodingKeys.existingCustomer.rawValue]
        guestConsumer <- map[CodingKeys.guestConsumer.rawValue]
        accountInfoID <- map[CodingKeys.accountInfoID.rawValue]
        sessionTimeout <- map[CodingKeys.sessionTimeout.rawValue]
        area <- map[CodingKeys.area.rawValue]
        accountType <- map[CodingKeys.accountType.rawValue]
    }
}

