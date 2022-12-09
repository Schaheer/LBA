//
//  ReviewDetailsViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 14/04/2022.
//

import Foundation

protocol ReviewDetailsViewModelProtocol {
    var consumerAccountDetail: Observable<RegisterVerifyOTPResponseModel?> { get }
    var routeToConfirmationVC: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    
    func getConsumerAccountDetail(
        rdaCustomerProfileID: Double?,
        rdaCustomerAccInfoID: Double?,
        customerTypeID: Double?
    )
    func openConfirmationVC()
}

final class ReviewDetailsViewModel: ReviewDetailsViewModelProtocol {
    
    private(set) var consumerAccountDetail: Observable<RegisterVerifyOTPResponseModel?> = Observable(nil)
    private(set) var routeToConfirmationVC: Observable<Bool> = Observable(false)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    func getConsumerAccountDetail(
        rdaCustomerProfileID: Double?,
        rdaCustomerAccInfoID: Double?,
        customerTypeID: Double?
    ) {
        guard
            let rdaCustomerProfileID = rdaCustomerProfileID,
            let rdaCustomerAccInfoID = rdaCustomerAccInfoID,
            let customerTypeID = customerTypeID
        else {
            self.errorMessage.value = "All fields required"
            return }
        
        guard let input = ConsumerAccountDetailInputModel(
            rdaCustomerProfileID: rdaCustomerProfileID,
            rdaCustomerAccInfoID: rdaCustomerAccInfoID,
            customerTypeID: customerTypeID
        ) else { return }
        
        APIManager.shared.getConsumerAccountDetail(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.consumerAccountDetail.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func openConfirmationVC() {
        routeToConfirmationVC.value = true
    }
}
