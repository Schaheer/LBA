//
//  CNICAvailabilityViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 24/03/2022.
//

import Foundation

protocol CNICAvailabilityViewModelProtocol {
    
    var viewAppGenerateOTPResponse: Observable<ViewAppGenerateOTPResponseModel?> { get }
    var viewAppGenerateOTPWithDataResponse: Observable<ViewAppGenerateOTPResponseModel?> { get }
    var mobileNetworks: Observable<MobileNetworkResponseModel?> { get }
    var routeToCNICVerification: Observable<Bool> { get }
    var routeToVerifyOTP: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    var routeToPersonalInformationVC: Observable<Bool> { get }
    
    func viewAppGenerateOTP(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?
    )
    
    func viewAppGenerateOTPWithCNIC(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?,
        cnicNumber: String?,
        isPortedMobileNetwork: Bool?
    )
    
    func getMobileNetworks(codeTypeID: Int)
    
    func openCNICVerificationVC()
    func openVerifyOTPVC()
    func openPersonalInformationVC()
    
    func setShouldGenerateOTP(shouldGenerate: Bool)
    func getShouldGenerateOTP() -> Bool
}

class CNICAvailabilityViewModel: CNICAvailabilityViewModelProtocol {
    private(set) var viewAppGenerateOTPResponse: Observable<ViewAppGenerateOTPResponseModel?> = Observable(nil)
    private(set) var viewAppGenerateOTPWithDataResponse: Observable<ViewAppGenerateOTPResponseModel?> = Observable(nil)
    private(set) var mobileNetworks: Observable<MobileNetworkResponseModel?> = Observable(nil)
    private(set) var routeToCNICVerification: Observable<Bool> = Observable(false)
    private(set) var routeToVerifyOTP: Observable<Bool> = Observable(false)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var routeToPersonalInformationVC: Observable<Bool> = Observable(false)
    
    private var shouldGenerateOTP = false
    
    func viewAppGenerateOTP(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?
    ) {
        guard
            let customerTypeID = customerTypeID,
            let mobileNumber = mobileNumber,
            let generateOTP = generateOTP
        else { return }
        
        if !mobileNumber.isEmpty {
            if mobileNumber.isValidPhoneNumber{
                guard let viewAppGenerateOTPInput = ViewAppGenerateOTPInputModel(
                    customerTypeID: customerTypeID,
                    mobileNumber: mobileNumber.replacingOccurrences(of: "-", with: ""),
                    generateOTP: generateOTP
                ) else { return }
                
                APIManager.shared.viewAppsGenerateOTP(input: viewAppGenerateOTPInput) { [weak self] response in
                    guard let self = self else { return }
                    
                    switch response.result {
                    case .success(let value):
                        self.viewAppGenerateOTPResponse.value = value
                    case .failure(let error):
                        self.errorMessage.value = error.errorDescription
                    }
                }
            }else {
                errorMessage.value = "Mobile number is invalid"
            }
            
        } else {
            errorMessage.value = "Mobile number is required"
        }
    }
    
    func viewAppGenerateOTPWithCNIC(
        customerTypeID: Double?,
        mobileNumber: String?,
        generateOTP: Bool?,
        cnicNumber: String?,
        isPortedMobileNetwork: Bool?
    ) {
        guard
            let customerTypeID = customerTypeID,
            let mobileNumber = mobileNumber,
            let generateOTP = generateOTP,
            let cnicNumber = cnicNumber,
            let isPortedMobileNetwork = isPortedMobileNetwork
        else { return }
        
        if !mobileNumber.isEmpty && !cnicNumber.isEmpty {
            guard let viewAppGenerateOTPInput = ViewAppGenerateOTPInputModel(
                customerTypeID: customerTypeID,
                mobileNumber: mobileNumber.replacingOccurrences(of: "-", with: ""),
                generateOTP: generateOTP,
                cnicNumber: cnicNumber.replacingOccurrences(of: "-", with: ""),
                isPortedMobileNetwork: isPortedMobileNetwork
            ) else { return }
            
            APIManager.shared.viewAppsGenerateOTP(input: viewAppGenerateOTPInput) { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let value):
                    self.viewAppGenerateOTPWithDataResponse.value = value
                    DataCacheManager.shared.saveViewAppGenerateOTPWithData(input: viewAppGenerateOTPInput)
                case .failure(let error):
                    self.errorMessage.value = error.errorDescription
                }
            }
        } else {
            errorMessage.value = "All fields are required"
        }
    }
    
    func getMobileNetworks(codeTypeID: Int) {
        guard
            let mobileNetworkInput = MobileNetworkInputModel(codeTypeID: codeTypeID)
        else { return }
        
        APIManager.shared.getMobileNetworks(input: mobileNetworkInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.mobileNetworks.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func openCNICVerificationVC() {
        routeToCNICVerification.value = true
    }
    
    func openVerifyOTPVC() {
        routeToVerifyOTP.value = true
    }
    
    func openPersonalInformationVC() {
        routeToPersonalInformationVC.value = true
    }
    
    func setShouldGenerateOTP(shouldGenerate: Bool) {
        shouldGenerateOTP = shouldGenerate
    }
    
    func getShouldGenerateOTP() -> Bool {
        return shouldGenerateOTP
    }
}
