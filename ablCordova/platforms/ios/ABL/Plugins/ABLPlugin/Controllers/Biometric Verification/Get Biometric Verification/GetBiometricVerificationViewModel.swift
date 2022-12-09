//
//  GetBiometricVerificationViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 10/03/2022.
//

import Foundation

protocol GetBiometricVerificationViewModelProtocol {
    var userData: Observable<RequestBiometricResponseModel?> { get set }
    var requestBiometricInputModel: RequestBiometricInputModel? { get }
    var routeToVerifyOTP: Observable<Bool> { get }
    
    func requestBiometricVerification(cnic: String, accountNumber: String)
    func openVerifyOTPVC()
}

class GetBiometricVerificationViewModel: GetBiometricVerificationViewModelProtocol {
    var userData: Observable<RequestBiometricResponseModel?> = Observable(nil)
    private(set) var requestBiometricInputModel: RequestBiometricInputModel? = nil
    private(set) var routeToVerifyOTP: Observable<Bool> = Observable(false)
    
    func requestBiometricVerification(cnic: String, accountNumber: String) {
        guard let input = RequestBiometricInputModel(
            cnic: cnic,
            accountNumber: accountNumber
        ) else { return }
        requestBiometricInputModel = input
        
        APIManager.shared.requestBiometric(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.userData.value = value
            case .failure(let error):
                logsManager.error(error)
            }
        }
    }
    
    func getRequestBiometricInputModel() -> RequestBiometricInputModel? {
        return requestBiometricInputModel
    }
    
    func openVerifyOTPVC() {
        routeToVerifyOTP.value = true
    }
}
