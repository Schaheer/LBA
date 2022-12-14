//
//  CNICVerificationViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/03/2022.
//

import Foundation

protocol CNICVerificationViewModelProtocol {
    var openAccountUserData: Observable<ViewAppGenerateOTPResponseModel?> { get }
    var saveKYCResponseData: Observable<SaveKYCResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var routeToVerifyOTPVC: Observable<Bool> { get }
    var routeToPersonalInformationVC: Observable<Bool> { get }
    var routeToManualVeificationVC: Observable<Bool> { get }
    
    func viewAppGenerateOTPWithAttachment(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?,
        cnicFront: String?,
        cnicBack: String?,
        isPortedMobileNetwork: Bool?
    )
    
    func openVerifyOTPVC()
    func openPersonalInformationVC()
}

final class CNICVerificationViewModel: CNICVerificationViewModelProtocol {
    private(set) var openAccountUserData: Observable<ViewAppGenerateOTPResponseModel?> = Observable(nil)
    private(set) var saveKYCResponseData: Observable<SaveKYCResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var routeToVerifyOTPVC: Observable<Bool> = Observable(false)
    private(set) var routeToManualVeificationVC: Observable<Bool> = Observable(false)
    private(set) var routeToPersonalInformationVC: Observable<Bool> = Observable(false)
    
    func viewAppGenerateOTPWithAttachment(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?,
        cnicFront: String?,
        cnicBack: String?,
        isPortedMobileNetwork: Bool?
    ) {
        guard
            let customerTypeID = customerTypeID,
            let mobileNumber = mobileNumber,
            let generateOTP = generateOTP,
            let isPortedMobileNetwork = isPortedMobileNetwork
        else { return }
        
        if cnicFront?.isEmpty == false && cnicBack?.isEmpty == false {
            guard
                let cnicFrontAttachmentInput = CNICAttachmentInputModel(
                    fileName: "CNIC FRONT",
                    base64Content: cnicFront ?? "",
                    attachmentTypeID: BaseConstants.AttachmentTypeIDs.cnicFrontTypeID
                ),
                let cnicBackAttachmentInput = CNICAttachmentInputModel(
                    fileName: "CNIC BACK",
                    base64Content: cnicBack ?? "",
                    attachmentTypeID: BaseConstants.AttachmentTypeIDs.cnicBackTypeID
                )
            else { return }
            
            guard let viewAppGenerateOTPInput = ViewAppGenerateOTPInputModel(
                customerTypeID: customerTypeID,
                mobileNumber: mobileNumber,
                generateOTP: generateOTP,
                attachments: [cnicFrontAttachmentInput, cnicBackAttachmentInput],
                isPortedMobileNetwork: isPortedMobileNetwork
            ) else { return }
            
            APIManager.shared.viewAppsGenerateOTP(input: viewAppGenerateOTPInput) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.openAccountUserData.value = value
                    DataCacheManager.shared.saveCnicFrontBackModel(frontCnic: cnicFrontAttachmentInput, backCnic: cnicBackAttachmentInput)
                    
                    DataCacheManager.shared.saveViewAppGenerateOTPWithData(input: viewAppGenerateOTPInput)
                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "Please take pictures of cnic front and back side"
        }
    }
    
    func viewAppGenerateOTPWithoutAttachment(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?,
        idNumber: String?,
        dateofExpiry: String?
    ) {
        guard
            let customerTypeID = customerTypeID,
            let mobileNumber = mobileNumber,
            let generateOTP = generateOTP,
            let idNumber = idNumber,
            let dateofExpiry = dateofExpiry
        else { return }
        
        if dateofExpiry.isEmpty == false && idNumber.isEmpty == false {
            
            guard let viewAppGenerateOTPInput = ViewAppGenerateOTPInputModel(
                customerTypeID: customerTypeID,
                mobileNumber: mobileNumber,
                generateOTP: generateOTP,
                cnicNumber: idNumber,
                dateofExpiry: dateofExpiry
            ) else { return }
            
            APIManager.shared.viewAppsGenerateOTP(input: viewAppGenerateOTPInput) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.openAccountUserData.value = value
                    
                    DataCacheManager.shared.saveViewAppGenerateOTPWithData(input: viewAppGenerateOTPInput)
                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "Values can not be empty"
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
    
    func openVerifyOTPVC() {
        routeToVerifyOTPVC.value = true
    }
    
    func openVerifyCNICManually() {
        routeToManualVeificationVC.value = true
    }
    
    func openPersonalInformationVC() {
        routeToPersonalInformationVC.value = true
    }
}
