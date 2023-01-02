//
//  SelectOccupationViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/15/22.
//

import Foundation

protocol EmploymentDetailsViewModelProtocol{
    
    var occupationDropDownTapped: Observable<Bool> { get }
    var professionsDropDownTapped: Observable<Bool> { get }
    var occupationsList: Observable<OccupationsListResponseModel?> { get }
    var professionsList: Observable<OccupationsListResponseModel?> { get }
    var registerConsumerEmploymentDetailsResponse: Observable<RegisterConsumerBasicInfoResponseModel?> { get }
    var saveKYCResponseData: Observable<SaveKYCResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    
    func setOccupation(id: Double)
    func getSelectedOccupationId() -> Double
    func setProfession(id: Double)
    func getSelectedProfessionId() -> Double
}

class EmploymentDetailsViewModel: EmploymentDetailsViewModelProtocol {
    
    
    private(set) var occupationDropDownTapped: Observable<Bool> = Observable(false)
    private(set) var professionsDropDownTapped: Observable<Bool> = Observable(false)
    private(set) var occupationsList: Observable<OccupationsListResponseModel?> = Observable(nil)
    private(set) var professionsList: Observable<OccupationsListResponseModel?> = Observable(nil)
    private(set) var registerConsumerEmploymentDetailsResponse: Observable<RegisterConsumerBasicInfoResponseModel?> = Observable(nil)
    private(set) var saveKYCResponseData: Observable<SaveKYCResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    private var occupationID: Double = 0
    private var professionID: Double = 0
    
    func registerConsumerEmploymentDetails(
        customerAccInfoID: Double?,
        customerProfiledID: Double?,
        occupationId: Double?,
        professionId: Double?,
        isPrimary: Bool?
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let customerProfiledID = customerProfiledID,
            let occupationId = occupationId,
            let professionId = professionId,
            let isPrimary = isPrimary
        else { return }
        
        let consumerList = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
      
        guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: customerAccInfoID,
            rdaCustomerProfileId: customerProfiledID,
            isPrimary: isPrimary,
            professionId: professionId,
            occupationId: occupationId)
        else { return }
        
        consumerListInputModelArray = getListOfConsumers(newUserInfo: basicInfoConsumerListInput)
        
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(consumerList: consumerListInputModelArray) else {return}
        
