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
        consumerList: [BasicInfoConsumerListInputModel],
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
        consumerList: [BasicInfoConsumerListInputModel],
        residentCountries: [BasicInfoResidentCountriesInputModel]
    ) {
        guard let input = RegisterConsumerBasicInfoInputModel(
            consumerList: consumerList,
            residentCountries: residentCountries
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
}
