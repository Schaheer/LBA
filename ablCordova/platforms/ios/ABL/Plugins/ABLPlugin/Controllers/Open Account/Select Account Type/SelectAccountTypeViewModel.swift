//
//  SelectAccountTypeViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 08/04/2022.
//

import Foundation

protocol SelectAccountTypeViewModelProtocol {
    var accountType: Observable<AccountType?> { get }
    var purposeOfAccountList: Observable<PurposeOfAccountResponseModel?> { get }
    var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    var dropDownTapped: Observable<Bool> { get }
    var routeToSelectPreferredAccountVC: Observable<Bool> { get }
    
    func getAccountTypeID() -> Double
    func getPurposeOfAccountList(codeTypeID: Int)
    func setPurposeOfAccount(id: Double)
    func getPurposeOfAccountID() -> Double
    func getPurposeOfAccount(for index: Int) -> PurposeOfAccountDataModel?
    
    func registerConsumerAccountInfo(
        rdaCustomerAccInfoID: Double?,
        rdaCustomerID: Double?,
        bankingModeID: Double?,
        customerAccountTypeID: Double?,
        customerBranch: String?,
        customerTypeID: Double?,
        purposeOfAccountID: Double?
    )
    
    func openSelectPreferredAccountVC()
}

final class SelectAccountTypeViewModel: SelectAccountTypeViewModelProtocol {
    private(set) var accountType: Observable<AccountType?> = Observable(nil)
    private(set) var purposeOfAccountList: Observable<PurposeOfAccountResponseModel?> = Observable(nil)
    private(set) var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    private(set) var dropDownTapped: Observable<Bool> = Observable(false)
    private(set) var routeToSelectPreferredAccountVC: Observable<Bool> = Observable(false)
    
    private var purposeOfAccountID: Double = 0
    
    @objc
    func selectCurrentAccount() {
        accountType.value = .current
    }
    
    @objc
    func selectSavingsAccount() {
        accountType.value = .savings
    }
    
    @objc
    func openDropdown() {
        dropDownTapped.value = true
    }
    
    func getAccountTypeID() -> Double {
        return accountType.value?.code ?? 0
    }
    
    func getAccountType() -> AccountType {
        return accountType.value ?? .current
    }
    
    func getPurposeOfAccountList(codeTypeID: Int) {
        guard
            let purposeOfAccountInput = PurposeOfAccountInputModel(codeTypeID: codeTypeID)
        else { return }
        
        APIManager.shared.getPurposeOfAccountList(input: purposeOfAccountInput) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.purposeOfAccountList.value = value
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func setPurposeOfAccount(id: Double) {
        purposeOfAccountID = id
    }
    
    func getPurposeOfAccountID() -> Double {
        return purposeOfAccountID
    }
    
    func getPurposeOfAccount(for index: Int) -> PurposeOfAccountDataModel? {
        return purposeOfAccountList.value?.data?[index]
    }
    
    func registerConsumerAccountInfo(
        rdaCustomerAccInfoID: Double?,
        rdaCustomerID: Double?,
        bankingModeID: Double?,
        customerAccountTypeID: Double?,
        customerBranch: String?,
        customerTypeID: Double?,
        purposeOfAccountID: Double?
    ) {
        guard
            let rdaCustomerAccInfoID = rdaCustomerAccInfoID,
            let rdaCustomerID = rdaCustomerID,
            let bankingModeID = bankingModeID,
            let customerAccountTypeID = customerAccountTypeID,
            let customerBranch = customerBranch,
            let customerTypeID = customerTypeID,
            let purposeOfAccountID = purposeOfAccountID
        else { return }
        
        guard let input = RegisterConsumerAccountInfoInputModel(
            rdaCustomerAccInfoID: rdaCustomerAccInfoID,
            rdaCustomerID: Int(rdaCustomerID),
            bankingModeID: bankingModeID,
            customerAccountTypeID: customerAccountTypeID,
            customerBranch: customerBranch,
            customerTypeID: customerTypeID,
            purposeOfAccountID: purposeOfAccountID,
            genderId: modelRegistrationSteper.genderId
        ) else { return }
        
        APIManager.shared.registerConsumerAccountInfo(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.registerConsumerAccountInfoResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func openSelectPreferredAccountVC() {
        routeToSelectPreferredAccountVC.value = true
    }
}
