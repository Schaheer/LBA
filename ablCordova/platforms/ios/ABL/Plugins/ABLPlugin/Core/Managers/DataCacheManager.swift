//
//  DataCacheManager.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/03/2022.
//

import Foundation

final class DataCacheManager: NSObject {
    
    // MARK: - Manager Properties
    
    private let userDefaults = UserDefaults.standard
    private var userData: RequestBiometricResponseModel?
    private var authHeaders = [String: String]()
    private var viewAppGenerateOTPInput: ViewAppGenerateOTPInputModel?
    private var viewAppGenerateOTPResponse: ViewAppGenerateOTPResponseModel?
    private var draftedAppsData: GetDraftedAppsVerifyOTPResponseModel?
    private var registerVerifyOTPResponse: RegisterVerifyOTPResponseModel?
    private var viewAppGenerateOTPResponseArray = [[String: Any]]()
    
    static let shared: DataCacheManager = {
        return DataCacheManager()
    }()
    
    // MARK: - Manager Helper Methods
    
    func setAuthHeaders(for key: String, value: String) {
        authHeaders.updateValue(value, forKey: key)
    }
    
    func getAuthHeaders() -> [String: String] {
        loadAuthHeaders()
        return authHeaders
    }
    
    func loadAuthHeaders() {
        if let savedAuthHeaders = userDefaults.loadData(forKey: .authHeaders) as? [String: String] {
            authHeaders = savedAuthHeaders
        }
    }
    
//    func setUserData(userData: RequestBiometricResponseModel) {
//        self.userData = userData
//    }
    
    func saveUserData(userData: RequestBiometricResponseModel) {
//        logsManager.debug(userData.dictionaryRepresentation())
        userDefaults.saveData(userData.dictionaryRepresentation(), forKey: .userData)
    }
    
    func loadUserData() -> RequestBiometricResponseModel? {
        if let savedUserData = userDefaults.loadData(forKey: .userData) as? [String: Any] {
            return RequestBiometricResponseModel(JSON: savedUserData)
        }
        
        return nil
    }
    
//    func saveViewAppGenerateOTP(input: ViewAppGenerateOTPInputModel) {
//        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .viewAppGenerateOTP)
//    }
    
    //MARK: To send the object in case of resend OTP
    
