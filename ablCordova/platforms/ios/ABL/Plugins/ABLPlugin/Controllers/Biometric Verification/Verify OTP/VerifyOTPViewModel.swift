//
//  VerifyOTPViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 14/03/2022.
//

import Foundation

protocol VerifyOTPViewModelProtocol {
    var didVerifyOTP: Observable<Bool> { get }
    var userData: Observable<RequestBiometricResponseModel?> { get }
    var getDraftedAppsUserData: Observable<GetDraftedAppsVerifyOTPResponseModel?> { get }
    var openAccountUserData: Observable<ViewAppGenerateOTPResponseModel?> { get }
    var routeToBiometricVerificationVC: Observable<Bool> { get }
    var routeToResumeApplicationVC: Observable<Bool> { get }
//    var routeToSelectBankingMethodVC: Observable<Bool> { get }
    var routeToChangeNumberVC: Observable<Bool> { get }
    var timerIsUp: Observable<Bool> { get }
    var timerDisplayText: Observable<String?> { get }
    var isResendEnabled: Observable<Bool> { get }
    var error: Observable<String?> { get }
    
    func verifyBiometricOTP(_ otp: String, rdaCustomerProfileID: Double)
    func resendBiometricOTP(with input: RequestBiometricInputModel?)
    func verifyCnicUploadOTP(
        customerTypeID: Double?,
        cnicNumber: String?,
        mobileNumber: String?,
        otp: String?
    )
    func resendCnicUploadOTP(with input: ViewAppGenerateOTPInputModel?)
    
    func openBiometricVerificationVC()
    func openResumeApplicationVC()
//    func openSelectBankingMethodVC()
    func openChangeNumberVC()
}

class VerifyOTPViewModel: VerifyOTPViewModelProtocol {
    
    private(set) var didVerifyOTP: Observable<Bool> = Observable(false)
    private(set) var userData: Observable<RequestBiometricResponseModel?> = Observable(nil)
    private(set) var getDraftedAppsUserData: Observable<GetDraftedAppsVerifyOTPResponseModel?> = Observable(nil)
    private(set) var openAccountUserData: Observable<ViewAppGenerateOTPResponseModel?> = Observable(nil)
    private(set) var routeToBiometricVerificationVC: Observable<Bool> = Observable(false)
    private(set) var routeToResumeApplicationVC: Observable<Bool> = Observable(false)
//    private(set) var routeToSelectBankingMethodVC: Observable<Bool> = Observable(false)
    private(set) var routeToChangeNumberVC: Observable<Bool> = Observable(false)
    private var timerSeconds: Int = 300
    private(set) var timerIsUp: Observable<Bool> = Observable(false)
    private(set) var timerDisplayText: Observable<String?> = Observable(nil)
    private(set) var isResendEnabled: Observable<Bool> = Observable(false)
    
    private(set) var error: Observable<String?> = Observable(nil)
    
    private var timer: Timer?
    
    func verifyBiometricOTP(_ otp: String, rdaCustomerProfileID: Double) {
        guard let input = VerifyBiometricOTPInputModel(
            otp: otp,
            rdaCustomerProfileID: rdaCustomerProfileID
        ) else { return }
        
        APIManager.shared.verifyBiometricOTP(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(_):
                self.didVerifyOTP.value = true
            case .failure(let error):
                self.error.value = error.errorDescription
            }
        }
    }
    
    func verifyCnicUploadOTP(customerTypeID: Double?, cnicNumber: String?, mobileNumber: String?, otp: String?) {
        guard
            let customerTypeID = customerTypeID,
            let cnicNumber = cnicNumber,
            let mobileNumber = mobileNumber,
            let otp = otp
        else { return }
        
        guard
            let input = GetDraftedAppsVerifyOTPInputModel(
                customerTypeID: customerTypeID,
                idNumber: cnicNumber,
                mobileNumber: mobileNumber,
                otp: otp,
                page: 1,
                size: 10,
                totalPages: 0,
                totalElements: 0,
                sortOrder: "",
                sortBy: ""
            )
        else { return }
        
        
        APIManager.shared.getDraftedAppsVerifyOTP(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.getDraftedAppsUserData.value = value
            case .failure(let error):
                self.error.value = error.errorDescription
            }
        }
    }
    
    func resendBiometricOTP(with input: RequestBiometricInputModel?) {
        guard let input = input else { return }
        
        APIManager.shared.requestBiometric(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.userData.value = value
            case .failure(let error):
                self.error.value = error.errorDescription
            }
        }
    }
    
    func resendCnicUploadOTP(with input: ViewAppGenerateOTPInputModel?) {
        guard let input = input else { return }
        
        APIManager.shared.viewAppsGenerateOTP(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.openAccountUserData.value = value
            case .failure(let error):
                self.error.value = error.errorDescription
            }
        }
    }
    
    func openBiometricVerificationVC() {
        routeToBiometricVerificationVC.value = true
    }
    
    func openResumeApplicationVC() {
        routeToResumeApplicationVC.value = true
    }
    
//    func openSelectBankingMethodVC() {
//        routeToSelectBankingMethodVC.value = true
//    }
    
    
    func openChangeNumberVC() {
        routeToChangeNumberVC.value = true
    }
    
    func fireTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: (#selector(updateTimer)),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
    }
    
    @objc
    private func updateTimer() {
        if timerSeconds < 1 {
            timerIsUp.value = true
            isResendEnabled.value = true
        } else {
            timerSeconds -= 1
            timerDisplayText.value = timeString(time: TimeInterval(timerSeconds)) + " Minutes"
        }
    }
    
    func resetTimer() {
        invalidateTimer()
        timerSeconds = 300
        timerDisplayText.value = timeString(time: TimeInterval(timerSeconds)) + " Minutes"
        isResendEnabled.value = false
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func invalidateTimer() {
        timer?.invalidate()
    }
}
