//
//  ChangeNumberViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 19/04/2022.
//

import Foundation

protocol ChangeNumberViewModelProtocol {
    var changeNumberResponse: Observable<ChangeNumberResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var routeToCNICAvailabilityVC: Observable<Bool> { get }
    
    func changeNumber(
        mobileNumber: String?,
        rdaCustomerProfileID: Double?
    )
    func openCNICAvailabilityVC()
}

final class ChangeNumberViewModel: ChangeNumberViewModelProtocol {
    private(set) var changeNumberResponse: Observable<ChangeNumberResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var routeToCNICAvailabilityVC: Observable<Bool> = Observable(false)
    
    func changeNumber(
        mobileNumber: String?,
        rdaCustomerProfileID: Double?
    ) {
        guard
            let mobileNumber = mobileNumber,
            let rdaCustomerProfileID = rdaCustomerProfileID
        else { return }
        
        if !mobileNumber.isEmpty {
            guard let input = ChangeNumberInputModel(
                mobileNumber: mobileNumber,
                rdaCustomerProfileID: rdaCustomerProfileID
            ) else { return }
            
            APIManager.shared.changeMobileNumber(input: input) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.changeNumberResponse.value = value
                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "Please enter a valid mobile number"
        }
    }
    
    func openCNICAvailabilityVC() {
        routeToCNICAvailabilityVC.value = true
    }
}
