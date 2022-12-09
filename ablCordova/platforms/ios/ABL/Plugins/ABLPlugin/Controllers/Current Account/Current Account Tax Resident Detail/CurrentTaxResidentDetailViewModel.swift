//
//  CurrentTaxResidentDetailViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 24/05/2022.
//

import Foundation

protocol CurrentTaxResidentDetailViewModelProtocol {
    var countryLookupResponse: Observable<CountryLookupResponseModel?> { get }
    var tinNotAvailableReasonResponse: Observable<CodeTypeResponseModel?> { get }
    var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var countryDropdownTapped: Observable<Bool> { get }
    var tinNonAvailabilityReasonDropdownTapped: Observable<Bool> { get }
    
    func getCountries()
    func getTinNotAvailableReasons(codeTypeID: Int)
    
    func setTaxResidentInd(taxResidentInd: Int)
    func getTaxResidentInd() -> Int
    func setHasTaxIDNumber(hasTaxIDNumber: Int)
    func getHasTaxIDNumber() -> Int
    func setCountryOfTaxResidenceID(for index: Int)
    func getCountryOfTaxResidenceID() -> Int
    func setTinReasonID(for index: Int)
    func getTinReasonID() -> Double
    
    func registerConsumerBasicInfoForTaxIn(
        customerAccInfoID: Double?,
        customerProfileID: Double?,
        customerTypeID: Double?,
        taxResidentInd: Int,
        isPrimary: Bool?
    )
    
    func registerConsumerBasicInfoForTaxOut(
        customerAccInfoID: Double?,
        customerProfileID: Double?,
        customerTypeID: Double?,
        customerID: Double?,
        taxResidentInd: Int,
        isPrimary: Bool?,
        taxIDNumber: String?,
        tinReasonID: Double,
        tinReason: String?
    )
}

final class CurrentTaxResidentDetailViewModel: CurrentTaxResidentDetailViewModelProtocol {
    private(set) var countryLookupResponse: Observable<CountryLookupResponseModel?> = Observable(nil)
    private(set) var tinNotAvailableReasonResponse: Observable<CodeTypeResponseModel?> = Observable(nil)
    private(set) var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var countryDropdownTapped: Observable<Bool> = Observable(false)
    private(set) var tinNonAvailabilityReasonDropdownTapped: Observable<Bool> = Observable(false)
    
    private var taxResidentInd = 0
    private var hasTaxIDNumber = 0
    private var countryOfTaxResidenceID = 0
    private var tinReasonID: Double = 0
    
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
    
