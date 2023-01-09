//
//  PersonalInformationViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/12/22.
//

import Foundation

protocol PersonalInformationViewModelProtocol{
    
    var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> { get }
    var registerConsumerEmailResponse: Observable<RegisterConsumerBasicInfoResponseModel?> { get }
    var registerConsumerAddressResponse: Observable<RegisterConsumerAddressResponseModel?> { get }
    var registerMailAddressResponse: Observable<RegisterMailAddressResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
}

class PersonalInformationViewModel: PersonalInformationViewModelProtocol {
    
    private(set) var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> = Observable(nil)
    private(set) var registerConsumerEmailResponse: Observable<RegisterConsumerBasicInfoResponseModel?> = Observable(nil)
    private(set) var registerConsumerAddressResponse: Observable<RegisterConsumerAddressResponseModel?> = Observable(nil)
    private(set) var registerMailAddressResponse: Observable<RegisterMailAddressResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    func registerConsumerBasicInfo(
        customerAccInfoID: Double?,
        customerProfiledID: Double?,
        fullName: String?,
        fatherHusbandName: String?,
        motherMaidenName: String?,
        placeOfBirth: String?,
        isPrimary: Bool?
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let customerProfiledID = customerProfiledID,
            let fullName = fullName,
            let fatherHusbandName = fatherHusbandName,
            let motherMaidenName = motherMaidenName,
            let isPrimary = isPrimary
        else { return }
        
        if !fullName.isEmpty && !fatherHusbandName.isEmpty && !motherMaidenName.isEmpty {
            let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
            var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
            guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
                rdaCustomerAccInfoId: customerAccInfoID,
                rdaCustomerProfileId: customerProfiledID,
                fullName: fullName,
                fatherHusbandName: fatherHusbandName,
                motherMaidenName: motherMaidenName,
                isPrimary: consumerList?.count ?? 0 > 0 ? false : isPrimary,
                genderId: modelRegistrationSteper.genderId,
                cityOfBirth: placeOfBirth
            ) else { return }
            
            consumerListInputModelArray = getListOfConsumers(newUserInfo: basicInfoConsumerListInput)
            
            //TODO: add data of all the applicants for joint account
            guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(consumerList: consumerListInputModelArray) else {return}
            APIManager.shared.registerConsumerBasicInfo(input: registerConsumerBasicInfoInput) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.registerConsumerBasicInfoResponse.value = value
                    
                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "All fields are required"
        }
    }
    
    func registerConsumerEmail(
        customerAccInfoID: Double?,
        customerProfiledID: Double?,
        emailAddress: String?,
        isPrimary: Bool?
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let customerProfiledID = customerProfiledID,
            let email = emailAddress,
            let isPrimary = isPrimary
        else { return }
        
        let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        
        guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: customerAccInfoID,
            rdaCustomerProfileId: customerProfiledID,
            isPrimary: consumerList?.count ?? 0 > 0 ? false : isPrimary,
            genderId: modelRegistrationSteper.genderId,
            emailAddress: email,
            customerNonResidentInd: 0
        ) else { return }
        
        consumerListInputModelArray = getListOfConsumersEmail(newUserInfo: basicInfoConsumerListInput)
        
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(consumerList: consumerListInputModelArray) else {return}
        
        APIManager.shared.registerConsumerEmail(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerEmailResponse.value = value
                
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
        //}
        //        else {
        //            errorMessage.value = "All fields are required"
        //        }
    }
    
    func registerConsumerAddress(
        rdaCustomerId: Double?,
        nearestLandMark: String?,
        customerAddress: String?,
        city: String?,
        addressTypeId: Double?,
        countryId: Double?,
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
        guard
            let rdaCustomerId = rdaCustomerId,
            let nearestLandMark = nearestLandMark,
            let customerAddress = customerAddress,
            let city = city,
            let addressTypeId = addressTypeId,
            let countryid = countryId
//            let rdaCustomerProfileAddrId = rdaCustomerProfileAddrId,
//            let postalCode = postalCode,
//            let phone = phone,
//            let mobileNo = mobileNo,
//            let customerTown = customerTown,
//            let countryCodeMobile = countryCodeMobile,
//            let country = country,
//            let addressTypeForeignInd = addressTypeForeignInd,
//            let emailAddress = emailAddress,
//            let phoneNumber = phoneNumber
        else {
            
            errorMessage.value = "All fields are required"
            return
            
        }
        
        if !nearestLandMark.isEmpty && !customerAddress.isEmpty && !city.isEmpty {
            
            guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
            var consumerListInputModelArray = [[String: Any]]()
            
            viewAppGenerateResponseModel.forEach { consumerInputModel in
                guard let addressesList = consumerInputModel.addresses, let rdaCustomerID = consumerInputModel.accountInformation?.rdaCustomerID, let isPrimary =  consumerInputModel.isPrimary, let mobileNo = consumerInputModel.mobileNo else { return }
                addressesList.forEach { address in
                    guard let nearestLandMark = consumerInputModel.nearestLandmark, let customerAddress = address.customerAddress,let city = address.city, let customerTown = address.customerTown, let addressTypeID = address.addressTypeID else { return }
                    let addressDataObject = AddressList(rdaCustomerId: rdaCustomerID, nearestLandMark: nearestLandMark, customerAddress: customerAddress, customerTown: customerTown, city: city, addressTypeId: addressTypeID, countryId: address.countryID ?? BaseConstants.CustomerAddress.countryId, countryCodeMobile: BaseConstants.CustomerAddress.countryCode, mobileNo: mobileNo).params
                    var consumerAddressListInputModelArray = [[String: Any]]()
                    consumerAddressListInputModelArray.append(addressDataObject)
                    let addressData = AddressData(addressesList: consumerAddressListInputModelArray, isPrimary: isPrimary).params
                    consumerListInputModelArray.append(addressData)
                }
                let addressDataCurrent = AddressList(rdaCustomerId: rdaCustomerId, nearestLandMark: nearestLandMark, customerAddress: customerAddress, customerTown: "", city: city, addressTypeId: addressTypeId, countryId: countryid, countryCodeMobile: BaseConstants.CustomerAddress.countryCode, mobileNo: mobileNo).params
                let addressData = AddressData(addressesList: [addressDataCurrent], isPrimary: true).params
                
                consumerListInputModelArray.append(addressData)
                
            }
        
            let consumerAddressInputList = RegisterConsumerAddressInputModel(addressDataArray: consumerListInputModelArray)
//            let checker = JSONSerialization.isValidJSONObject(consumerAddressInputList.params)
            APIManager.shared.registerConsumerAddress(input: consumerAddressInputList) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.registerConsumerAddressResponse.value = value

                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "All fields are required"
        }
    }
    
    
    func registerMailAddressPreference(
        rdaCustomerAccInfoId: Double?,
        rdaCustomerId: Double?,
        customerTypeId: Double?,
        esoaInd: Int?,
        physicalCardInd: Int?,
        bankingModeId: Double?,
        customerBranch: String?,
        customerAccountTypeId: Double?,
        purposeOfAccountId: Double?,
        proofOfIncomeInd: Int?,
        accountVariantId: Double?,
        atmTypeId: Double?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertId: Double?,
        natureOfAccountId: Double?,
        currencyTypeId: Double?,
        pdaRemitterDetailList: [Int]?,
        noOfJointApplicatns: Int?,
        mailingAddrPrefId: Double?,
        reasonForVisaDebitCardRequestId: Double?) {
//        guard
//            let rdaCustomerAccInfoId = rdaCustomerAccInfoId,
//            let rdaCustomerId = rdaCustomerId,
//            let customerTypeId = customerTypeId,
//            let esoaInd = esoaInd,
//            let physicalCardInd = physicalCardInd,
//            let customerBranch = customerBranch,
//            let customerAccountTypeId = customerAccountTypeId,
//            let purposeOfAccountId = purposeOfAccountId,
//            let proofOfIncomeInd = proofOfIncomeInd,
//            let accountVariantId = accountVariantId,
//            let atmTypeId = atmTypeId,
//            let transAlertInd = transAlertInd,
//            let chequeBookReqInd = chequeBookReqInd,
//            let natureOfAccountId = natureOfAccountId,
//            let transactionalAlertId = transactionalAlertId,
//            let currencyTypeId = currencyTypeId,
//            let pdaRemitterDetailList = pdaRemitterDetailList,
//            let noOfJointApplicatns = noOfJointApplicatns,
//            let mailingAddrPrefId = mailingAddrPrefId,
//            let reasonForVisaDebitCardRequestId = reasonForVisaDebitCardRequestId
//
//        else { return }

//        if !email.isEmpty {

            guard let registerMailAddressInput = RegisterMailAddressInputModel(rdaCustomerAccInfoId: rdaCustomerAccInfoId, rdaCustomerId: rdaCustomerId, customerTypeId: customerTypeId, esoaInd: esoaInd, physicalCardInd: physicalCardInd, bankingModeId: bankingModeId, customerBranch: customerBranch, customerAccountTypeId: customerAccountTypeId, purposeOfAccountId: purposeOfAccountId, proofOfIncomeInd: proofOfIncomeInd, accountVariantId: accountVariantId, atmTypeId: atmTypeId, transAlertInd: transAlertInd, chequeBookReqInd: chequeBookReqInd, transactionalAlertId: transactionalAlertId, natureOfAccountId: natureOfAccountId, currencyTypeId: currencyTypeId, pdaRemitterDetailList: pdaRemitterDetailList, noOfJointApplicatns: noOfJointApplicatns, mailingAddrPrefId: mailingAddrPrefId, reasonForVisaDebitCardRequestId: reasonForVisaDebitCardRequestId) else {return}
            APIManager.shared.registerMailAddressPreference(input: registerMailAddressInput) { [weak self] response in
                guard let self = self else { return }

                switch response.result {
                case .success(let value):
                    self.registerMailAddressResponse.value = value

                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
//        } else {
//            errorMessage.value = "All fields are required"
//        }
    }
    
    //MARK: - For merging
    func getListOfConsumers(newUserInfo: BasicInfoConsumerListInputModel) -> [BasicInfoConsumerListInputModel] {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        var currentConsumerList = getCurrentConsumerListResponseInInputModel(responseCunsumerList: cousumerListHamza!)
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
//        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
//        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerProfileID
        
        if foundIndex != 99 {
            currentConsumerList[foundIndex] = BasicInfoConsumerListInputModel()!
            currentConsumerList[foundIndex].isPrimary = false
            currentConsumerList[foundIndex].isPrimaryRegistered = false
        }
        else {
            foundIndex = 0
            currentConsumerList[foundIndex].isPrimary = true
        }
        
        currentConsumerList[foundIndex].rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
        currentConsumerList[foundIndex].rdaCustomerProfileId = tempRdaCustomerProfileID
        currentConsumerList[foundIndex].fullName = newUserInfo.fullName
        currentConsumerList[foundIndex].fatherHusbandName = newUserInfo.fatherHusbandName
        currentConsumerList[foundIndex].motherMaidenName = newUserInfo.motherMaidenName
        currentConsumerList[foundIndex].cityOfBirth = newUserInfo.cityOfBirth
        currentConsumerList[foundIndex].countryOfResidenceId = 157
        currentConsumerList[foundIndex].genderId = newUserInfo.genderId == 0 ? nil : newUserInfo.genderId
        
        return currentConsumerList
    }
    
    //MARK: - For merging
    func getListOfConsumersEmail(newUserInfo: BasicInfoConsumerListInputModel) -> [BasicInfoConsumerListInputModel] {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        var currentConsumerList = getCurrentConsumerListResponseInInputModel(responseCunsumerList: cousumerListHamza!)
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
//        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
//        newUserInfo.rdaCustomerAccInfoId = tempRdaCustomerProfileID
        
        if foundIndex != 99 {
            currentConsumerList[foundIndex] = BasicInfoConsumerListInputModel()!
            currentConsumerList[foundIndex].isPrimary = false
            currentConsumerList[foundIndex].isPrimaryRegistered = false
        }
        else {
            foundIndex = 0
            currentConsumerList[foundIndex].isPrimary = true
        }
        
        currentConsumerList[foundIndex].rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
        currentConsumerList[foundIndex].rdaCustomerProfileId = tempRdaCustomerProfileID
        currentConsumerList[foundIndex].employerEmail = newUserInfo.emailAddress
        currentConsumerList[foundIndex].customerNonResidentInd = 0
        currentConsumerList[foundIndex].genderId = newUserInfo.genderId == 0 ? nil : newUserInfo.genderId
//        currentConsumerList[foundIndex].genderId = modelRegistrationSteper.genderId
        return currentConsumerList
    }
}


//MARK: - For merging
func getCurrentUser() -> ConsumerListResponseModel {
    var currentUser = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first
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
                    currentUser = consumer
                    print(consumer.rdaCustomerProfileID ?? 0)
                    print(consumer.rdaCustomerAccInfoId ?? 0)
                    print("------End-----Profile Id Not Found------")
                }
            }
        }
    }
    
    if cousumerListShakeel?.count ?? 0 > 0 {
        currentUser!.isPrimaryRegistered = false
        currentUser!.isPrimary = false
    }
   
    return currentUser!
}

//MARK: - For merging
func getPrimaryUser() -> ConsumerListResponseModel {
    let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
    var primaryUser = ConsumerListResponseModel()
    if cousumerListShakeel?.count ?? 0 > 0 {
        cousumerListShakeel?.forEach {
            if $0.isPrimary! {
                primaryUser = $0
            }
        }
    }
    else {
        primaryUser = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.first
    }
   
    return primaryUser!
}
