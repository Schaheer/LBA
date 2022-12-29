//
//  RegisterConsumerBasicInfoResponseModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/13/22.
//

import ObjectMapper

import Foundation
import ObjectMapper

class RegisterConsumerBasicInfoResponseModel: Mappable {

    var message: RegisterConsumerBasicInfoMessageData?
    var data: RegisterConsumerBasicInfoDataResponse?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}

class RegisterConsumerBasicInfoDataResponse: Mappable {

    var consumerList: [ConsumerList]?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        consumerList <- map["consumerList"]
    }
}

class ConsumerList: Mappable {

    var maritalStatusId: Any?
    var idNumber: String?
    var designation: Any?
    var kinAddress: Any?
    var nationalities: Any?
    var kinName: Any?
    var idTypeId: Any?
    var dateOfIssue: Any?
    var fatherHusbandName: String?
    var customerNtn: Any?
    var primaryRdaCustomerProfileId: Any?
    var employerEmail: Any?
    var employerAddress: Any?
    var countryOfResidenceId: Any?
    var occupationId: Any?
    var natureOfBusiness: Any?
    var professionId: Any?
    var rdaCustomerJointAccountId: Any?
    var rdaCustomerProfileId: NSNumber?
    var nearestLandmark: Any?
    var nameOfOrganization: Any?
    var employerPostalCode: Any?
    var existingCustomerInd: Bool?
    var kinMobile: Any?
    var placeOfIssue: Any?
    var kinCnic: Any?
    var customerCity: Any?
    var kinRelation: Any?
    var statusId: Any?
    var fullName: String?
    var motherMaidenName: String?
    var rdaCustomerAccInfoId: Any?
    var taxResidentInd: Any?
    var genderId: Any?
    var employmentTypeId: Any?
    var expiryDate: Any?
    var adcFlagId: Any?
    var isPrimary: Bool?
    var mobileNoCountryCodeId: Any?
    var customerTitleId: Any?
    var cityOfBirth: String?
    var employerPhone: Any?
    var customerNonResidentInd: Any?
    var customerBranch: Any?
    var educationId: Any?
    var countryOfBirthPlaceId: Any?
    var mobileNo: String?
    var nationalityTypeId: Any?
    var emailAddress: Any?
    var employedSince: Any?
    var dateOfBirth: Any?
    var residentCountries: [BasicInfoResidentCountriesInputModel]?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        maritalStatusId <- map["maritalStatusId"]
        idNumber <- map["idNumber"]
        designation <- map["designation"]
        kinAddress <- map["kinAddress"]
        nationalities <- map["nationalities"]
        kinName <- map["kinName"]
        idTypeId <- map["idTypeId"]
        dateOfIssue <- map["dateOfIssue"]
        fatherHusbandName <- map["fatherHusbandName"]
        customerNtn <- map["customerNtn"]
        primaryRdaCustomerProfileId <- map["primaryRdaCustomerProfileId"]
        employerEmail <- map["employerEmail"]
        employerAddress <- map["employerAddress"]
        countryOfResidenceId <- map["countryOfResidenceId"]
        occupationId <- map["occupationId"]
        natureOfBusiness <- map["natureOfBusiness"]
        professionId <- map["professionId"]
        rdaCustomerJointAccountId <- map["rdaCustomerJointAccountId"]
        rdaCustomerProfileId <- map["rdaCustomerProfileId"]
        nearestLandmark <- map["nearestLandmark"]
        nameOfOrganization <- map["nameOfOrganization"]
        employerPostalCode <- map["employerPostalCode"]
        existingCustomerInd <- map["existingCustomerInd"]
        kinMobile <- map["kinMobile"]
        placeOfIssue <- map["placeOfIssue"]
        kinCnic <- map["kinCnic"]
        customerCity <- map["customerCity"]
        kinRelation <- map["kinRelation"]
        statusId <- map["statusId"]
        fullName <- map["fullName"]
        motherMaidenName <- map["motherMaidenName"]
        rdaCustomerAccInfoId <- map["rdaCustomerAccInfoId"]
        taxResidentInd <- map["taxResidentInd"]
        genderId <- map["genderId"]
        employmentTypeId <- map["employmentTypeId"]
        expiryDate <- map["expiryDate"]
        adcFlagId <- map["adcFlagId"]
        isPrimary <- map["isPrimary"]
        mobileNoCountryCodeId <- map["mobileNoCountryCodeId"]
        customerTitleId <- map["customerTitleId"]
        cityOfBirth <- map["cityOfBirth"]
        employerPhone <- map["employerPhone"]
        customerNonResidentInd <- map["customerNonResidentInd"]
        customerBranch <- map["customerBranch"]
        educationId <- map["educationId"]
        residentCountries <- map["residentCountries"]
        countryOfBirthPlaceId <- map["countryOfBirthPlaceId"]
        mobileNo <- map["mobileNo"]
        nationalityTypeId <- map["nationalityTypeId"]
        emailAddress <- map["emailAddress"]
        employedSince <- map["employedSince"]
        dateOfBirth <- map["dateOfBirth"]
    }
}

class RegisterConsumerBasicInfoMessageData: Mappable {

    var status: String?
    var description: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        status <- map["status"]
        description <- map["description"]
    }
}
