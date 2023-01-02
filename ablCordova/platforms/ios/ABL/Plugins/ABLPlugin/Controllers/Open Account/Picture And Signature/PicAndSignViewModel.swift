//
//  PicAndSignViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/19/22.
//

import Foundation

protocol PicAndSignViewModelProtocol{
    
    var saveAttachmentResponse: Observable<SaveAttachmentResponseModel?> { get }
    var registerPicAndSignResponse: Observable<RegisterVerifyOTPResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var natureOfAccount: Observable<NatureOfAccount?> { get }
    var dropDownTapped: Observable<Bool> { get }
    
    func getNatureOfAccount() -> NatureOfAccount?
    func setNoOfJointApplicants(applicants: Int)
    func getNoOfJointApplicants() -> Int
}

class PicAndSignViewModel: PicAndSignViewModelProtocol{


    private(set) var saveAttachmentResponse: Observable<SaveAttachmentResponseModel?> = Observable(nil)
    private(set) var registerPicAndSignResponse: Observable<RegisterVerifyOTPResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var natureOfAccount: Observable<NatureOfAccount?> = Observable(nil)
    private(set) var dropDownTapped: Observable<Bool> = Observable(false)
    
    private var noOfJointApplicants = 0
    
    func saveAttachment(
        attachmentTypeId: Double?,
        entityId: Double?,
        fileName: String?,
        mimeType: String?,
        path: String?,
        base64Content: String?,
        rdaCustomerAccInfoId: Double?
    ) {
        guard
            let attachmentTypeId = attachmentTypeId,
            let entityId = entityId,
            let fileName = fileName,
            let mimeType = mimeType,
            let path = path,
            let base64Content = base64Content,
            let rdaCustomerAccInfoId = rdaCustomerAccInfoId
        else { return }
        
        if base64Content.isEmpty == false {
            
            guard let saveAttachmentInput = SaveAttachmentInputModel(rdaCustomerAccInfoId: rdaCustomerAccInfoId, attachmentTypeId: attachmentTypeId, entityId: entityId, fileName: fileName, mimeType: mimeType, path: path, base64Content: base64Content) else { return }
            
            APIManager.shared.saveAttachment(input: saveAttachmentInput) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.saveAttachmentResponse.value = value
                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "Please take pictures first"
        }
    }

//accountVariantId: 108243atmTypeId: nullbankingModeId: 114201chequeBookReqInd: 1customerAccountTypeId: 114301customerBranch: "7-E, GULBERG LAHORE"customerTypeId: 106501
//natureOfAccountId: 102102noOfJointApplicatns: "1"pdaRemitterDetailList: []physicalCardInd: 0proofOfIncomeInd: 0purposeOfAccountId: 108105rdaCustomerAccInfoId: 5678rdaCustomerId: 5793transAlertInd: 0transactionalAlertId: null
    func saveNatureOfAccount(
//        accountVariantId: Double?,
//        atmTypeId: Double?,
//        chequeBookReqInd: Int?,
//        customerAccountTypeId: Double?,
//        customerBranch: String?,
//        physicalCardInd: Int?,
//        proofOfIncomeInd: Int?,
//        purposeOfAccountId: Double?,
//        transAlertInd: Int?,
//        transactionalAlertId: Double?
        rdaCustomerProfileId: Double?,
        rdaCustomerAccInfoId: Double?,
        rdaCustomerId: Double?,
        customerTypeId: Double?,
        natureOfAccountId: Double?,
        noOfJointApplicatns: Int?,
        nameOnPhysicalATM: String?
        
    ) {
        guard
            let rdaCustomerProfileId = rdaCustomerProfileId,
            let rdaCustomerAccInfoId = rdaCustomerAccInfoId,
            let customerTypeId = customerTypeId,
            let natureOfAccountId = natureOfAccountId,
            let noOfJointApplicatns = noOfJointApplicatns,
            let nameOnPhysicalATM = nameOnPhysicalATM
        else {
            self.errorMessage.value = "All fields required"
            return
        }

        //TODO: add checks for isAtmSelected
        let modeOfTransId: [Double] = [108401, 108402, 108403, 108405]
        var consumerListInputModelArray = [BasicInfoConsumerListInputModel]()
        
        guard let basicInfoConsumerListInput = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: rdaCustomerAccInfoId,
            rdaCustomerProfileId: rdaCustomerProfileId,
            isPrimary: true,
            customerTypeId: customerTypeId,
            natureOfAccountId: natureOfAccountId,
            noOfJointApplicatns: noOfJointApplicatns,
            nameOnPhysicalATM: nameOnPhysicalATM,
            modeOfMajorTransId: modeOfTransId
        ) else { return }
        
        consumerListInputModelArray = getListOfConsumers(newUserInfo: basicInfoConsumerListInput)
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(consumerList: consumerListInputModelArray) else {return}
        let primaryUser = getPrimaryUser()
        let accountInfo = DataCacheManager.shared.loadRegisterConsumerAccountInfoResponse()
        
        var accountTypeId = primaryUser.accountInformation?.customerAccountTypeID ?? 0
        guard let input = RegisterConsumerAccountInfoInputModel(
            rdaCustomerAccInfoID: primaryUser.rdaCustomerAccInfoId,
            rdaCustomerID: Int(primaryUser.rdaCustomerProfileID!),
            bankingModeID: (accountInfo?.data?.bankingModeID)!,
            customerAccountTypeID: (accountInfo?.data?.customerAccountTypeID)!,
            customerBranch: (accountInfo?.data?.customerBranch)!,
            customerTypeID: customerTypeId,
            purposeOfAccountID: (accountInfo?.data?.purposeOfAccountID)!,
            natureOfAccountID: natureOfAccountId,
            noOfJointApplicatns: noOfJointApplicatns,
            nameOnPhysicalATM: nameOnPhysicalATM,
            modeOfMajorTransId: modeOfTransId
//            genderId: modelRegistrationSteper.genderId
        ) else { return }
                
        APIManager.shared.savePicAndSign(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerPicAndSignResponse.value = value
                
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getNatureOfAccount() -> NatureOfAccount? {
        return natureOfAccount.value
    }
    
    func setNoOfJointApplicants(applicants: Int) {
        noOfJointApplicants = applicants
    }
    
    func getNoOfJointApplicants() -> Int {
        return noOfJointApplicants
    }
    
    @objc
    func singleAccountTapped() {
        natureOfAccount.value = .single
    }
    
    @objc
    func jointAccountTapped() {
        natureOfAccount.value = .joint
    }
    
    @objc
    func minorAccountTapped() {
        natureOfAccount.value = .minor
    }
    
    @objc
    func openDropdown() {
        dropDownTapped.value = true
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
        currentConsumerList[foundIndex].rdaCustomerId = tempRdaCustomerProfileID
        currentConsumerList[foundIndex].customerTypeId = newUserInfo.customerTypeId
        currentConsumerList[foundIndex].noOfJointApplicatns = newUserInfo.noOfJointApplicatns
        currentConsumerList[foundIndex].nameOnPhysicalATM = newUserInfo.nameOnPhysicalATM
        currentConsumerList[foundIndex].modeOfMajorTransId = newUserInfo.modeOfMajorTransId
        currentConsumerList[foundIndex].genderId = modelRegistrationSteper.genderId == 0 ? nil : newUserInfo.genderId
        currentConsumerList[foundIndex].residentCountries =  getCurrentUser().residentCountries

        return currentConsumerList
    }
}

