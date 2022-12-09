//
//  ResumeApplicationViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 30/03/2022.
//

import Foundation

protocol ResumeApplicationViewModelProtocol {
    var routeToBankingMethodVC: Observable<Bool> { get }
    var routeToAccountTypeVC: Observable<Bool> { get }
    var routeToSelectPreferredAccountVC: Observable<Bool> { get }
    var routeToPersonalInformation: Observable<Bool> { get }
    var routeToOccupationVC: Observable<Bool> { get }
    var routeToServiceChannelsVC: Observable<Bool> { get }
    var routeToPictureAndSignatureVC: Observable<Bool> { get }
    var consumerAccountDetail: Observable<RegisterVerifyOTPResponseModel?> { get }
    var updateAccountResponse: Observable<UpdateAccountResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    
    func openBankingMethodVC()
    func openAccountTypeVC()
    func openSelectPreferredAccountVC()
    func openPersonalInformationVC()
    func openOccupationVC()
    func openServiceChannelsVC()
    func openPictureAndSignatureVC()
    
    func getConsumerAccountDetail(
        rdaCustomerProfileID: Double?,
        rdaCustomerAccInfoID: Double?,
        customerTypeID: Double?
    )
    func updateAccount(customerProfileID: Double?, customerAccountInfoID: Double?)
    
    func setSelectedDraftedApp(draftedApp: GetDraftedAppsAppListModel)
    func getSelectedDraftedApp() -> GetDraftedAppsAppListModel?
}

final class ResumeAaplicationViewModel: ResumeApplicationViewModelProtocol {
    private(set) var routeToBankingMethodVC: Observable<Bool> = Observable(false)
    private(set) var routeToAccountTypeVC: Observable<Bool> = Observable(false)
    private(set) var routeToSelectPreferredAccountVC: Observable<Bool> = Observable(false)
    private(set) var routeToPersonalInformation: Observable<Bool> = Observable(false)
    private(set) var routeToOccupationVC: Observable<Bool> = Observable(false)
    private(set) var routeToServiceChannelsVC: Observable<Bool> = Observable(false)
    private(set) var routeToPictureAndSignatureVC: Observable<Bool> = Observable(false)
    private(set) var consumerAccountDetail: Observable<RegisterVerifyOTPResponseModel?> = Observable(nil)
    private(set) var updateAccountResponse: Observable<UpdateAccountResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    private var selectedDraftedApp: GetDraftedAppsAppListModel?
    
    func openBankingMethodVC() {
        routeToBankingMethodVC.value = true
    }
    
    func openAccountTypeVC() {
        routeToAccountTypeVC.value = true
    }
    
    func openSelectPreferredAccountVC() {
        routeToSelectPreferredAccountVC.value = true
    }
    
    func openPersonalInformationVC() {
        routeToPersonalInformation.value = true
    }
    
    func openOccupationVC() {
        routeToOccupationVC.value = true
    }
    
    func openServiceChannelsVC() {
        routeToServiceChannelsVC.value = true
    }
    
    func openPictureAndSignatureVC() {
        routeToPictureAndSignatureVC.value = true
    }
    
    func getConsumerAccountDetail(
        rdaCustomerProfileID: Double?,
        rdaCustomerAccInfoID: Double?,
        customerTypeID: Double?
    ) {
        guard
            let rdaCustomerProfileID = rdaCustomerProfileID,
            let rdaCustomerAccInfoID = rdaCustomerAccInfoID,
            let customerTypeID = customerTypeID
        else { return }
        
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
    
    func updateAccount(customerProfileID: Double?, customerAccountInfoID: Double?) {
        guard
            let customerProfileID = customerProfileID,
            let customerAccountInfoID = customerAccountInfoID
        else { return }
        
        guard let input = UpdateAccountInputModel(customerProfileID: customerProfileID, customerAccountInfoID: customerAccountInfoID) else { return }
        APIManager.shared.updateAccount(input: input) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case .success(let value):
                self.updateAccountResponse.value = value
            case .failure(let error):
                self.errorMessage.value = error.errorDescription
            }
        }
    }
    
    func setSelectedDraftedApp(draftedApp: GetDraftedAppsAppListModel) {
        selectedDraftedApp = draftedApp
    }
    
    func getSelectedDraftedApp() -> GetDraftedAppsAppListModel? {
        return selectedDraftedApp
    }
}
