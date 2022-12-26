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
        isPrimaryRegistered: Bool?,
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
        nationalities: [[String: Any]]?,
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
            let isPrimaryRegistered = isPrimaryRegistered,
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
            var consumerAddressListInputModelArray = [RegisterConsumerAddressInputModel]()

            guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
            
            
            var consumerListInputModelArray = [RegisterNationalityConsumerListInputModel]()
            
//            viewAppGenerateResponseModel.forEach { consumerInputModel in
//                guard let consumerListInputModel = RegisterNationalityConsumerListInputModel(
//                    rdaCustomerAccInfoId: consumerInputModel.accountInformation?.rdaCustomerAccInfoID,
//                    rdaCustomerProfileId: consumerInputModel.rdaCustomerProfileID,
//                    customerTypeId: consumerInputModel.customerTypeID,
//                    fullName: consumerInputModel.fullName,
//                    fatherHusbandName: consumerInputModel.fatherHusbandName,
//                    motherMaidenName: consumerInputModel.motherMaidenName,
//                    cityOfBirth: consumerInputModel.cityOfBirth,
//                    isPrimary: consumerInputModel.isPrimary?.intValue,
//                    isPrimaryRegistered: consumerInputModel.isPrimaryRegistered?.intValue,
//                    emailAddress: consumerInputModel.emailAddress,
//                    taxResidentInd: consumerInputModel.taxResidentInd,
//                    occupationId: Double(consumerInputModel.occupationID ?? 0),
//                    professionId: Double(consumerInputModel.professionID ?? 0),
//                    customerNtn: consumerInputModel.customerNTN,
//                    chequeBookReqInd: nil,
//                    rdaCustomerCountryId: consumerInputModel.countryOfResidenceId,
//                    kinName: consumerInputModel.kinName,
//                    kinCnic: consumerInputModel.kinCNIC,
//                    kinMobile: consumerInputModel.kinMobile,
//                    nationalityTypeId: consumerInputModel.nationalityTypeID,
//                    nationalities: [],
//                    residentCountries: []
//                ) else { return }
//
//                consumerListInputModelArray.append(consumerListInputModel)
//            }

            guard let consumerAddressInput = RegisterNationalityConsumerListInputModel(
                rdaCustomerAccInfoId: rdaCustomerAccInfoId,
                rdaCustomerProfileId: rdaCustomerProfileId,
                customerTypeId: customerTypeId,
                fullName: fullName,
                fatherHusbandName: fatherHusbandName,
                motherMaidenName: motherMaidenName,
                cityOfBirth: cityOfBirth,
                isPrimary: isPrimary,
                isPrimaryRegistered: isPrimaryRegistered ? 1 : 0,
                emailAddress: emailAddress,
                taxResidentInd: taxResidentInd,
                occupationId: occupationId,
                professionId: professionId,
                customerNtn: customerNtn,
                chequeBookReqInd: chequeBookReqInd,
                rdaCustomerCountryId: rdaCustomerCountryId,
                kinName: kinName,
                kinCnic: kinCnic,
                kinMobile: kinMobile,
                nationalityTypeId: nationalityTypeId,
                nationalities: nationalities,
                residentCountries: residentCountries
            ) else {return}
            
//            consumerListInputModelArray.append(consumerAddressInput)
            consumerListInputModelArray = getListOfConsumers(newUserInfo: consumerAddressInput)
            
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
    //MARK: - For merging
    func getListOfConsumers(newUserInfo: RegisterNationalityConsumerListInputModel) -> [RegisterNationalityConsumerListInputModel] {

        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        
        //MARK: - Start----- Just to find new User Profile ID
        if let listConsumerLocalHamza = cousumerListHamza {
            for consumer in listConsumerLocalHamza {
                print(consumer.rdaCustomerProfileID ?? 0)
                print(consumer.rdaCustomerAccInfoId ?? 0)
                if let consumerListLocalShakeel = cousumerListShakeel {
                    var isNotFoundAndNewUserProfileID = true
                    consumerListLocalShakeel.forEach {
                        print("Hamza" + "\(consumer.rdaCustomerProfileID ?? 0)")
                        print("Hamza" + "\(consumer.rdaCustomerAccInfoId ?? 0)")
                        print("Shakeel" + "\($0.rdaCustomerProfileID ?? 0)")
                        print("Shakeel" + "\($0.rdaCustomerAccInfoId ?? 0)")
                        if $0.rdaCustomerProfileID == consumer.rdaCustomerProfileID {
                            print("record found")
                            isNotFoundAndNewUserProfileID = false
                        }
                    }
                    if isNotFoundAndNewUserProfileID {
                        print("------Start-----Profile Id Not Found------")
                        tempRdaCustomerProfileID = consumer.rdaCustomerProfileID ?? 0
                        tempRdaCustomerAccInfoId = consumer.rdaCustomerAccInfoId as? Double
                        print(consumer.rdaCustomerProfileID ?? 0)
                        print(consumer.rdaCustomerAccInfoId ?? 0)
                        print("------End-----Profile Id Not Found------")
                    }
                }
            }
        }
        //MARK: - End----- Just to find new User Profile ID

        //MARK: - Start-----If user profile id found Replace in new user Request data
        newUserInfo.rdaCustomerProfileId = tempRdaCustomerProfileID
        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
        //MARK: - End-----If user profile id found Replace in new user Request data

        var consumerListInputModelArray = [RegisterNationalityConsumerListInputModel]()
        let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        if let consumerListTemp = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList {
            consumerListTemp.forEach {
                let consumerListInputModel = RegisterNationalityConsumerListInputModel(
                    rdaCustomerAccInfoId: $0.accountInformation?.rdaCustomerAccInfoID,
                    rdaCustomerProfileId: $0.rdaCustomerProfileID,
                    customerTypeId: $0.customerTypeID,
                    fullName: $0.fullName,
                    fatherHusbandName: $0.fatherHusbandName,
                    motherMaidenName: $0.motherMaidenName,
                    cityOfBirth: $0.cityOfBirth,
                    isPrimary: $0.isPrimary?.intValue,
                    isPrimaryRegistered: $0.isPrimaryRegistered?.intValue,
                    emailAddress: $0.emailAddress,
                    taxResidentInd: $0.taxResidentInd,
                    occupationId: Double($0.occupationID ?? 0),
                    professionId: Double($0.professionID ?? 0),
                    customerNtn: $0.customerNTN,
                    chequeBookReqInd: nil,
                    rdaCustomerCountryId: $0.countryOfResidenceId,
                    kinName: $0.kinName,
                    kinCnic: $0.kinCNIC,
                    kinMobile: $0.kinMobile,
                    nationalityTypeId: $0.nationalityTypeID,
                    nationalities: $0.nationalities,
                    residentCountries: []
                )
                        
                consumerListInputModelArray.append(consumerListInputModel!)
            }
        }
        
        print("------Start-----Check if user is adding for joint account------")
        //MARK: - Start----- Just to check if user is trying for joint account this this check will become true
        if consumerListInputModelArray.count > 0 {
            newUserInfo.isPrimaryRegistered = false
            newUserInfo.isPrimary = 0
        }
        //MARK: - End----- Just to check if user is trying for joint account this this check will become true
        print("------End-----Check if user is adding for joint account------")

        consumerListInputModelArray.append(newUserInfo)
        return consumerListInputModelArray
    }
}


