        APIManager.shared.registerConsumerEmploymentDetails(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerEmploymentDetailsResponse.value = value
                
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func saveKyc(rdaCustomerAccInfoId: Double?, rdaCustomerProfileId: Double?, isPrimary: Bool?, relationCode1: Double?, averageMonthlySalary: String?) {

        guard let kycInfo = saveKYCObject(rdaCustomerAccInfoId: rdaCustomerAccInfoId, rdaCustomerProfileId: rdaCustomerProfileId, isPrimary: isPrimary, relationCode1: relationCode1, averageMonthlySalary: averageMonthlySalary) else { return }
        var consumerListInputModelArray = [saveKYCObject]()

        
        
        //        viewAppGenerateResponseModel?.forEach {
//            guard let consumerListInputModel = saveKYCObject(rdaCustomerAccInfoId: ($0.accountInformation?.rdaCustomerAccInfoID)!, rdaCustomerProfileId: $0.rdaCustomerProfileID , isPrimary: $0.isPrimary, relationCode1: DataCacheManager.shared.loadAdditionalApplicantRelationship()?.id, averageMonthlySalary: $0.accountInformation?.averageMonthlySalary) else { return }
//
//            consumerListInputModelArray.append(consumerListInputModel)
//        }
        
        
                                          
                                          
        guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: rdaCustomerAccInfoId,
            rdaCustomerProfileId: rdaCustomerProfileId,
            isPrimary: isPrimary,
            relationCode1: relationCode1,
            averageMonthlySalary: averageMonthlySalary)
        else { return }
        
        consumerListInputModelArray = getListOfConsumersForSVC(newUserInfo: basicInfoConsumerListInput)
        
        
        guard let saveKYCInput = SaveKYCInputModel(data: consumerListInputModelArray) else { return }
        
        APIManager.shared.saveKYC(input: saveKYCInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                //                    print(value)
                self.saveKYCResponseData.value = value
                
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
        
    }
    
    
    func getOcupationsList(codeTypeID: Int) {
        guard
            let mobileNetworkInput = OccupationsListInputModel(codeTypeID: codeTypeID)
        else { return }
        
        APIManager.shared.getOccupationsList(input: mobileNetworkInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.occupationsList.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getProfessionList(codeTypeID: Int) {
        guard
            let mobileNetworkInput = OccupationsListInputModel(codeTypeID: codeTypeID)
        else { return }
        
        APIManager.shared.getOccupationsList(input: mobileNetworkInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.professionsList.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    
    @objc
    func openOccupationsDropdown() {
        occupationDropDownTapped.value = true
    }

    func getOccupation(at index: Int) -> OccupationDataModel? {
        return occupationsList.value?.data?[index]
    }
    
    

    @objc
    func openProfessionsDropdown() {
        professionsDropDownTapped.value = true
    }

    func getProfession(at index: Int) -> OccupationDataModel? {
        return professionsList.value?.data?[index]
    }
    
    func setOccupation(id: Double) {// selected occupation is stored in occupationID
        occupationID = id
    }
    
    func getSelectedOccupationId() -> Double{
        
        return occupationID
    }
    
    func setProfession(id: Double) {
        professionID = id
    }
    
    func getSelectedProfessionId() -> Double{
        
        return professionID
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
        currentConsumerList[foundIndex].occupationId = newUserInfo.occupationId
        currentConsumerList[foundIndex].professionId = newUserInfo.professionId
        currentConsumerList[foundIndex].genderId = modelRegistrationSteper.genderId == 0 ? nil : newUserInfo.genderId

        return currentConsumerList
    }
    //MARK: - For merging
    func getListOfConsumersForSVC(newUserInfo: BasicInfoConsumerListInputModel) -> [saveKYCObject] {
        var tempRdaCustomerProfileID = newUserInfo.rdaCustomerProfileId
        var tempRdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        
        let cousumerListHamza = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        var currentConsumerList = getCurrentConsumerListResponseInInputModel(responseCunsumerList: cousumerListHamza!)
        let cousumerListShakeel = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList
        var foundIndex = 99
        
        
        var arraySaveKYCObject = [saveKYCObject]()
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
                         let consumerListKYCData = saveKYCObject(rdaCustomerAccInfoId: ($0.accountInformation?.rdaCustomerAccInfoID)!, rdaCustomerProfileId: $0.rdaCustomerProfileID , isPrimary: $0.isPrimary, relationCode1: DataCacheManager.shared.loadAdditionalApplicantRelationship()?.id, averageMonthlySalary: $0.accountInformation?.averageMonthlySalary)
                        arraySaveKYCObject.append(consumerListKYCData!)
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
            let consumerListKYCData = saveKYCObject(
                rdaCustomerAccInfoId: (newUserInfo.rdaCustomerAccInfoId)!,
                rdaCustomerProfileId: newUserInfo.rdaCustomerProfileId ,
                isPrimary: true,
                relationCode1: DataCacheManager.shared.loadAdditionalApplicantRelationship()?.id,
                averageMonthlySalary: newUserInfo.accountInformation?.averageMonthlySalary
            )
            
            arraySaveKYCObject.append(consumerListKYCData!)
            currentConsumerList[foundIndex].isPrimary = true
        }
        
        arraySaveKYCObject[foundIndex].rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
        arraySaveKYCObject[foundIndex].rdaCustomerProfileId = tempRdaCustomerProfileID
        
        arraySaveKYCObject[foundIndex].relationCode1 = newUserInfo.relationCode1
        arraySaveKYCObject[foundIndex].averageMonthlySalary = newUserInfo.averageMonthlySalary
                
        return arraySaveKYCObject
    }
}
