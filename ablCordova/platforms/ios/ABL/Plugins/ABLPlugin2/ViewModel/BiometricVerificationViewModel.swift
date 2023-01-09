//
//  BiometricVerificationViewModel.swift
//  ABL
//
//  Created by Hamza Amin on 3/15/22.
//

import Foundation

protocol BiometricVerificationDelegate{
    
    func biometricVerificationDone(response: VerifyBiometricNadraResponseModel)
    func biometricVerificationError(error: String)
}

class BiometricVerificationViewModel{
    
    var delegate: BiometricVerificationDelegate?
    
    func verifyBiometricNadra(data: VerifyBiometricNadraInputData) {
        
        guard let input = VerifyBiometricNadraInputModel(data: data ) else { return }
        
        APIManager.shared.verifyBiometricNadra(input: input) { response in
//            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                print(value, "verifyBiometricNadra, ")
                self.delegate?.biometricVerificationDone(response: value)
//                self.openVerifyOTPVC(with: input)
            case .failure(let error):
//                logsManager.debug(error.errorDescription)
                self.delegate?.biometricVerificationError(error: error.errorDescription!)
            }
        }
    }
}
