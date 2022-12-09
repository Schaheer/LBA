//
//  PicAndSignViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 4/19/22.
//

import Foundation

protocol PicAndSignViewModelProtocol{
    
    var saveAttachmentResponse: Observable<SaveAttachmentResponseModel?> { get }
    var registerPicAndSignResponse: Observable<RegisterPicAndSignResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var natureOfAccount: Observable<NatureOfAccount?> { get }
    var dropDownTapped: Observable<Bool> { get }
    
    func getNatureOfAccount() -> NatureOfAccount?
    func setNoOfJointApplicants(applicants: Int)
    func getNoOfJointApplicants() -> Int
}

class PicAndSignViewModel: PicAndSignViewModelProtocol{


    private(set) var saveAttachmentResponse: Observable<SaveAttachmentResponseModel?> = Observable(nil)
    private(set) var registerPicAndSignResponse: Observable<RegisterPicAndSignResponseModel?> = Observable(nil)
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
            let rdaCustomerId = rdaCustomerId,
            let customerTypeId = customerTypeId,
            let natureOfAccountId = natureOfAccountId,
            let noOfJointApplicatns = noOfJointApplicatns,
            let nameOnPhysicalATM = nameOnPhysicalATM
        else {
            self.errorMessage.value = "All fields required"
            return
            
        }
//        natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_CASH);
//        natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_CLEARING);
//        natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_DOMESTIC_REMITTANCE);
//        natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_INTER_INTRA_BRANCH);
//
//        if (getIntFromPref(Config.ACCOUNT_VARIANT_ID) == Config.REMITTANCE_ACCOUNT) {
//            natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_FOREIGN_REMITTANCE);
//        }
//        if (getBoolFromPref(Config.IS_ATM_SELECTED)){
//            natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_ATM);
//            natureOfAccountPostParams.getData().getModeOfMajorTransId().add(Config.MODE_OF_MAJOR_TRANS_INTERNET_BANKING);
//        }
//
//        public static int MODE_OF_MAJOR_TRANS_CASH = 108401;
//
//        public static int MODE_OF_MAJOR_TRANS_CLEARING = 108402;
//
//        public static int MODE_OF_MAJOR_TRANS_DOMESTIC_REMITTANCE = 108403;
//
//        public static int MODE_OF_MAJOR_TRANS_INTER_INTRA_BRANCH = 108405;
//
//        public static int MODE_OF_MAJOR_TRANS_FOREIGN_REMITTANCE = 108404;
//
//        public static int MODE_OF_MAJOR_TRANS_ATM = 108406;
//
//        public static int MODE_OF_MAJOR_TRANS_INTERNET_BANKING = 108407;
        
        //TODO: add checks for isAtmSelected
        var modeOfTransId: [Double] = [108401, 108402, 108403, 108405]
        
        guard let registerPicAndSignConsumerInput = RegisterPicAndSignConsumerInputModel(rdaCustomerAccInfoId: rdaCustomerAccInfoId, rdaCustomerId: rdaCustomerId, customerTypeId: customerTypeId, natureOfAccountId: natureOfAccountId, noOfJointApplicatns: noOfJointApplicatns, rdaCustomerProfileId: rdaCustomerProfileId, nameOnPhysicalATM: nameOnPhysicalATM, modeOfMajorTransId: modeOfTransId ) else { return }
        guard let registerPicAndSignInput = RegisterPicAndSignInputModel(consumerList: [registerPicAndSignConsumerInput]) else { return }
        APIManager.shared.savePicAndSign(input: registerPicAndSignInput) { [weak self] response in
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
}
