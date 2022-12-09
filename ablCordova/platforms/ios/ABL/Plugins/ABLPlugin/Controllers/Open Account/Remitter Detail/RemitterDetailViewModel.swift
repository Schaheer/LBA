//
//  RemitterDetailViewModel.swift
//  ABL
//
//  Created by Muhammad Shayan Zahid on 28/04/2022.
//

import Foundation

protocol RemitterDetailViewModelProtocol {
    var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> { get }
    var errorMessage: Observable<String?> { get }
    
    func registerConsumerAccountInfo(
        rdaCustomerAccInfoID: Double?,
        rdaCustomerID: Double?,
        bankingModeID: Double?,
        customerAccountTypeID: Double?,
        customerBranch: String?,
        customerTypeID: Double?,
        purposeOfAccountID: Double?,
        proofOfIncomeInd: Int?,
        accountVariantID: Double?,
        atmTypeID: Double?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertID: Double?,
        natureOfAccountID: Double?,
        pdaRemitterDetailList: [PDARemitterDetailInputModel]?,
        noOfJointApplicants: Int?,
        genderId: Int?
    )
}

final class RemitterDetailViewModel: RemitterDetailViewModelProtocol {
    private(set) var registerConsumerAccountInfoResponse: Observable<RegisterConsumerAccountInfoResponseModel?> = Observable(nil)
    private(set) var errorMessage: Observable<String?> = Observable(nil)
    
    func registerConsumerAccountInfo(
        rdaCustomerAccInfoID: Double?,
        rdaCustomerID: Double?,
        bankingModeID: Double?,
        customerAccountTypeID: Double?,
        customerBranch: String?,
        customerTypeID: Double?,
        purposeOfAccountID: Double?,
        proofOfIncomeInd: Int?,
        accountVariantID: Double?,
        atmTypeID: Double?,
        transAlertInd: Int?,
        chequeBookReqInd: Int?,
        transactionalAlertID: Double?,
        natureOfAccountID: Double?,
        pdaRemitterDetailList: [PDARemitterDetailInputModel]?,
        noOfJointApplicants: Int?,
        genderId: Int?
    ) {
        guard
            let rdaCustomerAccInfoID = rdaCustomerAccInfoID,
            let rdaCustomerID = rdaCustomerID,
            let bankingModeID = bankingModeID,
            let customerAccountTypeID = customerAccountTypeID,
            let customerBranch = customerBranch,
            let customerTypeID = customerTypeID,
            let purposeOfAccountID = purposeOfAccountID,
            let proofOfIncomeInd = proofOfIncomeInd,
            let accountVariantID = accountVariantID,
            let pdaRemitterDetailList = pdaRemitterDetailList,
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
            purposeOfAccountID: purposeOfAccountID,
            accountVariantID: accountVariantID,
            atmTypeID: atmTypeID,
            transAlertInd: transAlertInd,
            chequeBookReqInd: chequeBookReqInd,
            transactionalAlertID: transactionalAlertID,
            natureOfAccountID: natureOfAccountID,
            pdaRemitterDetailList: pdaRemitterDetailList,
            noOfJointApplicants: noOfJointApplicants,
            genderId: genderId
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
}
