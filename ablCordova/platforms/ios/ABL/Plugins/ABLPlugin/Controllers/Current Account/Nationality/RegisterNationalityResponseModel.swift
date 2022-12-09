//
//  RegisterNationalityResponseModel.swift
//  ABL
//
//  Created by Hamza Amin on 5/25/22.
//

import Foundation
import ObjectMapper

class RegisterNationalityResponseModel: Mappable {

    var message: GenericMessageResponse?
    var data: RegisterConsumerAddressDataResponse?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}


