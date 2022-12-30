//
//  BaseConstants.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation

struct BaseConstants {
//    enum BaseURL: String {
//        case connectionProtocol = "http"
//        case qaServer = "10.100.102.124"
//        case qaPort = "8080"
//        case api = "api"
//
//        enum RDA: String {
//            case consumer = "RdaConsumer/api/consumer/"
//            case admin = "RdaAdmin/api/admin/"
//            case helpDesk = "RdaHelpDesk/api/helpdesk/"
//            case common = "RdaConsumer/api/common/"
//            case attachment = "RdaConsumer/api/attachment/"
//        }
//
//        static func value() -> String {
//            return connectionProtocol.rawValue
//                    + "://"
//                    + qaServer.rawValue
//                    + ":"
//                    + qaPort.rawValue
//                    + "/"
//        }
//    }
    
//    enum BaseURL: String {
//        case connectionProtocol = "https"
//        case qaServer = "rda-uat2.abl.com.pk"
//        case api = "api"
//
//        enum RDA: String {
//            case consumer = "RdaConsumer/api/consumer/"
//            case admin = "RdaAdmin/api/admin/"
//            case helpDesk = "RdaHelpDesk/api/helpdesk/"
//            case common = "RdaConsumer/api/common/"
//            case attachment = "RdaConsumer/api/attachment/"
//        }
//
//        static func value() -> String {
//            return connectionProtocol.rawValue
//                    + "://"
//                    + qaServer.rawValue
//                    + "/"
//        }
//    }
    
    enum BaseURL: String {
        case connectionProtocol = "https"
        case qaServer = "rda.abl.com"
        case api = "api"

        enum RDA: String {
            case consumer = "RdaConsumer/api/consumer/"
            case admin = "RdaAdmin/api/admin/"
            case helpDesk = "RdaHelpDesk/api/helpdesk/"
            case common = "RdaConsumer/api/common/"
            case attachment = "RdaConsumer/api/attachment/"
        }

        static func value() -> String {
            return connectionProtocol.rawValue
                    + "://"
                    + qaServer.rawValue
                    + "/"
        }
    }
    enum UserDefaults: String {
        case userData = "com.ablPlugin.userData"
        case authHeaders = "com.ablPlugin.authHeaders"
//        case viewAppGenerateOTP = "com.ablPlugin.viewAppGenerateOTP"
        case viewAppGenerateOTPWithData = "com.ablPlugin.viewAppGenerateOTPWithData"
        case viewAppGenerateOTPResponse = "com.ablPlugin.viewAppGeneratedOTPResponse"
        case accountTypeInfo = "com.ablPlugin.accountTypeInfo"
        case draftedAppsData = "com.ablPlugin.draftedAppsData"
        case registerVerifyOTPResponse = "com.ablPlugin.registerVerifyOTPResponse"
        case registerConsumerAccountInfoResponse = "com.ablPlugin.registerConsumerAccountInfoResponse"
        case additionalApplicantRelationship = "com.ablPlugin.additionalApplicantRelationship"
        case noOfJointApplicants = "com.ablPlugin.noOfJointApplicants"
        case shouldGenerateOTP = "com.ablPlugin.shouldGenerateOTP"
        case viewAppGenerateOTPResponseArray = "com.plugin.viewAppGenerateOTPResponseArray"
    }
    
    struct Encryption {
        static let key128 = "4dweqdxcerfvc3rw"
    }
    
    struct SharedError {
        static let error = "Error"
        static let enterValidInfo = "Please enter a valid Account Number and CNIC"
    }
    
    struct Config {
        static let customerTypeID: Double = 106501
        static let rdaCustomerId: Double = 5559
        static let taxNotAvailableLookupID = 1012
        static let channelID: Double = 114601
        static let additionalApplicantRelationshipsLookupID: Double = 1088
        static let smsTransactionalAlertID: Double = 114401
        static let emailTransactionalAlertID: Double = 114402
        static let allAccountsLookupID = 1082
        static let allATMTypesLookupId = 1086
        static let reasonForRequiringVisaCard = 1126
        static let debitCardDeliveryOptionsID = 1033
    }
    
    struct AttachmentTypeIDs{
        
        static let cnicFrontTypeID: Double = 1043001
        static let cnicBackTypeID: Double = 1043002
        static let signatureTypeID: Double = 1043008
        static let livePhotoID: Double = 1043005
    }
    
    struct CustomerAddress{
        
        static let currentAddressId: Double = 103301
        static let permanetAddressId: Double = 10
        static let countryId: Double = 157
        static let countryCode = "+92"
    }
    
}
