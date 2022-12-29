//
//  TaxResidentViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/04/2022.
//

import Foundation

protocol TaxResidentViewModelProtocol {
    var taxNotAvailableReasons: Observable<CodeTypeResponseModel?> { get }
    var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var countryDropDownTapped: Observable<Bool> { get }
    var resonDropDownTapped: Observable<Bool> { get }
    
    var countryLookupResponse: Observable<CountryLookupResponseModel?> { get }
    
    func getTaxNotAvailableReasons(codeTypeID: Double)
    func setTaxNotAvailableReason(id: Double)
    func getTaxNotAvailableReasonID() -> Double
    func setTaxNotAvailableReason(for index: Int)
    func getTaxNotAvailableReason() -> CodeTypeDataModel?
    func registerConsumerBasicInfo(
        residentCountries: [BasicInfoResidentCountriesInputModel]
    )
    
    func setTaxResident(value: Int)
    func getTaxResident() -> Int
    func setTaxIdentificationNumber(value: String)
    func getTaxIdentificationNumber() -> String
}

final class TaxResidentViewModel: TaxResidentViewModelProtocol {
    private(set) var countryDropDownTapped: Observable<Bool> = Observable(false)
    private(set) var resonDropDownTapped: Observable<Bool> = Observable(false)
    
    private(set) var taxNotAvailableReasons: Observable<CodeTypeResponseModel?> = Observable(nil)
    private(set) var countryLookupResponse: Observable<CountryLookupResponseModel?> = Observable(nil)
    private(set) var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    private var taxNotAvailableReasonID: Double = 0
    private var isTaxResident = 0
    private var taxIdentificationNumber = ""
    private var taxNotAvailableReason: CodeTypeDataModel?
    private var countryOfTaxResidenceID = 0

