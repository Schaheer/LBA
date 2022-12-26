//
//  ServiceChannelsViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/18/22.
//

import Foundation

protocol ServiceChannelsViewModelProtocol{
    
    var registerConsumerTransactionDetailsResponse: Observable<RegisterVerifyOTPResponseModel?> { get }
    
    var reasonDropDownTapped: Observable<Bool> { get }

    var errorMessage: Observable<String?> { get }
    var atmTypes: Observable<CodeTypeResponseModel?> { get }
    var reasonTypes: Observable<CodeTypeResponseModel?> { get }

    var selectedAtmTypeID: Observable<Double?> { get }
    
    func getATMTypes(codeTypeID: Int)
    func getAccountVariantID() -> Double
}



class ServiceChannelsViewModel{
    private(set) var reasonDropDownTapped: Observable<Bool> = Observable(false)
    private(set) var registerConsumerTransactionDetailsResponse: Observable<RegisterVerifyOTPResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var atmTypes: Observable<CodeTypeResponseModel?> = Observable(nil)
    private(set) var reasonTypes: Observable<CodeTypeResponseModel?> = Observable(nil)

    private(set) var selectedAtmTypeID: Observable<Double?> = Observable(nil)
    private var reasonID: Double = 0

    func registerConsumerEmploymentDetails(
        customerAccInfoID: Double?,
        rdaCustomerId: Double?,
        customerTypeId: Double?,
        atmTypeId: Double?,
        physicalCardInd: Int?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertId: Double?,
        rdaCustomerProfileId: Double?,
        reasonForVisaDebitCardRequestId: Double?
        
    ) {
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        
        guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: customerAccInfoID,
            rdaCustomerProfileId: rdaCustomerId,
            isPrimary: true,
            taxResidentInd: 0,
            customerTypeId: customerTypeId,
            atmTypeId: atmTypeId,
            physicalCardInd: physicalCardInd,
            transAlertInd: transAlertInd,
            chequeBookReqInd: chequeBookReqInd
            
        ) else { return }
        consumerListInputModelArray = getListOfConsumers(newUserInfo: basicInfoConsumerListInput)
        
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(consumerList: consumerListInputModelArray) else {return}
        
        APIManager.shared.setupConsumerTransactionDetails(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerTransactionDetailsResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    
    func getATMTypes(codeTypeID: Int) {
        
        guard let input = CodeTypeInputModel(codeTypeID: codeTypeID) else { return }
        
        APIManager.shared.lookupInformation(input: input) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                self.atmTypes.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getReasons(codeTypeID: Int) {
        guard let input = CodeTypeInputModel(codeTypeID: codeTypeID) else { return }
        APIManager.shared.lookupInformation(input: input) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                self.reasonTypes.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getReason(at index: Int) -> CodeTypeDataModel? {
        return reasonTypes.value?.data?[index]
    }
    
    func setReason(id: Double) {// selected reason is stored in
        reasonID = id
    }
    func getReasonSelected() -> Double {// selected reason is stored in
        return reasonID
    }
    
    @objc
    func openReasonDropdown() {
        reasonDropDownTapped.value = true
    }
    
    func setSelectedATMTypeID(accountVariantID: Double) {
        self.selectedAtmTypeID.value = accountVariantID
    }
    
    func getSelectedATMTypeID() -> Double?{
        return selectedAtmTypeID.value
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
        
//        currentConsumerList[foundIndex].rdaCustomerAccInfoId = tempRdaCustomerAccInfoId
//        currentConsumerList[foundIndex].rdaCustomerProfileId = tempRdaCustomerProfileID
        
        
        currentConsumerList[foundIndex].rdaCustomerAccInfoId = newUserInfo.rdaCustomerAccInfoId
        currentConsumerList[foundIndex].rdaCustomerProfileId = newUserInfo.rdaCustomerProfileId
        currentConsumerList[foundIndex].customerTypeId = newUserInfo.customerTypeId
        currentConsumerList[foundIndex].atmTypeId = newUserInfo.atmTypeId
        currentConsumerList[foundIndex].physicalCardInd = newUserInfo.physicalCardInd
        currentConsumerList[foundIndex].transAlertInd = newUserInfo.transAlertInd
        currentConsumerList[foundIndex].chequeBookReqInd = newUserInfo.chequeBookReqInd
        currentConsumerList[foundIndex].transactionalAlertId = newUserInfo.transactionalAlertId
        currentConsumerList[foundIndex].reasonForVisaDebitCardRequestId = newUserInfo.reasonForVisaDebitCardRequestId
        return currentConsumerList
    }
}
