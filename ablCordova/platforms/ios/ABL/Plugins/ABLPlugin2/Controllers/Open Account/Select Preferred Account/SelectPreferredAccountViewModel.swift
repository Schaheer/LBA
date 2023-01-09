//
//  SelectPreferredAccountViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 12/04/2022.
//

import Foundation

protocol SelectPreferredAccountViewModelProtocol {
    var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> { get }
    var allAccounts: Observable<CodeTypeResponseModel?> { get }
    var routeToPersonalInformationVC: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    var accountVariantID: Observable<AccountVariant?> { get }
    
    func registerConsumerAccountInfo(
        rdaCustomerAccInfoID: Double?,
        rdaCustomerID: Double?,
        bankingModeID: Double?,
        customerAccountTypeID: Double?,
        customerBranch: String?,
        customerTypeID: Double?,
        proofOfIncomeInd: Int?,
        accountVariantID: Double?,
        genderId: Int?
    )
    
    func getAllAccounts(codeTypeID: Int,
                        codeDescription: String,
                        codeOrder: Int)
    func openPersonalInformationVC()
    
    func setProofOfIncomeInd(proofOfIncome: Int)
    func getProofOfIncomeInd() -> Int
    func setAccountVariantID(accountVariantID: AccountVariant)
    func getAccountVariantID() -> AccountVariant
}

final class SelectPreferredAccountViewModel: SelectPreferredAccountViewModelProtocol {
    private(set) var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> = Observable(nil)
    private(set) var allAccounts: Observable<CodeTypeResponseModel?> = Observable(nil)
    private(set) var routeToPersonalInformationVC: Observable<Bool> = Observable(false)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var accountVariantID: Observable<AccountVariant?> = Observable(nil)
    
    private var proofOfIncomeInd = 2
//    private var accountVariantID: AccountVariant = .asaanDigitalAccount
    
    func registerConsumerAccountInfo(
        rdaCustomerAccInfoID: Double?,
        rdaCustomerID: Double?,
        bankingModeID: Double?,
        customerAccountTypeID: Double?,
        customerBranch: String?,
        customerTypeID: Double?,
        proofOfIncomeInd: Int?,
        accountVariantID: Double?,
        genderId: Int?
    ) {
        guard
            let rdaCustomerAccInfoID = rdaCustomerAccInfoID,
            let rdaCustomerID = rdaCustomerID,
            let bankingModeID = bankingModeID,
            let customerAccountTypeID = customerAccountTypeID,
            let customerBranch = customerBranch,
            let customerTypeID = customerTypeID,
            let proofOfIncomeInd = proofOfIncomeInd,
            let accountVariantID = accountVariantID,
            let genderId = genderId
        else { return }
        
        guard let input = RegisterConsumerAccountInfoInputModel(
            rdaCustomerAccInfoID: rdaCustomerAccInfoID,
            rdaCustomerID: Int(rdaCustomerID),
            bankingModeID: bankingModeID,
            customerAccountTypeID: customerAccountTypeID,
            customerBranch: customerBranch,
            customerTypeID: customerTypeID,
            proofOfIncomeInd: proofOfIncomeInd,
            accountVariantID: accountVariantID
//            genderId: genderId
        ) else { return }
        
        APIManager.shared.registerConsumerAccountInfo(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                print(value)
                self.registerConsumerAccountInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func getAllAccounts(codeTypeID: Int,
                        codeDescription: String,
                        codeOrder: Int) {
        
        guard let input = GetAllAccountsInputModel(codeTypeID: codeTypeID, codeDescription: codeDescription, codeOrder: codeOrder) else { return }
        
        APIManager.shared.getAllAccounte(input: input) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                self.allAccounts.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    
    
    func addGender() {
        let consumer = DataCacheManager.shared.loadRegisterVerifyOTPResponse()?.consumerList?.last
        guard
            let customerAccInfoID = consumer!.accountInformation?.rdaCustomerAccInfoID,
            let customerProfileID = consumer!.rdaCustomerProfileID
        else { return }
        
        
        guard let consumerListInputModel = BasicInfoConsumerListInputModel(
            rdaCustomerAccInfoId: customerAccInfoID,
            rdaCustomerProfileId: customerProfileID,
            genderId: modelRegistrationSteper.genderId
        ) else { return }
        
        
        guard let registerConsumerBasicInfoInput = RegisterConsumerBasicInfoInputModel(
            consumerList: [consumerListInputModel]
        ) else { return }
        
        APIManager.shared.registerConsumerBasicInfo(input: registerConsumerBasicInfoInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                print(value)
                //  self.registerConsumerBasicInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
        
    }
    func openPersonalInformationVC() {
        routeToPersonalInformationVC.value = true
    }
    
    func setProofOfIncomeInd(proofOfIncome: Int) {
        proofOfIncomeInd = proofOfIncome
    }
    
    func getProofOfIncomeInd() -> Int {
        return proofOfIncomeInd
    }
    
    func setAccountVariantID(accountVariantID: AccountVariant) {
        self.accountVariantID.value = accountVariantID
    }
    
    func resetAccountVariantID() {
        self.accountVariantID.value = nil
    }
    
    func getAccountVariantID() -> AccountVariant {
        return accountVariantID.value ?? AccountVariant.asaanDigitalAccount
    }
    
    
    // MARK: - ModelGender
    struct ModelGender: Codable {
        let message: Message
        let data: [Datum]
    }

    // MARK: - Datum
    struct Datum: Codable {
        let id: Int
        let name, datumDescription: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case datumDescription = "description"
        }
    }

    // MARK: - Message
    struct Message: Codable {
        let status, messageDescription: String

        enum CodingKeys: String, CodingKey {
            case status
            case messageDescription = "description"
        }
    }
}
