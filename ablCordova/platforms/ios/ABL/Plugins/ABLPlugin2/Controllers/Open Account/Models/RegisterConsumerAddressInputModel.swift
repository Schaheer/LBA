//
//  RegisterConsumerAddressInputModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/14/22.
//

import ObjectMapper

//{
//    
//    "data": [
//        
//        {
//            
//            "addressesList": [
//                
//                {
//                    
//                    "rdaCustomerId": 4465,
//                    
//                    "nearestLandMark": "DHA phase 8",
//                    
//                    "customerAddress": "rehman garden",
//                    
//                    "city": "LAHORE",
//                    
//                    "addressTypeId": 106901,
//                    
//                    "countryId": 157
//                    
//                }
//                
//            ],
//            
//            "isPrimary": true
//            
//        }
//        
//    ]
//    
//}


//final class RegisterConsumerAddressInputModel: BaseInputModel {
//
//    // MARK: Coding Keys
//
//    enum CodingKeys: String {
//        case data = "data"
//
//    }
//
//    // MARK: - Model Properties
//
//    var data: [ConsumerAddressListInputModel]?
//
//
//    // MARK: - Model Initializers
//
//    required init?(map: Map) {
//        super.init(map: map)
//    }
//
//    required init?(
//        data: [ConsumerAddressListInputModel]
//
//    ) {
//        var dictionary = [String: Any]()
//        dictionary[CodingKeys.data.rawValue] = data
//        self.data = data
//        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
//    }
//
//    required init?() {
//        let dictionary = [String: Any]()
//        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
//    }
//
//    // MARK: - Model Mapping
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//
//        data <- map[CodingKeys.data.rawValue]
//
//    }
//}

//struct payBilRequestModel {
//
//
//
//    var biller: String?
//
//    var billerAccount: String?
//
//    var referanceNo : String?
//
//    var amountEntered : String?
//
//    var consumerName: String?
//
//    var billingMonth: String?
//
//    var billCategory : String?
//
//    var dueDate : String?
//
//
//
//    var params: [String: String] {
//
//        return [
//
//            "biller": (biller ?? "") as String,
//
//            "billerAccount": (billerAccount ?? "") as String,
//
//            "referanceNo" : (referanceNo ?? "") as String,
//
//            "amountEntered" : (amountEntered ?? "") as String,
//
//            "consumerName": (consumerName ?? "") as String,
//
//            "billingMonth": (billingMonth ?? "") as String,
//
//            "billCategory" : (billCategory ?? "") as String,
//
//            "dueDate" : (dueDate ?? "") as String
//
//        ]
//
//    }
//
//}


struct RegisterConsumerAddressInputModel {

    

    var addressDataArray: [[String: Any]]
    
    var params: [String: Any] {
           return [
            "data": addressDataArray as Any
           ]

       }

   }


struct AddressData {
    
    var addressesList: [[String: Any]]
    var isPrimary: Bool
    
    var params: [String: Any] {
        
        return [
            
            "addressesList": addressesList as Any,
            "isPrimary": isPrimary 
            
        ]
        
    }
    
}



struct AddressList {
    
    var rdaCustomerId: Double
    var nearestLandMark: String
    var customerAddress: String
    var customerTown: String
    var city: String
    var addressTypeId: Double
    var countryId: Double
    var countryCodeMobile: String
    var mobileNo: String
    
    var params: [String: Any] {
                
        return [
            
            "rdaCustomerId": rdaCustomerId as Double,
            "nearestLandMark": nearestLandMark as String,
            "customerAddress": customerAddress as String,
            "customerTown": customerTown as String,
            "city": city as String,
            "addressTypeId": addressTypeId as Double,
            "countryId": countryId as Double,
            "countryCodeMobile": countryCodeMobile as String,
            "mobileNo": mobileNo as String


            
        ]
        
    }
    
}


//final class RegisterConsumerAddressInputModel: BaseInputModel {
//
//    // MARK: Coding Keys
//
//    enum CodingKeys: String {
//        case addressesList = "data.addressesList"
//        case isPrimary = "data.isPrimary"
//
//    }
//
//    // MARK: - Model Properties
//
//    var addressesList: [ConsumerAddressInputModel]?
//    var isprimary: Bool?
//
//
//    // MARK: - Model Initializers
//
//    required init?(map: Map) {
//        super.init(map: map)
//    }
//
//    required init?(
//        addressesList: [ConsumerAddressInputModel],
//        isprimary: Bool
//
//    ) {
//        var dictionary = [String: Any]()
//        dictionary[CodingKeys.addressesList.rawValue] = addressesList
//        dictionary[CodingKeys.isPrimary.rawValue] = isprimary
//        self.addressesList = addressesList
//        self.isprimary = isprimary
//        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
//    }
//
//    required init?() {
//        let dictionary = [String: Any]()
//        super.init(map: Map(mappingType: .fromJSON, JSON: dictionary))
//    }
//
//    // MARK: - Model Mapping
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//
//        addressesList <- map[CodingKeys.addressesList.rawValue]
//        isprimary <- map[CodingKeys.isPrimary.rawValue]
//
//    }
//}


