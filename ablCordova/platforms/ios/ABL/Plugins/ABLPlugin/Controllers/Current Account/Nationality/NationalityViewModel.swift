//
//  NationalityViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 18/05/2022.
//

import Foundation


protocol NationalityViewModelProtocol{

    var registerConsumerAddressResponse: Observable<RegisterNationalityResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var countryLookupResponse: Observable<CountryLookupResponseModel?> { get }
    
    func getCountries()
}

class NationalityViewModel: NationalityViewModelProtocol {

    private(set) var registerConsumerAddressResponse: Observable<RegisterNationalityResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var countryLookupResponse: Observable<CountryLookupResponseModel?> = Observable(nil)

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


    func registerConsumerNationality(
        rdaCustomerAccInfoId: Double?,
        rdaCustomerProfileId: Double?,
        customerTypeId: Double?,
        fullName: String?,
        fatherHusbandName: String?,
        motherMaidenName: String?,
        cityOfBirth: String?,
        isPrimary: Int?,
        emailAddress: String?,
        taxResidentInd: Int?,
        occupationId: Double?,
        professionId: Double?,
        customerNtn: String?,
        chequeBookReqInd: Int?,
        rdaCustomerCountryId: Double?,
        kinName: String?,
        kinCnic: String?,
        kinMobile: String?,
        nationalityTypeId: Double?,
        nationalities: [NationalityInputModel]?,
        residentCountries: [ResidentCountryInputModel]?) {
        guard
            let rdaCustomerAccInfoId = rdaCustomerAccInfoId,
            let rdaCustomerProfileId = rdaCustomerProfileId,
            let customerTypeId = customerTypeId,
            let fullName = fullName,
            let fatherHusbandName = fatherHusbandName,
            let motherMaidenName = motherMaidenName,
            let cityOfBirth = cityOfBirth,
            let isPrimary = isPrimary,
            let emailAddress = emailAddress,
            let taxResidentInd = taxResidentInd,
            let occupationId = occupationId,
            let professionId = professionId,
            let customerNtn = customerNtn,
            let chequeBookReqInd = chequeBookReqInd,
            let rdaCustomerCountryId = rdaCustomerCountryId,
            let kinName = kinName,
            let kinCnic = kinCnic,
            let kinMobile = kinMobile,
            let nationalityTypeId = nationalityTypeId,
            let nationalities = nationalities,
            let residentCountries = residentCountries
        else { return }

//        if !nationalityTypeId isEmpty  {

            guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
            var consumerListInputModelArray = [RegisterNationalityConsumerListInputModel]()
            var consumerAddressListInputModelArray = [RegisterConsumerAddressInputModel]()
            viewAppGenerateResponseModel.forEach { consumerInputModel in
                
                guard let consumerListInputModel = RegisterNationalityConsumerListInputModel(rdaCustomerAccInfoId: consumerInputModel.accountInformation?.rdaCustomerAccInfoID, rdaCustomerProfileId: consumerInputModel.rdaCustomerProfileID, customerTypeId: consumerInputModel.customerTypeID, fullName: consumerInputModel.fullName, fatherHusbandName: consumerInputModel.fatherHusbandName, motherMaidenName: consumerInputModel.motherMaidenName, cityOfBirth: consumerInputModel.cityOfBirth, isPrimary: consumerInputModel.isPrimary?.intValue, emailAddress: consumerInputModel.emailAddress, taxResidentInd: consumerInputModel.taxResidentInd, occupationId: Double(consumerInputModel.occupationID ?? 0), professionId: Double(consumerInputModel.professionID ?? 0), customerNtn: consumerInputModel.customerNTN, chequeBookReqInd: nil, rdaCustomerCountryId: consumerInputModel.countryOfResidenceID, kinName: consumerInputModel.kinName, kinCnic: consumerInputModel.kinCNIC, kinMobile: consumerInputModel.kinMobile, nationalityTypeId: consumerInputModel.nationalityTypeID, nationalities: [], residentCountries: []) else { return }
                
                consumerListInputModelArray.append(consumerListInputModel)
                
            }

            guard let consumerAddressInput = RegisterNationalityConsumerListInputModel(rdaCustomerAccInfoId: rdaCustomerAccInfoId, rdaCustomerProfileId: rdaCustomerProfileId, customerTypeId: customerTypeId, fullName: fullName, fatherHusbandName: fatherHusbandName, motherMaidenName: motherMaidenName, cityOfBirth: cityOfBirth, isPrimary: isPrimary, emailAddress: emailAddress, taxResidentInd: taxResidentInd, occupationId: occupationId, professionId: professionId, customerNtn: customerNtn, chequeBookReqInd: chequeBookReqInd, rdaCustomerCountryId: rdaCustomerCountryId, kinName: kinName, kinCnic: kinCnic, kinMobile: kinMobile, nationalityTypeId: nationalityTypeId, nationalities: nationalities, residentCountries: residentCountries) else {return}
            consumerListInputModelArray.append(consumerAddressInput)
            guard let registerNationalityInput = RegisterNationalityInputModel(consumerList: consumerListInputModelArray) else {return}
            APIManager.shared.registerConsumerNationality(input: registerNationalityInput) { [weak self] response in
                guard let self = self else { return }

                switch response.result {
                case .success(let value):
                    self.registerConsumerAddressResponse.value = value

                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
//        } else {
//            errorMessage.value = "All fields are required"
//        }
    }

    func setNationality(){
        
        
    }
    
    func getNationality(){
        
        
    }
    
    func setNationalityTypeId(){
        
        
    }
    
    func getNationalityTypeId(){
        
        
    }

}