    func getTinNotAvailableReasons(codeTypeID: Int) {
        guard let input = CodeTypeInputModel(codeTypeID: codeTypeID) else { return }
        
        APIManager.shared.lookupInformation(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.tinNotAvailableReasonResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func registerConsumerBasicInfoForTaxIn(
        customerAccInfoID: Double?,
        customerProfileID: Double?,
        customerTypeID: Double?,
        taxResidentInd: Int,
        isPrimary: Bool?
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let customerProfileID = customerProfileID,
            let customerTypeID = customerTypeID,
            let isPrimary = isPrimary
        else { return }
        
        guard
            let consumerList = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        else { return }
        
        var consumersList = [BasicInfoConsumerListInputModel]()
        
        consumerList.forEach {
            guard
                let rdaCustomerAccInfoID = $0.accountInformation?.rdaCustomerAccInfoID,
                let rdaCustomerProfileID = $0.rdaCustomerProfileID,
                let customerTypeID = $0.customerTypeID,
                let taxResidentInd = $0.taxResidentInd,
                let isPrimary = $0.isPrimary
            else { return }
            
            guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                rdaCustomerAccInfoId: rdaCustomerAccInfoID,
                rdaCustomerProfileId: rdaCustomerProfileID,
                customerTypeID: customerTypeID,
                taxResidentInd: taxResidentInd,
                isPrimary: isPrimary,
                genderId: modelRegistrationSteper.genderId
            ) else { return }
            
            consumersList.append(consumerListInputModel)
        }
        
        guard let consumerListInputModel = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: customerAccInfoID,
            rdaCustomerProfileId: customerProfileID,
            customerTypeID: customerTypeID,
            taxResidentInd: taxResidentInd,
            isPrimary: isPrimary,
            genderId: modelRegistrationSteper.genderId
        ) else { return }
        
        consumersList.append(consumerListInputModel)
        
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(
            consumerList: consumersList
        ) else { return }
        
        APIManager.shared.registerConsumerBasicInfo(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerBasicInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func registerConsumerBasicInfoForTaxOut(
        customerAccInfoID: Double?,
        customerProfileID: Double?,
        customerTypeID: Double?,
        customerID: Double?,
        taxResidentInd: Int,
        isPrimary: Bool?,
        taxIDNumber: String?,
        tinReasonID: Double,
        tinReason: String?
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let customerProfileID = customerProfileID,
            let customerTypeID = customerTypeID,
            let customerID = customerID,
            let isPrimary = isPrimary,
            let taxIDNumber = taxIDNumber,
            let tinReason = tinReason
        else { return }
        
        var registerConsumerBasicInfoInput: RegisterConsumerBasicInfoInputModel?
        
        guard
            let consumerList = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        else { return }
        
        var consumersList = [BasicInfoConsumerListInputModel]()
        var residentCountriesList = [BasicInfoResidentCountriesInputModel]()
        
        if hasTaxIDNumber == 0 {
            
            if !taxIDNumber.isEmpty {
                
                consumerList.forEach {
                    guard
                        let rdaCustomerAccInfoID = $0.accountInformation?.rdaCustomerAccInfoID,
                        let rdaCustomerProfileID = $0.rdaCustomerProfileID,
                        let customerTypeID = $0.customerTypeID,
                        let taxResidentInd = $0.taxResidentInd,
                        let isPrimary = $0.isPrimary
                    else { return }
                    
                    guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                        rdaCustomerAccInfoId: rdaCustomerAccInfoID,
                        rdaCustomerProfileId: rdaCustomerProfileID,
                        customerTypeID: customerTypeID,
                        taxResidentInd: taxResidentInd,
                        isPrimary: isPrimary,
                        genderId: modelRegistrationSteper.genderId
                    ) else { return }
                    
                    consumersList.append(consumerListInputModel)
                }
                
                guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                    rdaCustomerAccInfoId: customerAccInfoID,
                    rdaCustomerProfileId: customerProfileID,
                    customerTypeID: customerTypeID,
                    taxResidentInd: taxResidentInd,
                    isPrimary: isPrimary,
                    genderId: modelRegistrationSteper.genderId
                ) else { return }
                
                consumersList.append(consumerListInputModel)
                
                guard let residentCountryListInputModel = BasicInfoResidentCountriesInputModel(
                    explanation: "",
                    rdaCustomerID: customerID,
                    taxIdentityNo: taxIDNumber,
                    tinReasonID: 0,
                    taxResidentInd: taxResidentInd
                ) else { return }
                
                residentCountriesList.append(residentCountryListInputModel)
                
                registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(
                    consumerList: consumersList,
                    residentCountries: residentCountriesList
                )
                
            } else {
                errorMessage.value = "Please enter a valid tax identification number"
            }
        } else {
            
            consumerList.forEach {
                guard
                    let rdaCustomerAccInfoID = $0.accountInformation?.rdaCustomerAccInfoID,
                    let rdaCustomerProfileID = $0.rdaCustomerProfileID,
                    let customerTypeID = $0.customerTypeID,
                    let taxResidentInd = $0.taxResidentInd,
                    let isPrimary = $0.isPrimary
                else { return }
                
                guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                    rdaCustomerAccInfoId: rdaCustomerAccInfoID,
                    rdaCustomerProfileId: rdaCustomerProfileID,
                    customerTypeID: customerTypeID,
                    taxResidentInd: taxResidentInd,
                    isPrimary: isPrimary,
                    genderId: modelRegistrationSteper.genderId
                ) else { return }
                
                consumersList.append(consumerListInputModel)
            }
            
            guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                rdaCustomerAccInfoId: customerAccInfoID,
                rdaCustomerProfileId: customerProfileID,
                customerTypeID: customerTypeID,
                taxResidentInd: taxResidentInd,
                isPrimary: isPrimary,
                genderId: modelRegistrationSteper.genderId
            ) else { return }
            
            consumersList.append(consumerListInputModel)
            
            guard let residentCountryListInputModel = BasicInfoResidentCountriesInputModel(
                explanation: tinReason,
                rdaCustomerID: customerID,
                taxIdentityNo: taxIDNumber,
                tinReasonID: tinReasonID,
                taxResidentInd: taxResidentInd
            ) else { return }
            
            residentCountriesList.append(residentCountryListInputModel)
            
            registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(
                consumerList: consumersList,
                residentCountries: residentCountriesList
            )
        }
        
        guard let registerConsumerBasicInfoInput = registerConsumerBasicInfoInput else { return }

        APIManager.shared.registerConsumerBasicInfo(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerBasicInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func setTaxResidentInd(taxResidentInd: Int) {
        self.taxResidentInd = taxResidentInd
    }
    
    func getTaxResidentInd() -> Int {
        return taxResidentInd
    }
    
    func setHasTaxIDNumber(hasTaxIDNumber: Int) {
        self.hasTaxIDNumber = hasTaxIDNumber
    }
    
    func getHasTaxIDNumber() -> Int {
        return hasTaxIDNumber
    }
    
    func setCountryOfTaxResidenceID(for index: Int) {
        guard let countryID = countryLookupResponse.value?.data?[index].id else { return }
        countryOfTaxResidenceID = countryID
    }
    
    func getCountryOfTaxResidenceID() -> Int {
        return countryOfTaxResidenceID
    }
    
    func setTinReasonID(for index: Int) {
        guard let tinReasonID = tinNotAvailableReasonResponse.value?.data?[index].id else { return }
        self.tinReasonID = tinReasonID
    }
    
    func getTinReasonID() -> Double {
        return tinReasonID
    }
    
    @objc
    func openCountryDropdown() {
        countryDropdownTapped.value = true
    }
    
    @objc
    func openTinNonAvailabilityReasonDropdown() {
        tinNonAvailabilityReasonDropdownTapped.value = true
    }
}
