//
//  GetDraftedAppsVerifyOTPInputModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/03/2022.
//

import ObjectMapper

final class GetDraftedAppsVerifyOTPInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case customerTypeID = "data.customerTypeId"
        case idNumber = "data.idNumber"
        case mobileNumber = "data.mobileNo"
        case otp = "data.otp"
        case page = "pagination.page"
        case size = "pagination.size"
        case totalPages = "pagination.totalPages"
        case totalElements = "pagination.totalElements"
        case sortOrder = "pagination.sortOrder"
        case sortBy = "pagination.sortBy"
    }
    
    // MARK: - Model Properties
    
    var customerTypeID: Double?
    var idNumber: String?
    var mobileNumber: String?
    var otp: String?
    var page: Int?
    var size: Int?
    var totalPages: Int?
    var totalElements: Int?
    var sortOrder: String?
    var sortBy: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        customerTypeID: Double,
        idNumber: String,
        mobileNumber: String,
        otp: String,
        page: Int,
        size: Int,
        totalPages: Int,
        totalElements: Int,
        sortOrder: String,
        sortBy: String
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.customerTypeID.rawValue] = customerTypeID
        dictionary[CodingKeys.idNumber.rawValue] = idNumber
        dictionary[CodingKeys.mobileNumber.rawValue] = mobileNumber
        dictionary[CodingKeys.otp.rawValue] = otp
        dictionary[CodingKeys.page.rawValue] = page
        dictionary[CodingKeys.size.rawValue] = size
        dictionary[CodingKeys.totalPages.rawValue] = totalPages
        dictionary[CodingKeys.totalElements.rawValue] = totalElements
        dictionary[CodingKeys.sortOrder.rawValue] = sortOrder
        dictionary[CodingKeys.sortBy.rawValue] = sortBy
        
        self.customerTypeID = customerTypeID
        self.idNumber = idNumber
        self.mobileNumber = mobileNumber
        self.otp = otp
        self.page = page
        self.size = size
        self.totalPages = totalPages
        self.totalElements = totalElements
        self.sortOrder = sortOrder
        self.sortBy = sortBy
        
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    required init?() {
        let dictionary = [String: Any]()
        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
    }
    
    // MARK: - Model Mapping
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        customerTypeID <- map[CodingKeys.customerTypeID.rawValue]
        idNumber <- map[CodingKeys.idNumber.rawValue]
        mobileNumber <- map[CodingKeys.mobileNumber.rawValue]
        otp <- map[CodingKeys.otp.rawValue]
        page <- map[CodingKeys.page.rawValue]
        size <- map[CodingKeys.size.rawValue]
        totalPages <- map[CodingKeys.totalPages.rawValue]
        totalElements <- map[CodingKeys.totalElements.rawValue]
        sortOrder <- map[CodingKeys.sortOrder.rawValue]
        sortBy <- map[CodingKeys.sortBy.rawValue]
    }
}
