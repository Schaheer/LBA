//
//  NextOfKinViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 23/05/2022.
//

import Foundation

protocol NextOfKinViewModelProtocol {
    var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    
    func registerConsumerBasicInfo(
        customerAccInfoID: Double?,
        customerProfileID: Double?,
        kinName: String?,
        kinCNIC: String?,
        kinMobileNumber: String?,
        isPrimary: Bool?
    )
}

final class NextOfKinViewModel: NextOfKinViewModelProtocol {
    
    private(set) var registerConsumerBasicInfoResponse: Observable<RegisterConsumerBasicInfoResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    func registerConsumerBasicInfo(
        customerAccInfoID: Double?,
        customerProfileID: Double?,
        kinName: String?,
        kinCNIC: String?,
        kinMobileNumber: String?,
        isPrimary: Bool?
    ) {
        guard
            let customerAccInfoID = customerAccInfoID,
            let customerProfileID = customerProfileID,
            let kinName = kinName,
            let kinCNIC = kinCNIC,
            let kinMobileNumber = kinMobileNumber,
            let isPrimary = isPrimary
        else { return }
        
        if !kinName.isEmpty && !kinCNIC.isEmpty && !kinMobileNumber.isEmpty {
            
            guard
                let consumerList = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList
            else { return }
            
            var consumersList = [BasicInfoConsumerListInputModel]()
            
            consumerList.forEach {
                guard
                    let rdaCustomerAccInfoID = $0.accountInformation?.rdaCustomerAccInfoID,
                    let rdaCustomerProfileID = $0.rdaCustomerProfileID,
                    let kinName = $0.kinName,
                    let kinCNIC = $0.kinCNIC,
                    let kinMobileNumber = $0.kinMobile,
                    let isPrimary = $0.isPrimary
                else { return }
                
                guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                    rdaCustomerAccInfoId: rdaCustomerAccInfoID,
                    rdaCustomerProfileId: rdaCustomerProfileID,
                    kinName: kinName,
                    kinCNIC: kinCNIC,
                    kinMobileNumber: kinMobileNumber,
                    isPrimary: isPrimary
//                    ,genderId: modelRegistrationSteper.genderId
                ) else { return }
                
                consumersList.append(consumerListInputModel)
            }
            
            guard let consumerListInputModel = BasicInfoConsumerListInputModel(
                rdaCustomerAccInfoId: customerAccInfoID,
                rdaCustomerProfileId: customerProfileID,
                kinName: kinName,
                kinCNIC: kinCNIC,
                kinMobileNumber: kinMobileNumber,
                isPrimary: isPrimary
//                ,genderId: modelRegistrationSteper.genderId

            ) else { return }
            
            consumersList.append(consumerListInputModel)
            
            guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(
                consumerList: consumersList
            ) else { return }
            
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
}
