//
//  VerifyBiometricNadraResponseModel.swift
//  ABL
//
//  Created by Hamza Amin on 3/15/22.
//

import Foundation
import ObjectMapper

class VerifyBiometricNadraResponseModel: Mappable {

    var data: VerifyBiometricNadraData?
    var message: Message?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        data <- map["data"]
        message <- map["message"]
    }
}

class Message: Mappable {

    var status: String?
    var description: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        status <- map["status"]
        description <- map["description"]
    }
}

class VerifyBiometricNadraData: Mappable {

    var responseMsg: String?
    var responseCode: NSNumber?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        responseMsg <- map["responseMsg"]
        responseCode <- map["responseCode"]
    }
}