    func getTaxNotAvailableReasons(codeTypeID: Double) {
        guard let input = CodeTypeInputModel(codeTypeID: Int(codeTypeID)) else { return }

//        APIManager.shared.taxNotAvailableReasons(input: input) { [weak self] response in

        APIManager.shared.lookupInformation(input: input) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                self.taxNotAvailableReasons.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getCountries() {
        APIManager.shared.countryLookup { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.countryLookupResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    func setCountryOfTaxResidenceID(for index: Int) {
        guard let countryID = countryLookupResponse.value?.data?[index].id else { return }
        countryOfTaxResidenceID = countryID
    }
    func getCountyofTaxResidenceID() -> Int {
        return countryOfTaxResidenceID
    }
    func registerConsumerBasicInfo(
        residentCountries: [BasicInfoResidentCountriesInputModel]
    ) {
        
        let basicInfoAadNewUser = getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel()!, residentCountries: residentCountries)
        let consumerListInputModelArray = basicInfoAadNewUser.0
        
        //Need to add consumer list in the array
        guard let input = RegisterConsumerBasicInfoInputModel(
            consumerList: consumerListInputModelArray,
            residentCountries: basicInfoAadNewUser.1
        ) else { return }
        
        
        APIManager.shared.registerConsumerBasicInfo(input: input) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                self.registerConsumerBasicInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func setTaxNotAvailableReason(id: Double) {
        taxNotAvailableReasonID = id
    }
    
    func getTaxNotAvailableReasonID() -> Double {
        return taxNotAvailableReasonID
    }
    
    func setTaxNotAvailableReason(for index: Int) {
        taxNotAvailableReason = taxNotAvailableReasons.value?.data?[index]
    }
    
    func getTaxNotAvailableReason() -> CodeTypeDataModel? {
        return taxNotAvailableReason
    }
    
    @objc
    func openCountryDropdown() {
        countryDropDownTapped.value = true
    }
    
    @objc
    func openResonDropdown() {
        resonDropDownTapped.value = true
    }
    
    func setTaxResident(value: Int) {
        isTaxResident = value
    }
    
    func getTaxResident() -> Int {
        return isTaxResident
    }
    
    func setTaxIdentificationNumber(value: String) {
        taxIdentificationNumber = value
    }
    
    func getTaxIdentificationNumber() -> String {
        return taxIdentificationNumber
    }
    
    //MARK: - For merging
    func getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel, residentCountries: [BasicInfoResidentCountriesInputModel]) -> ([BasicInfoConsumerListInputModel], [BasicInfoResidentCountriesInputModel]) {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        let currentConsumerList = getCurrentConsumerListResponseInInputModel(responseCunsumerList: cousumerListHamza!)
        let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        var foundIndex = 99
        //MARK: - Start----- Just to find new User Profile ID
        if currentConsumerList.count > 0 {
            for (index, consumer) in currentConsumerList.enumerated() {
                print(consumer.rdaCustomerProfileId ?? 0)
                print(consumer.rdaCustomerAccInfoId ?? 0)
                if let consumerListLocalShakeel = cousumerListShakeel {
                    var isNotFoundAndNewUserProfileID = true
                    consumerListLocalShakeel.forEach {
                       if $0.rdaCustomerProfileID == consumer.rdaCustomerProfileId {
                            print("record found")
                            isNotFoundAndNewUserProfileID = false
                        }
                    }
                    if isNotFoundAndNewUserProfileID {
                        print("------Start-----Profile Id Not Found------")
                        tempRdaCustomerProfileID = consumer.rdaCustomerProfileId ?? 0
                        tempRdaCustomerAccInfoId = consumer.rdaCustomerAccInfoId
                        print("------End-----Profile Id Not Found------")
                        foundIndex = index
                    }
                }
            }
        }
        //MARK: - Start-----If user profile id found Replace in new user Request data
//        print(tempRdaCustomerAccInfoId as Any)
//        print(tempRdaCustomerProfileID as Any)
        
        if foundIndex != 99 {
//            currentConsumerList[foundIndex] = BasicInfoConsumerListInputModel()!
            currentConsumerList[foundIndex].isPrimary = false
            currentConsumerList[foundIndex].isPrimaryRegistered = false
            currentConsumerList[foundIndex].rdaCustomerProfileId = tempRdaCustomerProfileID
            currentConsumerList[foundIndex].rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
            currentConsumerList[foundIndex].genderId = modelRegistrationSteper.genderId
        }
        else {
            foundIndex = 0
            currentConsumerList[foundIndex].isPrimary = true
        }
        residentCountries.first?.rdaCustomerID = currentConsumerList[foundIndex].rdaCustomerProfileId
        currentConsumerList[foundIndex].taxResidentInd = residentCountries.first?.taxResidentInd
        currentConsumerList[foundIndex].residentCountries = residentCountries
        residentCountries.first?.taxResidentInd = nil
        return (currentConsumerList, residentCountries)
    }
}


func getCurrentConsumerListResponseInInputModel(responseCunsumerList: [ConsumerListResponseModel])  -> [BasicInfoConsumerListInputModel] {
    var arrayConsumers = [BasicInfoConsumerListInputModel]()
    responseCunsumerList.forEach {
        let currentConsumerListInputModel = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: $0.rdaCustomerAccInfoId as? Double ?? 0,
            rdaCustomerProfileId: $0.rdaCustomerProfileID,
            fullName: $0.fullName,
            fatherHusbandName: $0.fatherHusbandName,
            motherMaidenName: $0.motherMaidenName,
            isPrimary: $0.isPrimary,
            isPrimaryRegistered: $0.isPrimaryRegistered,
            kinName: $0.kinName,
            kinCNIC: $0.kinCNIC,
            taxResidentInd: $0.taxResidentInd,
            customerTypeId: $0.customerTypeID,
            genderId: $0.genderID,
            nationalityTypeId: $0.nationalityTypeID,
            nationalities: $0.nationalities,
            accessToken: nil,
            customerTitleId: $0.customerTitleID,
            customerTitle: $0.customerTitle,
            emailAddress: $0.emailAddress,
            mobileNo: $0.mobileNo,
            mobileNoCountryCodeID: $0.mobileNoCountryCodeID,
            countryOfResidenceId: $0.countryOfResidenceId,
            gender: $0.gender,
            maritalStatusID: $0.maritalStatusID,
            dateOfBirth: $0.dateOfBirth,
            countryOfBirthPlaceID: $0.countryOfBirthPlaceID,
            cityOfBirth: $0.cityOfBirth,
            customerNTN: $0.customerNTN,
            employmentTypeID: $0.employmentTypeID,
            professionId: $0.professionID,
            profession: $0.profession,
            occupationId: $0.occupationID,
            occupation: $0.occupation,
            nearestLandmark: $0.nearestLandmark,
            natureOfBusiness: $0.natureOfBusiness,
            nameOfOrganization: $0.nameOfOrganization,
            employedSince: $0.employedSince,
            employerAddress: $0.employerAddress,
            employerPhone: $0.employerPhone,
            employerPostalCode: $0.employerPostalCode,
            employerEmail: $0.employerEmail,
            educationID: $0.educationID,
            designation: $0.designation,
            placeOfIssue: $0.placeOfIssue,
            dateOfIssue: $0.dateOfIssue,
            expiryDate: $0.expiryDate,
            adcFlagID: $0.adcFlagID,
            existingCustomerInd: $0.existingCustomerInd,
            idTypeID: $0.idTypeID,
            idNumber: $0.idNumber,
            statusID: $0.statusID,
            nationalityTypeID: $0.nationalityTypeID,
            natureOfAccountId: $0.natureOfAccountID,
            stepperSections: $0.stepperSections,
            addresses: $0.addresses,
            accountInformation: $0.accountInformation,
//            attachments: $0.attachments,
            existingAccountInd: $0.existingAccountInd,
            customerNonResidentInd: $0.customerNonResidentInd,
            customerCity: $0.customerCity,
            customerBranch: $0.customerBranch,
            bankingModeId: $0.bankingModeId,
            kinMobile: $0.kinMobile,
            kinAddress: $0.kinAddress,
            kinRelation: $0.kinRelation,
            referredBy: $0.referredBy,
            referrerCp: $0.referrerCp,
            relationshipWithMinorID: $0.relationshipWithMinorID,
//            suggestedPlaceOfBirth: $0.suggestedPlaceOfBirth,
//            suggestedMotherNames: $0.suggestedMotherNames,
            mobileNetworkID: $0.mobileNetworkID,
            portedMobileNetwork: $0.portedMobileNetwork)
        arrayConsumers.append(currentConsumerListInputModel!)
    }
    return arrayConsumers
}