//"rdaCustomerProfileAddrId": 9086, "rdaCustomerId": 6691, "postalCode": null,
//"phone": null,
//"nearestLandMark": "asd",
//"mobileNo": "03364069992", "customerTown": "asdf",
//"customerAddress": "PERMANANT_ADDRESS", "countryCodeMobile": null,
//"city": "asdf",
//"countryId": 157,
//"country": null,
//"addressTypeForeignInd": null, "addressTypeId": 103301,
//"emailAddress": "qwerqweqwe@gmail.com", "phoneNumber": "03364069992"

final class ConsumerAddressInputModel: BaseInputModel {
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String {
        case rdaCustomerId = "rdaCustomerId"
        case nearestLandMark = "nearestLandMark"
        case customerAddress = "customerAddress"
        case city = "city"
        case addressTypeId = "addressTypeId"
        case countryId = "countryId"
        
        case rdaCustomerProfileAddrId = "rdaCustomerProfileAddrId"
        case postalCode = "postalCode"
        case phone = "phone"
        case mobileNo = "mobileNo"
        case customerTown = "customerTown"
        case countryCodeMobile = "countryCodeMobile"
        case country = "country"
        case addressTypeForeignInd = "addressTypeForeignInd"
        case emailAddress = "emailAddress"
        case phoneNumber = "phoneNumber"
        
        
    }
    
    // MARK: - Model Properties
    
    var rdaCustomerId: Double?
    var nearestLandMark: String?
    var customerAddress: String?
    var city: String?
    var addressTypeId: Double?
    var countryId: Double?
    var rdaCustomerProfileAddrId: Double?
    var postalCode: String?
    var phone: String?
    var mobileNo: String?
    var customerTown: String?
    var countryCodeMobile: String?
    var country: String?
    var addressTypeForeignInd: Bool?
    var emailAddress: String?
    var phoneNumber: String?
    
    // MARK: - Model Initializers
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    required init?(
        rdaCustomerId: Double,
        nearestLandMark: String,
        customerAddress: String,
        city: String,
        addressTypeId: Double,
        countryId: Double,
        rdaCustomerProfileAddrId: Double?,
        postalCode: String?,
        phone: String?,
        mobileNo: String?,
        customerTown: String?,
        countryCodeMobile: String?,
        country: String?,
        addressTypeForeignInd: Bool?,
        emailAddress: String?,
        phoneNumber: String?
        
    ) {
        var dictionary = [String: Any]()
        dictionary[CodingKeys.rdaCustomerId.rawValue] = rdaCustomerId
        dictionary[CodingKeys.nearestLandMark.rawValue] = nearestLandMark
        dictionary[CodingKeys.customerAddress.rawValue] = customerAddress
        dictionary[CodingKeys.city.rawValue] = city
        dictionary[CodingKeys.addressTypeId.rawValue] = addressTypeId
        dictionary[CodingKeys.countryId.rawValue] = countryId
        dictionary[CodingKeys.rdaCustomerProfileAddrId.rawValue] = rdaCustomerProfileAddrId
        dictionary[CodingKeys.postalCode.rawValue] = postalCode
        dictionary[CodingKeys.phone.rawValue] = phone
        dictionary[CodingKeys.mobileNo.rawValue] = mobileNo
        dictionary[CodingKeys.customerTown.rawValue] = customerTown
        dictionary[CodingKeys.countryCodeMobile.rawValue] = countryCodeMobile
        dictionary[CodingKeys.country.rawValue] = country
        dictionary[CodingKeys.addressTypeForeignInd.rawValue] = addressTypeForeignInd
        dictionary[CodingKeys.emailAddress.rawValue] = emailAddress
        dictionary[CodingKeys.phoneNumber.rawValue] = phoneNumber
        
        self.rdaCustomerId = rdaCustomerId
        self.nearestLandMark = nearestLandMark
        self.customerAddress = customerAddress
        self.city = city
        self.addressTypeId = addressTypeId
        self.countryId = countryId
        self.rdaCustomerProfileAddrId = rdaCustomerProfileAddrId
        self.postalCode = postalCode
        self.phone = phone
        self.mobileNo = mobileNo
        self.customerTown = customerTown
        self.countryCodeMobile = countryCodeMobile
        self.country = country
        self.addressTypeForeignInd = addressTypeForeignInd
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        
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
        nearestLandMark <- map[CodingKeys.nearestLandMark.rawValue]
        customerAddress <- map[CodingKeys.customerAddress.rawValue]
        city <- map[CodingKeys.city.rawValue]
        addressTypeId <- map[CodingKeys.addressTypeId.rawValue]
        countryId <- map[CodingKeys.countryId.rawValue]
        rdaCustomerProfileAddrId <- map[CodingKeys.rdaCustomerProfileAddrId.rawValue]
        postalCode <- map[CodingKeys.postalCode.rawValue]
        phone <- map[CodingKeys.phone.rawValue]
        mobileNo <- map[CodingKeys.mobileNo.rawValue]
        customerTown <- map[CodingKeys.customerTown.rawValue]
        countryCodeMobile <- map[CodingKeys.countryCodeMobile.rawValue]
        country <- map[CodingKeys.country.rawValue]
        addressTypeForeignInd <- map[CodingKeys.addressTypeForeignInd.rawValue]
        emailAddress <- map[CodingKeys.emailAddress.rawValue]
        phoneNumber <- map[CodingKeys.phoneNumber.rawValue]
    }
}