////Shakeel Global Input Model
////MARK: - For merging
//func getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModelForAll) -> [BasicInfoConsumerListInputModelForAll] {
//    var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
//    var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
//    
//    let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
//    let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
//    
//    //MARK: - Start----- Just to find new User Profile ID
//    if let listConsumerLocalHamza = cousumerListHamza {
//        for consumer in listConsumerLocalHamza {
//            print(consumer.rdaCustomerProfileID ?? 0)
//            print(consumer.rdaCustomerAccInfoId ?? 0)
//            if let consumerListLocalShakeel = cousumerListShakeel {
//                var isNotFoundAndNewUserProfileID = true
//                consumerListLocalShakeel.forEach {
//                    print("Hamza" + "\(consumer.rdaCustomerProfileID ?? 0)")
//                    print("Hamza" + "\(consumer.rdaCustomerAccInfoId ?? 0)")
//                    print("Shakeel" + "\($0.rdaCustomerProfileID ?? 0)")
//                    print("Shakeel" + "\($0.rdaCustomerAccInfoId ?? 0)")
//                    if $0.rdaCustomerProfileID == consumer.rdaCustomerProfileID {
//                        print("record found")
//                        isNotFoundAndNewUserProfileID = false
//                    }
//                }
//                if isNotFoundAndNewUserProfileID {
//                    print("------Start-----Profile Id Not Found------")
//                    tempRdaCustomerProfileID = consumer.rdaCustomerProfileID ?? 0
//                    tempRdaCustomerAccInfoId = consumer.rdaCustomerAccInfoId as? Double
//                    print(consumer.rdaCustomerProfileID ?? 0)
//                    print(consumer.rdaCustomerAccInfoId ?? 0)
//                    print("------End-----Profile Id Not Found------")
//                }
//            }
//        }
//    }
//    //MARK: - End----- Just to find new User Profile ID
//
//    //MARK: - Start-----If user profile id found Replace in new user Request data
//    newUserInfo.rdaCustomerProfileId = tempRdaCustomerProfileID
//    newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
//    //MARK: - End-----If user profile id found Replace in new user Request data
//
//    var consumerListInputModelArray = [BasicInfoConsumerListInputModelForAll]()
//    let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
//    if let consumerListTemp = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList {
//        consumerListTemp.forEach {
//            let consumerListInputModel = BasicInfoConsumerListInputModelForAll(
//                rdaCustomerAccInfoId: ($0.accountInformation?.rdaCustomerAccInfoID)!,
//                rdaCustomerProfileId: $0.rdaCustomerProfileID!,
//                fullName: $0.fullName!,
//                fatherHusbandName: $0.fatherHusbandName ?? "",
//                motherMaidenName: $0.motherMaidenName ?? "",
//                isPrimary: $0.isPrimary ?? false,
//                isPrimaryRegistered: $0.isPrimaryRegistered ?? false
//            )
//            consumerListInputModelArray.append(consumerListInputModel!)
//        }
//    }
//    
//    print("------Start-----Check if user is adding for joint account------")
//    //MARK: - Start----- Just to check if user is trying for joint account this this check will become true
//    if consumerListInputModelArray.count > 0 {
//        newUserInfo.isPrimaryRegistered = false
//        newUserInfo.isPrimary = false
//    }
//    //MARK: - End----- Just to check if user is trying for joint account this this check will become true
//    print("------End-----Check if user is adding for joint account------")
//
//    consumerListInputModelArray.append(newUserInfo)
//    return consumerListInputModelArray
//}
