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
    var registerConsumerEmploymentDetailsResponse: Observable<RegisterConsumerEmploymentDetailsResponseModel?> { get }
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
    private(set) var registerConsumerEmploymentDetailsResponse: Observable<RegisterConsumerEmploymentDetailsResponseModel?> = Observable(nil)
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
        
        
        var consumerListInputModelArray = [EmploymentDetailsInputModel]()

//        guard let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList else { return }
//        viewAppGenerateResponseModel.forEach {
//            guard let customerAccInfoID = $0.accountInformation?.rdaCustomerAccInfoID, let customerProfiledID = $0.rdaCustomerProfileID,  let occupationId = $0.occupationID, let professionId = $0.professionID, let isPrimary = $0.isPrimary else { return }
//            guard let consumerListInputModel = EmploymentDetailsInputModel(rdaCustomerAccInfoId: customerAccInfoID, rdaCustomerProfileId: customerProfiledID, occupationId: Double(occupationId), professionId: Double(professionId), isPrimary: isPrimary)  else { return }
//
//            consumerListInputModelArray.append(consumerListInputModel)
//        }
        
        guard let employmentDetailsInput = EmploymentDetailsInputModel(rdaCustomerAccInfoId: customerAccInfoID, rdaCustomerProfileId: customerProfiledID, occupationId: occupationId, professionId: professionId, isPrimary: isPrimary) else { return }
//        consumerListInputModelArray.append(employmentDetailsInput)
        
        consumerListInputModelArray = getListOfConsumers(newUserInfo: employmentDetailsInput)

        guard let registerConsumerBasicInfoInput = RegisterConsumerEmploymentDetailsInputModel(consumerList: consumerListInputModelArray) else {return}
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
//        guard let rdaCustomerAccInfoId = rdaCustomerAccInfoId, let rdaCustomerProfileId= rdaCustomerProfileId, let isPrimary = isPrimary, let relationCode1 = relationCode1, let averageMonthlySalary = averageMonthlySalary else { return }
        guard let kycInfo = saveKYCObject(rdaCustomerAccInfoId: rdaCustomerAccInfoId, rdaCustomerProfileId: rdaCustomerProfileId, isPrimary: isPrimary, relationCode1: relationCode1, averageMonthlySalary: averageMonthlySalary) else { return }
        let viewAppGenerateResponseModel = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
        var consumerListInputModelArray = [saveKYCObject]()
        viewAppGenerateResponseModel?.forEach {
            guard let consumerListInputModel = saveKYCObject(rdaCustomerAccInfoId: ($0.accountInformation?.rdaCustomerAccInfoID)!, rdaCustomerProfileId: $0.rdaCustomerProfileID , isPrimary: $0.isPrimary, relationCode1: DataCacheManager.shared.loadAdditionalApplicantRelationship()?.id, averageMonthlySalary: $0.accountInformation?.averageMonthlySalary) else { return }
            
            consumerListInputModelArray.append(consumerListInputModel)
        }
        consumerListInputModelArray.append(kycInfo)
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
    func getListOfConsumers(newUserInfo: EmploymentDetailsInputModel) -> [EmploymentDetailsInputModel] {
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
        
        var consumerListInputModelArray = [EmploymentDetailsInputModel]()
        
        if let consumerListTemp = DataCacheManager.shared.getRegisterVerifyOTPResponseModel()?.consumerList {
            consumerListTemp.forEach {
                let consumerListInputModel = EmploymentDetailsInputModel(
                    rdaCustomerAccInfoId: ($0.accountInformation?.rdaCustomerAccInfoID)!,
                    rdaCustomerProfileId: $0.rdaCustomerProfileID!,
                    occupationId: Double($0.occupationID ?? 0),
                    professionId: Double($0.professionID ?? 0),
                    isPrimary: $0.isPrimary ?? false
                )
                consumerListInputModelArray.append(consumerListInputModel!)
            }
        }
        
        print("------Start-----Check if user is adding for joint account------")
        //MARK: - Start----- Just to check if user is trying for joint account this this check will become true
        if consumerListInputModelArray.count > 0 {
//            newUserInfo.isPrimaryRegistered = false
            newUserInfo.isPrimary = false
        }
        //MARK: - End----- Just to check if user is trying for joint account this this check will become true
        print("------End-----Check if user is adding for joint account------")
        
        consumerListInputModelArray.append(newUserInfo)
        return consumerListInputModelArray
    }
    


}