    func saveViewAppGenerateOTPWithData(input: ViewAppGenerateOTPInputModel) {
        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .viewAppGenerateOTPWithData)
    }
    
    func loadViewAppGenerateOTPWithData() -> ViewAppGenerateOTPInputModel? {
        if let savedViewAppGenerateOTPWithCNIC = userDefaults.loadData(forKey: .viewAppGenerateOTPWithData) as? [String: Any] {
            return ViewAppGenerateOTPInputModel(JSON: savedViewAppGenerateOTPWithCNIC)
        }
        
        return nil
    }
    
    func saveViewAppGenerateOTPResponse(input: ViewAppGenerateOTPResponseModel) {
        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .viewAppGenerateOTPResponse)
    }
    
    
    func loadViewAppGenerateOTPResponse() -> ViewAppGenerateOTPResponseModel? {
        if let savedOpenAccountUserData = userDefaults.loadData(forKey: .viewAppGenerateOTPResponse) as? [String: Any] {
            return ViewAppGenerateOTPResponseModel(JSON: savedOpenAccountUserData)
        }

        return nil
    }
    
    func saveAccountTypeInfo(input: Double) {

        userDefaults.saveData(input, forKey: .accountTypeInfo)
    }
    
    func loadAccountType() -> Double? {
        if let savedOpenAccountUserData = userDefaults.loadData(forKey: .accountTypeInfo) as? Double {
            return savedOpenAccountUserData
        }

        return nil
    }
    
    func saveDraftedAppsData(input: GetDraftedAppsVerifyOTPResponseModel) {
        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .draftedAppsData)
    }
    
    func loadDraftedAppsData() -> GetDraftedAppsVerifyOTPResponseModel? {
        if let savedDraftedAppsData = userDefaults.loadData(forKey: .draftedAppsData) as? [String: Any] {
            return GetDraftedAppsVerifyOTPResponseModel(JSON: savedDraftedAppsData)
        }
        
        return nil
    }
    
    func saveRegisterVerifyOTPResponse(input: RegisterVerifyOTPResponseModel) {
        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .registerVerifyOTPResponse)
    }
    
    func loadRegisterVerifyOTPResponse() -> RegisterVerifyOTPResponseModel? {
        if let savedRegisterVerifyOTPResponse = userDefaults.loadData(forKey: .registerVerifyOTPResponse) as? [String: Any] {
            return RegisterVerifyOTPResponseModel(JSON: savedRegisterVerifyOTPResponse)
        }
        
        return nil
    }
    
    func saveRegisterConsumerAccountInfoResponse(input: RegisterConsumerAccountInfoResponseModel) {
        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .registerConsumerAccountInfoResponse)
    }
    
    func loadRegisterConsumerAccountInfoResponse() -> RegisterConsumerAccountInfoResponseModel? {
        if let savedRegisterConsumerAccountInfoResponse = userDefaults.loadData(
            forKey: .registerConsumerAccountInfoResponse
        ) as? [String: Any] {
            return RegisterConsumerAccountInfoResponseModel(JSON: savedRegisterConsumerAccountInfoResponse)
        }
        
        return nil
    }
    
    func saveAdditionalApplicantRelationship(input: CodeTypeDataModel) {
        userDefaults.saveData(input.dictionaryRepresentation(), forKey: .additionalApplicantRelationship)
    }
    
    func loadAdditionalApplicantRelationship() -> CodeTypeDataModel? {
        if let savedAdditionalApplicantRelationship = userDefaults.loadData(
            forKey: .additionalApplicantRelationship
        ) as? [String: Any] {
            return CodeTypeDataModel(JSON: savedAdditionalApplicantRelationship)
        }
        
        return nil
    }
    
    func saveNoOfJointApplicants(input: Int) {
        userDefaults.saveData(input, forKey: .noOfJointApplicants)
    }
    
    func loadNoOfJointApplicants() -> Int? {
        return userDefaults.loadData(forKey: .noOfJointApplicants) as? Int
    }
    
    func saveShouldGenerateOTP(input: Bool) {
        userDefaults.saveData(input, forKey: .shouldGenerateOTP)
    }
    
    func getShouldGenerateOTP() -> Bool? {
        return userDefaults.loadData(forKey: .shouldGenerateOTP) as? Bool
    }
    
    func clearFromCache() {
        userDefaults.removeData(forKey: .authHeaders)
    }
    
//    func appendViewAppGenerateOTPResponse(response: ViewAppGenerateOTPResponseModel) {
//        viewAppGenerateOTPResponseArray.append(response.dictionaryRepresentation())
//    }
    
    func getViewAppGenerateOTPResponseArray() -> [[String: Any]] {
        return viewAppGenerateOTPResponseArray
    }
    
//    func saveViewAppGenerateOTPResponseArray() {
//        userDefaults.saveData(viewAppGenerateOTPResponseArray, forKey: .viewAppGenerateOTPResponseArray)
//    }
    
//    func loadViewAppGenerateOTPResponseArray() -> [ViewAppGenerateOTPResponseModel] {
//        var viewAppGenerateOTPResponses = [ViewAppGenerateOTPResponseModel]()
//        
//        if let savedViewAppGenerateOTPResponses = userDefaults.loadData(forKey: .viewAppGenerateOTPResponseArray) as? [[String: Any]] {
//            savedViewAppGenerateOTPResponses.forEach {
//                guard let deserializedResponse = ViewAppGenerateOTPResponseModel(JSON: $0) else { return }
//                viewAppGenerateOTPResponses.append(deserializedResponse)
//            }
//        }
//        
//        return viewAppGenerateOTPResponses
//    }
}
